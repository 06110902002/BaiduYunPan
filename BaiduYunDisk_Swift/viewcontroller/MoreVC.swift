//
//  MoreVC.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/19.
//  Copyright © 2017年 刘小兵. All rights reserved.
//
import UIKit

class MoreVC: BaseVC {
    
    
    lazy var progressBar : ProgressBarView = {
    
        let tmpView : ProgressBarView = ProgressBarView.init(frame: CGRect.init(x: 150, y: 100, width: 200, height: 6))
        
        return tmpView
    
    
    }()
    
    lazy var topHeadBgView : UIView = {[unowned self] in
    
        return UIView.init(frame: CGRect.init(x: 0, y: 20, width: self.getScreenSize().size.width, height: 180))
    }()
    
    
    override func viewDidLoad() {
        initView()
        
        let btnSuccessToast : UIButton = UIButton.init(frame: CGRect.init(x: 10, y: 400, width: 80, height: 40))
        btnSuccessToast.backgroundColor = UIColor.gray
        btnSuccessToast.tag = 41
        btnSuccessToast.setTitle("加载成功", for: UIControlState.normal)
        btnSuccessToast.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        self.view.addSubview(btnSuccessToast)
        
        
        let btnFailToast : UIButton = UIButton.init(frame: CGRect.init(x: 100, y: 400, width: 80, height: 40))
        btnFailToast.backgroundColor = UIColor.gray
        btnFailToast.tag = 42
        btnFailToast.setTitle("加载失败", for: UIControlState.normal)
        btnFailToast.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        self.view.addSubview(btnFailToast)
        
        
        let btnTextToast : UIButton = UIButton.init(frame: CGRect.init(x: 200, y: 400, width: 80, height: 40))
        btnTextToast.backgroundColor = UIColor.gray
        btnTextToast.tag = 43
        btnTextToast.setTitle("文本模式", for: UIControlState.normal)
        btnTextToast.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        self.view.addSubview(btnTextToast)
        
        
        let btncd : UIButton = UIButton.init(frame: CGRect.init(x: 290, y: 400, width: 80, height: 40))
        btncd.backgroundColor = UIColor.gray
        btncd.tag = 44
        btncd.setTitle("倒计时动画", for: UIControlState.normal)
        btncd.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        self.view.addSubview(btncd)
        
    }
    
    func onClick(button: UIButton){
    
        switch button.tag {
        case 41:
            
            //初始toast
            let toast : ToastView = ToastView.init(frame: CGRect.init(x: getScreenSize().width / 2 - 50, y: getScreenSize().height / 2 - 50, width: 100, height: 100))
            toast.backgroundColor = UIColor.gray
            toast.toast(success: true,withTitle: "加载成功")
            
            self.view.addSubview(toast)
            
            break
            
        case 42:
            
            //初始toast
            let toast : ToastView = ToastView.init(frame: CGRect.init(x: getScreenSize().width / 2 - 50, y: getScreenSize().height / 2 - 50, width: 100, height: 100))
            toast.backgroundColor = UIColor.gray
            toast.toast(success: false,withTitle: "加载失败")
            
            self.view.addSubview(toast)
            
            break;
            
        case 43 :
            
            //初始toast
            let toast : ToastView = ToastView.init(frame: CGRect.init(x: getScreenSize().width / 2 - 50, y: getScreenSize().height / 2 - 50, width: 100, height: 100))
            toast.backgroundColor = UIColor.gray
            toast.toastOnly(text: "加载成功")
            
            self.view.addSubview(toast)
            
            

            
            break;
            
        case 44:
            
            let countDowm : CountDownView = CountDownView.init(frame: CGRect.init(x: self.getScreenSize().width / 2 - 100, y: self.getScreenSize().height / 2 - 100, width: 100, height: 100))
            
            countDowm.setCircleAttr(radius: 25, color: UIColor.green, strokWidth: 2.0)
            
            countDowm.setTextAttr(initText: "10",
                                  color: UIColor.black,
                                  font: UIFont.systemFont(ofSize: 10),
                                  size: CGSize.init(width: 50, height: 50))
            
            countDowm.countDownListener = self
            countDowm.startCountDown(duration: 10)
            
            countDowm.backgroundColor = UIColor.gray
            
            self.view.addSubview(countDowm)
            
            break;
            
        default:
            break;
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func initView()  {
        
        //初始头部视图
        topHeadBgView.backgroundColor = UIColor.init(red: 78 / 255, green: 137 / 255, blue: 247 / 255, alpha: 1.0)
        self.view.addSubview(topHeadBgView)
        
        progressBar.setProgressBgAttr(color: UIColor.init(red: 66 / 255, green: 91 / 255, blue: 176 / 255, alpha: 1.0), height: 6)
        
        progressBar.setProgressForAttr(color: UIColor.init(red: 192 / 255, green: 251 / 255, blue: 84 / 255, alpha: 1.0), height: 6)
        
        let time: TimeInterval = 3
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {[unowned self] in
            
            self.progressBar.setProgress(progress: 200,duration : 9)
            
            self.playNumAnim(fromValue: 0.00,toValue: 253.69,duration: 9)
        }
        
        topHeadBgView.addSubview(progressBar)
        
        
        
        
        
        
    }
    
    func playNumAnim(fromValue : Float,toValue : Float, duration : TimeInterval) {
        
        let labelCount : NumberLabelAnim = NumberLabelAnim.init(frame: CGRect.init(x: 150, y: 110, width: 200, height: 40), type: .FLOAT)
        labelCount.textAlignment = NSTextAlignment.center
        labelCount.font = UIFont.systemFont(ofSize: 14)
        labelCount.textColor = UIColor.white
        labelCount.setFormatResult(flag: true)
        labelCount.playCountAnim(fromValue: fromValue, toValue: toValue, duration: duration)
        
        topHeadBgView.addSubview(labelCount)
    }
}

extension MoreVC : CountDownListener{

    func onEnd() {
        print("93---------------:定时结束")
    }
}
