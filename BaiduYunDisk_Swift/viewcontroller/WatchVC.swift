//
//  WatchVC.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/19.
//  Copyright © 2017年 刘小兵. All rights reserved.
//
import UIKit


class WatchVC: BaseVC {
    
    lazy var topNavBar : ScrollNavBar = {[unowned self]() -> ScrollNavBar in
    
        let tmpView : ScrollNavBar = ScrollNavBar.init(frame: CGRect.init(x : 0,
                                                                          y : 0,
                                                                      width : self.getScreenSize().size.width,
                                                                     height : self.getScreenSize().size.height))
        
        return tmpView
    
    }()
    
    override func viewDidLoad() {
        
        initView()
    }
    
    func initView(){
    
        let titles : [String] = ["视频","资讯","趣味图集","小说","娱乐","热点","体育",
                                 "财经","军事","汽车","时尚"]
        topNavBar.initTitle(titles: titles)
        
        self.view.addSubview(topNavBar)
        
        let view1 : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.getScreenSize().size.width, height: self.getScreenSize().size.height))
        view1.backgroundColor = UIColor.blue
        
        let view2 : UIView = UIView.init(frame: CGRect.init(x: self.getScreenSize().size.width, y: 0, width: self.getScreenSize().size.width, height: self.getScreenSize().size.height))
        view2.backgroundColor = UIColor.orange
        
        let view3 : UIView = UIView.init(frame: CGRect.init(x: self.getScreenSize().size.width * 2, y: 0, width: self.getScreenSize().size.width, height: self.getScreenSize().size.height))
        view3.backgroundColor = UIColor.yellow
        
        let view4 : UIView = UIView.init(frame: CGRect.init(x: self.getScreenSize().size.width * 3, y: 0, width: self.getScreenSize().size.width, height: self.getScreenSize().size.height))
        view4.backgroundColor = UIColor.blue
        
        let views : [UIView] = [view1,view2,view3,view4]
        
        topNavBar.initSegmentView(views: views)
        
        
        
    }
}
