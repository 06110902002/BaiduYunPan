//
//  ScrollNavBar.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/25.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit

protocol ScrollNavBarChangeListener {
    
    func onChangeListener(index : Int) -> Void
}


/// 带标签滑动的滚动视图
class ScrollNavBar: UIView {
    
    var delegate : ScrollNavBarChangeListener?
    
    lazy var bottomLine : UIView = UIView.init()
    
    lazy var titleList : Array = Array<String>()
    
    lazy var btnList : Array = Array<UIButton>()
    
    lazy var titleScrollView : UIScrollView = UIScrollView.init()
    
    
    lazy var moveAnimation : CABasicAnimation = {(make) in
    
        let tmpAnim = CABasicAnimation.init(keyPath: "position")
        
        return tmpAnim
    
    }()
    
    var nLastIndex : Int = 0
    
    lazy var segmentScroll : UIScrollView = UIScrollView.init()
    
    var finalPos : CGPoint = CGPoint.zero
    
    var screenSize : CGRect = CGRect.zero
    
    var bIsTitleScroll : Bool = false
    lazy var averageItemWidth : CGFloat = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 初始标题栏
    ///
    /// - Parameters:
    ///   - titles: 标题列表
    ///   - isScroll: 标题栏是否可滑动开关,这个开关在这里主要是控制底部下划线宽度与滚动列表横向滚动的尺寸
    
