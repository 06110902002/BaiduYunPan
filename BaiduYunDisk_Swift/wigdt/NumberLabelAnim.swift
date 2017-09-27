//
//  NumberLabelAnim.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/27.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit

enum NumberType {
    case INT
    case FLOAT
}

/// 简易数字标签动画
class NumberLabelAnim : UILabel{

    
    var timer:CADisplayLink!
    
    var progress:TimeInterval!
    
    var startTime:TimeInterval!
    
    var totalupdate:TimeInterval!
    
    var startValue:Float!
    
    var endValue:Float!
    
    var type:NumberType!
    
    var bIsFormatStr : Bool = false
    
    
    init(frame: CGRect,type:NumberType) {
        super.init(frame: frame)
        self.type = type
    }
    
    func playCountAnim(fromValue:Float,toValue:Float,duration:TimeInterval) {
        
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        
        initTimer()
        
        startTime = NSDate.timeIntervalSinceReferenceDate
        
        totalupdate = duration
        
        startValue = fromValue
        
        endValue = toValue
    }

    
    func initTimer() {
        
        progress = 0
        timer = CADisplayLink(target: self,selector: #selector(onTimerTick))
        timer.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 定时器执行：每一次执行，更新剩余的时间，剩余的时间差等于  定时器中获取的时间 --创建定时器的时间
    /// 如果这个时间差等于创建对象时的持久度，则停止计时
    /// 定时器同时更新文本
    ///
    /// - Parameter sender: 定时器对象
    func onTimerTick(sender:CADisplayLink) {
        
        let now:TimeInterval = NSDate.timeIntervalSinceReferenceDate
       
        progress = now - startTime
        
        if progress >= totalupdate {
            progress = totalupdate
            stopCountAnim()
        }
        self.text = updateText()
    }
    
    func updateText() -> String {
        
        let timebi:Float = Float(progress) / Float(totalupdate)
        
        let newValue = startValue + (timebi * (self.endValue - self.startValue))  //起始值 + 差值百分比
        
        guard self.bIsFormatStr else{
        
            if type == NumberType.FLOAT {
            
                return String(format: "%.2f",newValue)
            }
            return String(format: "%.0f",newValue)
        }
        return formatStr(number: newValue)
    }
    
    
    /// 设置是否需要进行格式化字符串，主要是进行千分位的格式化
    ///
    /// - Parameter flag: 开关
    func setFormatResult(flag : Bool)  {
        self.bIsFormatStr = flag
    }
    
    private func formatStr(number : Float) -> String{
    
        let format = NumberFormatter()
       
        if type == NumberType.FLOAT {
            
            format.numberStyle = .decimal
            
        }else{
            
            format.numberStyle = .none
        }
        
        return format.string(from: NSNumber.init(value: number))!
    
    }
    
    
    func stopCountAnim() {
        timer.invalidate()
        timer = nil
    }
}


