//
//  TransListVC.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/26.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit

/// 传输列表页面
class TransListVC: BaseVC {
    
    
    lazy var topNavBar : UIView = {[unowned self] ()->UIView in
    
        return UIView.init(frame:CGRect.init(x: 0, y: 20, width: self.getScreenSize().size.width, height: 40))
    
    }()
    
    lazy var middleNavBar : ScrollNavBar = {[unowned self]() -> ScrollNavBar in
        
        let tmpView : ScrollNavBar = ScrollNavBar.init(frame: CGRect.init(x : 0,
                                                                          y : 40,
                                                                          width : self.getScreenSize().size.width,
                                                                          height : self.getScreenSize().size.height - 40))
        
        return tmpView
        
        }()
    
    override func viewDidLoad() {
        
        initView()
    }
    
    func initView(){
        
        topNavBar.backgroundColor = UIColor.init(red: 66.0 / 255.0, green: 133.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
        self.view.addSubview(topNavBar)
        let backIcon : UIImageView = UIImageView.init(image: UIImage.init(named: "title_back_icon_normal"))
        backIcon.frame = CGRect.init(x: 10, y: 10, width: 30, height: 30)
        backIcon.contentMode = UIViewContentMode.scaleAspectFit
        backIcon.addOnClickListener(target: self, action: #selector(onBack))
        topNavBar.addSubview(backIcon)
        
        let moreBtn : UIButton = UIButton.init(frame: CGRect.init(x: getScreenSize().width - 40, y: 0, width: 40, height: 40))
        moreBtn.setImage(UIImage.init(named: "title_more_button_normal"), for: .normal)
        moreBtn.addTarget(self, action: #selector(onClickListener), for: UIControlEvents.touchUpInside)
        topNavBar.addSubview(moreBtn)
        
        
        let titles : [String] = ["视频","资讯","趣味图集","小说"]
        middleNavBar.initTitle(titles: titles,isScroll: false)
        
        self.view.addSubview(middleNavBar)
        
        let view1 : TransListBaseView = TransListBaseView.init(frame: CGRect.init(x: 0,
                                                                                  y: 0,
                                                                              width: self.getScreenSize().size.width,
                                                                             height: self.getScreenSize().size.height))
        
        view1.setImgTips(size: CGRect.init(x: (middleNavBar.frame.width - 100 ) / 2,
                                           y: (middleNavBar.frame.height - 42 - 100 - 80 ) / 2,
                                       width: 100,
                                      height: 100),
                                     imgName: "empty_no_data")
        view1.backgroundColor = UIColor.white
        view1.setLabelTips(size: CGRect.init(x: (middleNavBar.frame.width - 140 ) / 2, y: (middleNavBar.frame.height - 42 ) / 2, width: 140, height: 40),
                           text: "你还没有传输记录",
                           color: UIColor.init(red: 175 / 255, green: 175 / 255, blue: 175 / 255, alpha: 1.0),
                           font: UIFont.systemFont(ofSize: 14))
        
        
        let views : [UIView] = [view1]
        
        
        
        middleNavBar.initSegmentView(views: views)
        
        
        
    }
    
    func onBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func onClickListener(button : UIButton) {
    
        print("84--------------")
    }
    
}
