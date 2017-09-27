//
//  ProgressBarView.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/26.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit


/// 本类实现进度条视图 使用CALayer+动画的方式实现
class ProgressBarView: UIView {
    
    
    var curProgress : CGFloat = 0
    
    lazy var progressBgLayer : CAShapeLayer = CAShapeLayer()
    lazy var forBgLayer : CAShapeLayer = CAShapeLayer()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgressBgAttr(color : UIColor,height : CGFloat) {
    
        progressBgLayer.bounds = CGRect.init(x: 0, y: 0, width: self.frame.width, height: height)
        progressBgLayer.backgroundColor = color.cgColor
        progressBgLayer.cornerRadius = height / 2
        progressBgLayer.anchorPoint = CGPoint.init(x: 0, y: 0)
        self.layer.addSublayer(progressBgLayer)
    }
    
    func setProgressForAttr(color : UIColor,height : CGFloat) {
        
    
        forBgLayer.bounds = CGRect.init(x: 0, y: 0, width: 0, height: height)
        forBgLayer.backgroundColor = color.cgColor
        forBgLayer.cornerRadius = height / 2
        forBgLayer.anchorPoint = CGPoint.init(x: 0, y: 0)
        self.layer.addSublayer(forBgLayer)
        
    }
    
    func setProgress(progress : CGFloat,duration : TimeInterval) {
        
        if  curProgress > self.frame.width {
            
            return
        }
        
        
        UIView.animate(withDuration: duration, animations: {[unowned self] in
            
            self.forBgLayer.bounds = CGRect.init(x: 0, y: 0, width: self.curProgress + progress, height: self.forBgLayer.bounds.height)
            
        }, completion: {[unowned self] (true) -> Void in
            
            self.curProgress = self.forBgLayer.frame.width
        })
    }
    
    
    
    
}
