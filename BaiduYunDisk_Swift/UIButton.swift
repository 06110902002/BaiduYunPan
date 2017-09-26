//
//  UIButton.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/25.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit




// MARK: - 本类主要处理按钮随文本宽度自适应
extension UIButton{

    
    /**
     类方法，根据宽度，计算高度
     
     @param width 输入宽度
     @param title 文本内容
     @param font 字体属性
     @return 计算后的高度
     */
    class func getHeightByWidth(width : CGFloat, title : String, font : UIFont) -> CGFloat{
    
        let button : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 0))
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.sizeToFit()
        button.titleLabel?.numberOfLines = 0
        
        return button.frame.size.height
    }
    
    
    /**
     根据文本内容计算宽度
     
     @param title 文本内容
     @param font 字体属性
     @return 计算后的宽度
     */
    class func getWidthWithTitle(title : String, font : UIFont) -> CGFloat{
    
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
//        label.text = title;
//        label.font = font;
//        [label sizeToFit];
//        return label.frame.size.width;
        
        
        let button : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.sizeToFit()
        
        return button.frame.size.width
    }
    
}
