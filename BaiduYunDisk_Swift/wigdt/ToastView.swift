//
//  ToastView.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/27.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit



/// wegt结构体来控制提示文本的信息
struct TextTipsInfo {
    
    var position : CGRect
    
    var color : UIColor
    
    var font : UIFont
    
    var text : String
    
    var fontSize : CGFloat
}

/// 类似安卓Toast对象
class ToastView: UIView {
    
    
    lazy var textLayer : (TextTipsInfo) ->VerticalTextLayer = {(textInfo : TextTipsInfo) -> VerticalTextLayer in
    
        let tmpLayer : VerticalTextLayer = VerticalTextLayer()
        tmpLayer.frame = CGRect.init(x: textInfo.position.origin.x,
                                     y: textInfo.position.origin.y,
                                 width: textInfo.position.size.width,
                                height: textInfo.position.size.height)
        
        tmpLayer.foregroundColor = textInfo.color.cgColor;
        tmpLayer.alignmentMode = kCAAlignmentCenter;
        tmpLayer.isWrapped = true;
        tmpLayer.font = textInfo.font
        tmpLayer.fontSize = textInfo.fontSize
        tmpLayer.string = textInfo.text
        
        tmpLayer.contentsScale = UIScreen.main.scale;
        
        return tmpLayer
    
    }
    
    lazy var circleLayer : CAShapeLayer = CAShapeLayer()
    
    lazy var successLayer : CAShapeLayer = CAShapeLayer()
    
    lazy var failLayer : CAShapeLayer = CAShapeLayer()
    
    lazy var centerPos : CGPoint = {[unowned self]() -> CGPoint in
        
        return CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2 - 10)
    }()
    
    lazy var animate : CABasicAnimation = {() -> CABasicAnimation in
    
        let anim :  CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        anim.duration = 0.7
        anim.fromValue = 0.0
        anim.toValue = 1.0
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        anim.delegate = self as CAAnimationDelegate
        anim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        
        return anim
        
    }()
    
    lazy var bIsSuccess : Bool = false      //当使用动画模式时，是否播放成功动画
    
    var bIsPureTypeModel : Bool = false     //是否为纯文本模式

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAnimLayer(success : Bool) {
        
        setCircleAttr(radius: 25, color: UIColor.green, strokWidth: 2.0)
        
        guard success else {
            setFailLayer(color: UIColor.green, strokWidth: 2.0)
            return
        }
        setSuccessLayer(color: UIColor.green, strokWidth: 2.0)
        
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
    
    func setSuccessLayer(color : UIColor, strokWidth : CGFloat) {
        
        
        let successPath : UIBezierPath = UIBezierPath.init()
        successPath.move(to: CGPoint.init(x: centerPos.x - 15, y: centerPos.y - 10))         //线的表达式为： y  = k *x + 5 其中 k = -1
        successPath.addLine(to: CGPoint.init(x: centerPos.x - 2, y: centerPos.y + 3))
        
        successPath.move(to:  CGPoint.init(x: centerPos.x - 2, y: centerPos.y + 3))          //线的表达式为： y  = -k * x  其中 k = -1
        successPath.addLine(to:  CGPoint.init(x: centerPos.x + 15, y: centerPos.y - 15))
        
        successLayer.lineWidth = strokWidth
        successLayer.path = successPath.cgPath
        successLayer.fillColor = UIColor.clear.cgColor
        successLayer.strokeColor = color.cgColor
        successLayer.strokeEnd = 0.0
        
        self.layer.addSublayer(successLayer)
        
    }
    
    func setFailLayer(color : UIColor, strokWidth : CGFloat) {

        let failPath : UIBezierPath = UIBezierPath.init()
        failPath.move(to: CGPoint.init(x: centerPos.x - 12.5, y: centerPos.y - 12.5))         //线的表达式为： y  = k *x +
        failPath.addLine(to: CGPoint.init(x: centerPos.x + 12.5, y: centerPos.y + 12.5))        //每一条线的斜率 = 1
        
        failPath.move(to:  CGPoint.init(x: centerPos.x - 12.5, y: centerPos.y + 12.5))          //线的表达式为： y  = -k * x  其中 k = -1
        failPath.addLine(to:  CGPoint.init(x: centerPos.x + 12.5, y: centerPos.y - 12.5))
        
        failLayer.lineWidth = strokWidth
        failLayer.path = failPath.cgPath
        failLayer.fillColor = UIColor.clear.cgColor
        failLayer.strokeColor = color.cgColor
        failLayer.strokeEnd = 0.0
        self.layer.addSublayer(failLayer)
    }
    
    func setTextLayer(textInfo : TextTipsInfo){
        
        self.layer.addSublayer(textLayer(textInfo))
    }

    
    func toast(success : Bool,withTitle : String) {
        
        self.bIsSuccess = success
        initAnimLayer(success:success)
        circleLayer.add(animate, forKey: "circleAnim")
        
        setTextLayer(textInfo: TextTipsInfo.init(position: CGRect.init(x: centerPos.x - self.frame.width / 2,
                                                                       y: self.frame.height - 30,
                                                                       width: self.frame.width,
                                                                       height: 30),
                                                 color: UIColor.white,
                                                 font: UIFont.systemFont(ofSize: 2),
                                                 text: withTitle,
                                                 fontSize: 14))
        
    }
    
    
    /// 只显示文本模式
    ///
    /// - Parameters:
    ///   - text: 文本内容
    ///   - color: 字体颜色
    ///   - font: 字体信息
    ///   - size: 画笔大小
    func toastOnly(text : String) {
        

        setTextLayer(textInfo: TextTipsInfo.init(position: CGRect.init(x: centerPos.x - self.frame.width / 2,
                                                                       y: centerPos.y - 40 / 2,
                                                                       width: self.frame.width,
                                                                       height: 40),
                                                 color: UIColor.white,
                                                 font: UIFont.systemFont(ofSize: 2),
                                                 text: text,
                                                 fontSize: 14))
        
        recycRes()
    }
    
    
    func recycRes() {
        
        let time: TimeInterval = 1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {[unowned self] in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.alpha = 0
                
            }, completion: {(true) -> Void in
                
                self.removeFromSuperview()
            })
        }

    }
    
}

extension ToastView : CAAnimationDelegate{

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if(anim == circleLayer.animation(forKey: "circleAnim")){
        
            guard self.bIsSuccess else {
                failLayer.add(animate, forKey: "failAnim")
                return
            }
            successLayer.add(animate, forKey: "successAnim")
            
        }else if(anim == successLayer.animation(forKey: "successAnim") || anim == failLayer.animation(forKey: "failAnim")){
        
            recycRes()
        }
    }
}




/// 本类使用CATextLayer文本垂直居中
class VerticalTextLayer : CATextLayer{

    
    override func draw(in ctx: CGContext) {
        let fontSize = self.fontSize
        let height = self.bounds.size.height
        let deltaY = (height-fontSize)/2 - fontSize/6
        
        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: deltaY)
        super.draw(in: ctx)
        ctx.restoreGState()
    }

}