    func initTitle(titles : Array<String>,isScroll : Bool) {
        
        if titles.isEmpty {
           return
        }
        
        self.bIsTitleScroll = isScroll
        
        screenSize = UIScreen.main.bounds
        
        self.titleList = titles
        
        //创建标题滚动视图
        titleScrollView.frame = CGRect.init(x: 0, y: 20, width: screenSize.width, height: 42)
        titleScrollView.alwaysBounceHorizontal = true
        titleScrollView.showsHorizontalScrollIndicator = false
        titleScrollView.backgroundColor = UIColor.init(red: 66.0 / 255.0, green: 133.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
        
        self.addSubview(titleScrollView)
        
        if !isScroll{
            averageItemWidth = titleScrollView.frame.width / CGFloat(titles.count)
        }
        
        
        var offsetX : CGFloat = 0
        var contentSize : CGFloat = 0
        
        for (idx,title) in self.titleList.enumerated(){
            
            if isScroll{
            
                if idx == 0{
                    offsetX = 0
                }else{
                    offsetX = self.btnList[idx - 1].frame.size.width + self.btnList[idx - 1].frame.origin.x
                }
            }
            
            let button : UIButton = UIButton.init(frame:CGRect.init(x: CGFloat(idx) * averageItemWidth, y: 0, width: averageItemWidth, height: 40))
            button.tag = idx
            button.addTarget(self, action: #selector(onClickListener(btn:)), for:.touchUpInside)
            button.setTitle(title, for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitleColor(UIColor.white, for: .normal)
            
            
            if isScroll{
                
                let tmpWidth : CGFloat = UIButton.getWidthWithTitle(title: title, font: UIFont.systemFont(ofSize: 12)) + 20
                button.frame = CGRect.init(x: offsetX, y: 0, width: tmpWidth, height: 40)
                contentSize += tmpWidth
            }
            
            
            
            titleScrollView.addSubview(button)
            self.btnList.append(button)
            
        }
        if isScroll{
            titleScrollView.contentSize = CGSize.init(width:contentSize, height: 42)
            
        }else{
            titleScrollView.contentSize = CGSize.init(width:CGFloat(titles.count) * averageItemWidth, height: 42)
        }
        
        
        //创建底部线条
        let lineRect : CGRect = CGRect.init(x: 0,
                                            y: 40,
                                        width: isScroll == true ? self.btnList[0].frame.size.width : averageItemWidth,
                                        height: 1.5)
        
        bottomLine.frame = lineRect
        bottomLine.backgroundColor = UIColor.white
        titleScrollView.addSubview(bottomLine)
        
        
        
    }
    
    func initSegmentView(views : Array<Any>) {
        
        if views.count == 0 {
            return
        }
        
        self.segmentScroll = UIScrollView.init(frame:CGRect.init(x: 0, y: 62.5, width: screenSize.width, height: screenSize.height))
        self.segmentScroll.contentSize = CGSize.init(width: screenSize.width * CGFloat(views.count), height: screenSize.height)
        self.segmentScroll.alwaysBounceHorizontal = true
        self.segmentScroll.isPagingEnabled = true
        self.addSubview(self.segmentScroll)
        
        self.segmentScroll.addObserver(self, forKeyPath: "contentOffset", options: [.new,.old], context: nil)
        
        for (idx, layout) in views.enumerated(){
        
            if(idx > views.count){
            
                break
            }
            
            self.segmentScroll.addSubview(layout as! UIView)
        }
        
    }
    

    
    func onClickListener(btn : UIButton?)  {
        
        if (delegate != nil) {
            delegate?.onChangeListener(index: btn!.tag)
        }
        
        self.segmentScroll.scrollRectToVisible(CGRect.init(x: CGFloat(btn!.tag) * self.segmentScroll.frame.width,
                                                           y: self.segmentScroll.frame.origin.y,
                                                       width: self.segmentScroll.frame.width,
                                                      height: self.segmentScroll.frame.height),
                                                    animated: true)
        
        let lastItemWidth : CGFloat = self.btnList[self.nLastIndex].frame.width
        
        let curItemWidth : CGFloat = self.btnList[btn!.tag].frame.width
        
        var fromValue : NSValue?
        
        var toValue : NSValue?
        
        if self.bIsTitleScroll{
            
             fromValue = NSValue.init(cgPoint: CGPoint.init(x: self.btnList[self.nLastIndex].frame.origin.x + 0.5 * lastItemWidth,
                                                                         y: 40))
            
             toValue = NSValue.init(cgPoint: CGPoint.init(x: self.btnList[btn!.tag].frame.origin.x + 0.5 * curItemWidth,
                                                                       y: 40))
        }else{
            
             fromValue = NSValue.init(cgPoint: CGPoint.init(x: CGFloat(self.nLastIndex) * averageItemWidth + 0.5 * averageItemWidth,
                                                                         y: 40))
            
             toValue  = NSValue.init(cgPoint: CGPoint.init(x: CGFloat(btn!.tag) * averageItemWidth + 0.5 * averageItemWidth,
                                                                       y: 40))
        }
       
        
        startLineMoveAnimFromValue(fromValue: fromValue!, toValue: toValue!, duration: 0.3)
        
        titleLabelMoveLogic(curBtnIdx: btn!.tag)
        
        self.nLastIndex = btn!.tag
        
        updateTitleBtnStatus(idx: btn!.tag)
        
        
        guard self.bIsTitleScroll == true else {
            self.finalPos = CGPoint.init(x : CGFloat(btn!.tag) * averageItemWidth + 0.5 * averageItemWidth, y : 40)
            return
        }
        
        self.finalPos = CGPoint.init(x:curItemWidth + 0.5 * curItemWidth, y: 40)
        
        
       
    }
    
    
    /// 处理标签滑动逻辑：
    /// - Parameters:
    ///   - curBtnIdx: 点击的当前标签
    /// 对于可以滑动，需要重新调整可见视图
    func titleLabelMoveLogic(curBtnIdx : Int) {
        
        if !self.bIsTitleScroll {return}
        
        self.titleScrollView.scrollRectToVisible(CGRect.init(x: self.btnList[curBtnIdx].frame.origin.x,
                                                             y: 0,
                                                         width: self.titleScrollView.frame.size.width,
                                                        height: self.titleScrollView.frame.size.height),
                                                      animated: true)
    }
    
    
    func updateTitleBtnStatus(idx : Int){
        
        for(index, button) in self.btnList.enumerated(){
        
            if idx == index {
            
                button.setTitleColor(UIColor.init(red: 118 / 255, green: 198 / 255, blue: 192 / 255, alpha: 1.0), for: .normal)
            }else {
            
                button.setTitleColor(UIColor.white, for: .normal)
            }
        
        }
        
        if self.bIsTitleScroll {        //对于标题栏可以滑动，需要重新调整底部下划线的宽度
            resetBottomLineWidth(idx: idx)
        }
        
    }
    
    
    /// 调整顶部标签的宽度:主要根据点击的按钮宽度来更新标签的宽度
    ///
    /// - Parameter idx: 宽度id 因为按钮id与其在列表中索引一致，所以可以直接用id作索引
    func resetBottomLineWidth(idx : Int) {
        
        let btnWidth : CGFloat = self.btnList[idx].frame.width
        
        bottomLine.frame = CGRect.init(x: bottomLine.frame.origin.x, y: bottomLine.frame.origin.y, width: btnWidth, height: bottomLine.frame.size.height)
        
    }
    
    func startLineMoveAnimFromValue(fromValue : Any, toValue : Any, duration:CFTimeInterval) {
        
        moveAnimation.fromValue = fromValue
        moveAnimation.toValue = toValue
        moveAnimation.delegate = self as CAAnimationDelegate
        moveAnimation.isRemovedOnCompletion = false
        moveAnimation.fillMode = kCAFillModeForwards
        moveAnimation.duration = duration
        
        bottomLine.layer.removeAllAnimations()
        bottomLine.layer.add(moveAnimation, forKey: "onStart")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        

        let newPos : CGPoint = change?[NSKeyValueChangeKey.newKey] as! CGPoint
        
        self.nLastIndex = Int(newPos.x / self.segmentScroll.frame.width);
        
        self.bottomLine.layer.removeAllAnimations()
        
        if self.bIsTitleScroll{
            
            self.bottomLine.frame = CGRect.init(x: self.btnList[self.nLastIndex].frame.origin.x,
                                                y: self.bottomLine.frame.origin.y,
                                                width: 0,
                                                height: 1.5)
        }else{
        
            var frame : CGRect = self.bottomLine.frame
            frame.origin.x = CGFloat(self.nLastIndex) * averageItemWidth
            self.bottomLine.frame = frame;
        }
        
        
        self.bottomLine.layoutIfNeeded()
        
        titleLabelMoveLogic(curBtnIdx: self.nLastIndex)
        
        updateTitleBtnStatus(idx: self.nLastIndex)
        
    }
    
     deinit{
    
        self.segmentScroll.removeObserver(self, forKeyPath: "contentOffset")
    }
    
}

extension ScrollNavBar : ScrollNavBarChangeListener,CAAnimationDelegate{
    
    func onChangeListener(index: Int) {
        
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if bottomLine.layer.animationKeys()?.last == "onStart" {
        
            var frame : CGRect = bottomLine.frame
            frame.origin.x = finalPos.x
            bottomLine.frame = frame
        }
    }

    

}
