//
//  BaseRefreshHeadView.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit

enum PullDownRefresh : Int {
    
    case Normal
    
    case Refreshing
    
    case Complete
}


/// UIScrollView 刷新头部基类视图
class BaseRefreshHeadView: UIView {
    
    
    var kRefreshViewHeight : Int = 80
    
    var MarginForRefrshing : Int = 60
    
    var labelRefresh : UILabel?
    
    var scrollView : UIScrollView?
    
    var PullDownRefreshBlock : () -> Void = {() -> Void in
        
        print("原始的下拉刷新回调,需要外部扩展")
    }
    
    var pullDownRefreshState : PullDownRefresh = .Normal
    
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y : -kRefreshViewHeight, width:Int(UIScreen.main.bounds.width),height:kRefreshViewHeight))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addTargetWith(scrollView : UIScrollView){
        
        self.scrollView = scrollView
        self.scrollView?.insertSubview(self, at: 0)
        self.scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [.new, .old], context: nil)
        
        self.initView()
        
    }
    
    
    
    /// 此接口设置具体的视图，需要子类扩展
    func initView(){
    
        self.labelRefresh = UILabel(frame:CGRect(x : 0, y : 0, width:self.frame.width, height : 40))
        self.labelRefresh?.text = "下拉刷新数据"
        self.labelRefresh?.textColor = UIColor.green
        self.labelRefresh?.textAlignment = NSTextAlignment.center
        self.labelRefresh?.font = UIFont.systemFont(ofSize: 12)
        self.insertSubview(self.labelRefresh!, at: 0)
    }
    
    func setRefreshState(refreshState : PullDownRefresh){
        
        if(self.pullDownRefreshState != refreshState){
            
            self.pullDownRefreshState = refreshState
        }
        
        switch self.pullDownRefreshState {
            
        case .Normal:
            //self.labelRefresh?.text = "下拉刷新数据"
            
            guard let labelTips = self.labelRefresh else {
                return
            }
            labelTips.text = "下拉刷新数据"
            
            break;
            
        case .Refreshing:
            
            //self.labelRefresh?.text = "正在刷新,请稍后..."
            
            guard let labelTips = self.labelRefresh else {
                return
            }
            labelTips.text = "正在刷新,请稍后..."
            
            break;
            
        case .Complete:
            
            //self.labelRefresh?.text = "刷新完成"
            guard let labelTips = self.labelRefresh else {
                return
            }
            labelTips.text = "刷新完成"
            
            break;
            
        }
        
    }
    
    func refrsh(block:@escaping () -> Void = {}){
        self.PullDownRefreshBlock = block
    }
    
    func refreshComplete(){
        setRefreshState(refreshState: .Complete)
        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.scrollView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
//        })
        
        UIView.animate(withDuration: 0.5, animations: {
            
          self.scrollView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }, completion: {(true) -> Void in
        
            self.onEnd()
        
        })
    }
    
    
    /// 传递scrollView位移数据，处理根据位移进行动态变化的动画
    ///
    /// - Parameter contentOffset: scrollView位移数据
    func onScrollChangeListener(contentOffset:CGPoint) {
        
    }
    
    
    /// 控制刷新动画接口，一般需要子类重载
    func onRefreshing() {
        
    }
    
    func onEnd(){
    
    }
    
    //使用kvo进行监听
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if(keyPath! == "contentOffset"){
            
            if(self.pullDownRefreshState == .Refreshing){
                
                return
            }
            
            let contentOffset:CGPoint = change?[NSKeyValueChangeKey.newKey] as! CGPoint
            
            onScrollChangeListener(contentOffset: contentOffset)
            
            if(MarginForRefrshing + Int(contentOffset.y) <= 0){
                
                if(!(self.scrollView?.isTracking)!){
                    
                    setRefreshState(refreshState: .Refreshing)
                    UIView.animate(withDuration: 0.5, animations: {
                    
                        self.scrollView?.contentInset = UIEdgeInsetsMake(self.frame.height, 0, 0, 0)
                    })
                    
                    PullDownRefreshBlock()
                    onRefreshing()
                    
                }
                
            }
            
        }
    }
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    
}

//extension BaseRefreshHeadView : UIScrollViewDelegate{
//
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        if(self.pullDownRefreshState == .Refreshing){
//            
//            return
//        }
//
//        
//        let contentOffset:CGPoint = scrollView.contentOffset
//        
//        onScrollChangeListener(contentOffset: contentOffset)
//        
//        if(MarginForRefrshing + Int(contentOffset.y) <= 0){
//            
//            if(!(self.scrollView?.isTracking)!){
//                
//                setRefreshState(refreshState: .Refreshing)
//                UIView.animate(withDuration: 0.5, animations: {
//                    
//                    self.scrollView?.contentInset = UIEdgeInsetsMake(self.frame.height, 0, 0, 0)
//                })
//                
//                PullDownRefreshBlock()
//                onRefreshing()
//            }
//            
//        }
//
//    }
//
//}














