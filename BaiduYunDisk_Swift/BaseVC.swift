//
//  BaseVC.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/19.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import Foundation
import UIKit


/// 基类视图控制器，所有视图控制器均需扩展此类
class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    
    /// 设置状态栏背景颜色
    /// 需要设置的页面需要重载此方法
    /// - Parameter color: 颜色
    func setStatusBarBackground(color:UIColor) -> Void {
        
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }
    
    
    /// 设置状态栏字体颜色,需要在info.plist中设置UIViewControllerBasedStatusBarAppearance属性为NO
    ///
    /// - Parameter style: 样式
    func setStatusFontStyle(style:UIStatusBarStyle) -> Void {
        UIApplication.shared.statusBarStyle = style;
    }
    
    /// 获取屏幕尺寸
    ///
    /// - Returns: 屏幕尺寸
    func getScreenSize() -> CGRect {
        
        return UIScreen.main.bounds;
    }

    
}
