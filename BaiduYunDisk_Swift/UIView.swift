//
//  UIView.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/19.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit




// MARK: - 扩展UIView方便添加点击事件。除上此方法还有如下方法：
//子类化UIView 重写它的触摸事件即可
extension UIView {
    
    func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gr)
    }
    
}


//class UIViewEffect : UIView {
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        backgroundColor = UIColor.groupTableViewBackgroundColor()
//    }
//    
//    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
//        UIView.animateWithDuration(0.15, animations: { () -> Void in
//            self.backgroundColor = UIColor.clearColor()
//        })
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        UIView.animateWithDuration(0.15, animations: { () -> Void in
//            self.backgroundColor = UIColor.clearColor()
//        })
//    }
//}
