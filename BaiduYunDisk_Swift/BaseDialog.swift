//
//  BaseDialog.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit
import SnapKit


/**
 对话框基类:弹出的视图添加父视图的中间位置
 
 
 */
class BaseDialog : UIView{

    //使用闭包作单例
    static var getInstance : () -> BaseDialog = {() -> BaseDialog in
    
        return BaseDialog.init(frame: CGRect.init(x : 0, y : 0, width : UIScreen.main.bounds.width,
                                                  height : UIScreen.main.bounds.height))
    }
    
    lazy var backgroundView : UIView = UIView.init(frame: CGRect.init(x : 0, y : 0, width : UIScreen.main.bounds.width,
                                                                      height : UIScreen.main.bounds.height))
    
    var bIsOutSideCloseDialog : Bool = false        //点击其他地方是否关闭对话框
    
    lazy var menuItemPanel : UIView = UIView()
    
    lazy var labelTitle : UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 初始化视图子类，可以扩展
    func initView() {
        
        //self.alpha  = 0
        
        //初始背景视图
        self.addSubview(backgroundView)
        backgroundView.backgroundColor = UIColor.init(red: 97 / 255, green: 100 / 255, blue: 99 / 255, alpha: 0.5)
        backgroundView.addOnClickListener(target: self, action: #selector(onCloseDialog))
        
        //初始菜单背景视图
        self.addSubview(menuItemPanel)
        setMenuItemBgColor()
        setMenuPanelSize(leftMargin: 20,rightMargin: 20, height : 360)
    }
    
    
    
    /// 当子类需要调整尺寸时，需要重载本接口
    ///
    /// - Parameters:
    ///   - leftMargin: 左边距
    ///   - rightMargin: 右边距
    ///   - height: 高度
    func setMenuPanelSize(leftMargin : Int, rightMargin : Int, height : Int)  {
        
        menuItemPanel.snp.remakeConstraints({(make) in
            
                make.center.equalToSuperview()
                make.left.equalTo(leftMargin)
                make.right.equalTo(-rightMargin)
                make.height.equalTo(height)
            
            })
        
    }
    
    func setMenuItemBgColor(){
    
         menuItemPanel.backgroundColor = UIColor.init(red: 49 / 255, green: 59 / 255, blue: 72 / 255, alpha: 1.0)
    }
    
    func setTitle(title:String) {
        
        labelTitle.textColor = UIColor.white
        labelTitle.font = UIFont.systemFont(ofSize: 16)
        labelTitle.text = title
        labelTitle.textAlignment = NSTextAlignment.center
        menuItemPanel.addSubview(labelTitle)
        
        labelTitle.snp.makeConstraints({(make) in
        
            make.leading.equalTo(menuItemPanel)
            make.trailing.equalTo(menuItemPanel)
            make.top.equalToSuperview().offset(15)
            
        
        })
        
    }
    
    func setOutSideCloseDialog(close : Bool) {
    
        self.bIsOutSideCloseDialog = close
    }
    
    
    /// 展示本视图,子类可以重载本接口，实现不同的动画效果
    ///
    /// - Parameter parentView: 将本视图添加到的父视图
    func show(parentView : UIView?) {
        
        if let parent = parentView{
            
            parent.addSubview(self)
            
            UIView.animate(withDuration: 0.3, animations: {[unowned self] in
                 self.alpha = 1.0
            
            }, completion: {(true) -> Void in
            
            })
            
           
        }
        
    }
    
    func onCloseDialog(){
    
        if self.bIsOutSideCloseDialog{
        
            dissmiss()
        }
    }
    
    //子类可以重载本接口，实现不同的动画效果
    func dissmiss() {
        
        UIView.animate(withDuration: 0.2, animations: {[unowned self] in
            
            self.alpha = 0.0
            
        }, completion: {[unowned self](true) -> Void in
            
            self.removeFromSuperview()
            
        })
        
    }
    
    
    

}
