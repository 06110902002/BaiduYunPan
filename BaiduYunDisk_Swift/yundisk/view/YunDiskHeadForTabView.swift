//
//  YunDiskHeadForTabView.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit


//首页网盘刷新列表的头部视图
class YunDiskHeadForTabView: BaseRefreshHeadView {
    
    
    let PI : CGFloat = 3.1415926
    let radius : CGFloat = 20.0
    
    lazy var labelTime : UILabel = UILabel()
    
    //动画用的图层
    lazy var leftArcLayer : CAShapeLayer = CAShapeLayer();
    lazy var rightArcLayer : CAShapeLayer = CAShapeLayer();
    lazy var topPointLayer : CAShapeLayer = CAShapeLayer();
    lazy var bottomPointLayer : CAShapeLayer = CAShapeLayer();
    
    var lastOffsetY : Int = 0
    var curOffsetY : Int = 0
    
    var bIsStop : Bool = false;
    
    //动画对象
    lazy var topMoveAnim : CABasicAnimation = {() -> CABasicAnimation in
    
        let center = CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        let moveAnim = CABasicAnimation.init(keyPath: "position")
        moveAnim.fromValue = NSValue.init(cgPoint: center)
        moveAnim.toValue = NSValue.init(cgPoint: CGPoint.init(x: center.x, y: center.y - self.radius))
        moveAnim.duration = 0.5
        moveAnim.delegate = self as CAAnimationDelegate
        
        moveAnim.fillMode = kCAFillModeForwards;
        moveAnim.isRemovedOnCompletion = false;
        
        moveAnim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        moveAnim.setValue("positionAnimation", forKey: "moveAnim")
        
        return moveAnim
    
    }()
    
    lazy var bottomAnim : CABasicAnimation = {() -> CABasicAnimation in
    
        let center = CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        let tmpAnim = CABasicAnimation.init(keyPath: "position")
        tmpAnim.fromValue = NSValue.init(cgPoint: center)
        tmpAnim.toValue = NSValue.init(cgPoint: CGPoint.init(x: center.x, y: center.y + self.radius))
        tmpAnim.duration = 0.5
        tmpAnim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        tmpAnim.fillMode = kCAFillModeForwards;
        tmpAnim.isRemovedOnCompletion = false;
        
        return tmpAnim;
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addTargetWith(scrollView: UIScrollView) {
        super.addTargetWith(scrollView: scrollView)
        
        initView()
        
    }
    
    override func initView() {
        
        //初始化动画图层对象
        
        let center :CGPoint = CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        //初始左边圆弧
        let leftPath : UIBezierPath = UIBezierPath.init()
        leftPath .addArc(withCenter: center, radius: radius, startAngle: -PI / 2, endAngle: PI / 2, clockwise: true)
        
        leftArcLayer.lineWidth = 1.0
        leftArcLayer.path = leftPath.cgPath
        leftArcLayer.fillColor = UIColor.clear.cgColor
        leftArcLayer.strokeColor = UIColor.green.cgColor
        self.layer.addSublayer(leftArcLayer)
        
        //初始右边圆弧
        let rightPath : UIBezierPath = UIBezierPath.init()
        rightPath .addArc(withCenter: center, radius: radius, startAngle: PI / 2, endAngle: -PI / 2, clockwise: true)
        
        rightArcLayer.lineWidth = 1.0
        rightArcLayer.path = rightPath.cgPath
        rightArcLayer.fillColor = UIColor.clear.cgColor
        rightArcLayer.strokeColor = UIColor.green.cgColor
        self.layer.addSublayer(rightArcLayer)
        
        
        //初始上圆点图层
        topPointLayer.bounds = CGRect.init(x: 0, y: 0, width: 2, height: 2)
        topPointLayer.position = center
        topPointLayer.backgroundColor = UIColor.green.cgColor
        self.layer.addSublayer(topPointLayer)
        
        //初始下圆点图层
        bottomPointLayer.bounds = CGRect.init(x: 0, y: 0, width: 2, height: 2)
        bottomPointLayer.position = center
        bottomPointLayer.backgroundColor = UIColor.green.cgColor
        self.layer.addSublayer(bottomPointLayer)
    }
    
    func startAnim() {
        
        let animation : CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = 0.7
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.setValue("arcRotateAnim", forKey: "animationName")
        
        
        leftArcLayer.add(animation, forKey: "")
        rightArcLayer.add(animation, forKey: "")
        
        //画面旋转动画
        let rotateAnim = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotateAnim.toValue = PI * 2
        rotateAnim.duration = 0.7
        
        rotateAnim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        rotateAnim.setValue("BasicAnimationRotation", forKey: "animationName")
        
        self.layer.add(rotateAnim, forKey: "")
       
        
        let time: TimeInterval = 0.7
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {[unowned self] in

            self.middlePointAnim()
        }
        
    }
    
    func middlePointAnim() {
        
        //上顶点动画
        self.topPointLayer.add(topMoveAnim, forKey: "")
        
        //下圆点动画
        self.bottomPointLayer.add(bottomAnim, forKey: "")
    }
    
    override func onScrollChangeListener(contentOffset:CGPoint) {
        
        curOffsetY = Int(fabsf(Float(contentOffset.y)))
        
        if curOffsetY - lastOffsetY > 0{            //往下拉
        
            if(leftArcLayer.strokeEnd > 0){
            
                leftArcLayer.strokeEnd -= 0.03
            }
            if(rightArcLayer.strokeEnd > 0){
            
                rightArcLayer.strokeEnd -= 0.03
            }
            
        } else if curOffsetY - lastOffsetY < 0 {    //往上拉
        
            if(leftArcLayer.strokeEnd < 1.0){
            
                leftArcLayer.strokeEnd += 0.03
            }
            if(rightArcLayer.strokeEnd < 1.0){
            
                rightArcLayer.strokeEnd += 0.03
            }
        }
        lastOffsetY = curOffsetY

    }
    
    override func onRefreshing() {
        bIsStop = false
        self.middlePointAnim()        
       
        
    }

    override func onEnd() {
        bIsStop = true
        leftArcLayer.removeAllAnimations()
        rightArcLayer.removeAllAnimations()
        topPointLayer.removeAllAnimations()
        bottomPointLayer.removeAllAnimations()
        self.layer.removeAllAnimations()

    }

}

extension YunDiskHeadForTabView : CAAnimationDelegate{


    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if bIsStop {return}
        
        if(anim.value(forKey: "moveAnim") as! String == "positionAnimation"){
        
            let time: TimeInterval = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {[unowned self] in
                
                self.startAnim()
            }
        }
    }

}































