//
//  CountDownView.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/27.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit

protocol CountDownListener {
    
    func onEnd()
}


/// 倒计时视图
class CountDownView: UIView {
    
    
    lazy var circleLayer : CAShapeLayer  = CAShapeLayer()
    
    lazy var textLayer : CATextLayer  = CATextLayer()
    
    lazy var centerPos : CGPoint = {[unowned self]() -> CGPoint in
    
        return CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2)
    }()
    
    var countDownTimer : Timer?
    
    var countDownListener : CountDownListener?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    
    }
    
    func setCircleAttr(radius : CGFloat,color: UIColor,strokWidth : CGFloat){
    
        let path : UIBezierPath = UIBezierPath.init()
        path.addArc(withCenter: centerPos, radius: radius, startAngle: 0, endAngle: 3.1415926 * 2, clockwise: true)
        
        circleLayer.lineWidth = strokWidth
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.green.cgColor
        
        self.layer.addSublayer(circleLayer)
    }
    
    func setTextAttr(initText : String, color : UIColor, font : UIFont,size : CGSize){
    
        //初始文本视图
        textLayer.frame = CGRect.init(x: centerPos.x - size.width / 2,
                                      y: centerPos.y - size.height / 2,
                                  width: size.width,
                                 height: size.height)
        
        
        textLayer.foregroundColor = color.cgColor;
        //textLayer.backgroundColor = UIColor.orange.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.isWrapped = true;
        textLayer.font = font
        //textLayer.fontSize = 12
        textLayer.string = initText
        
        textLayer.contentsScale = UIScreen.main.scale;
        
        self.layer.addSublayer(textLayer)
    }
    
    
    func startCountDown(duration : TimeInterval) {
        
        let countDownAnim : CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        countDownAnim.duration = duration
        countDownAnim.fromValue = 0.0
        countDownAnim.toValue = 1.0
        //countDownAnim.delegate = self as CAAnimationDelegate
        countDownAnim.fillMode = kCAFillModeForwards
        countDownAnim.isRemovedOnCompletion = false
        countDownAnim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        circleLayer.add(countDownAnim, forKey: "")
        
        var countDown : Int = Int(duration)
        
        countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[unowned self] (Timer) -> Void in
        
            self.textLayer.string  = String.init(format: "%d", countDown)
            countDown = countDown - 1
            
            if countDown <= 0 {
                
                if let end = self.countDownListener{
                    end.onEnd()
                }
                self.countDownTimer?.invalidate()
                self.countDownTimer = nil
                
            }
        })
    
        
    }
    
}


////测试一个倒计时
//let countDowm : CountDownView = CountDownView.init(frame: CGRect.init(x: self.getScreenSize().width / 2 - 100, y: self.getScreenSize().height / 2 - 100, width: 100, height: 100))
//
//countDowm.setCircleAttr(radius: 25, color: UIColor.green, strokWidth: 2.0)
//
//countDowm.setTextAttr(initText: "10",
//                      color: UIColor.black,
//                      font: UIFont.systemFont(ofSize: 13),
//                      size: CGSize.init(width: 50, height: 50))
//
//countDowm.countDownListener = self
//countDowm.startCountDown(duration: 10)
//
//countDowm.backgroundColor = UIColor.gray
//
//self.view.addSubview(countDowm)



