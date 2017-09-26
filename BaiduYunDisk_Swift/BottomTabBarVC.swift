//
//  BottomTabBarVC.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/19.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit
import SnapKit

class BottomTabBarVC: UITabBarController,UITabBarControllerDelegate {
    
    lazy var yunVC : YunDiskVC = YunDiskVC()
    
    lazy var shareVC: ShareVC = ShareVC()
    
    lazy var watchVC : WatchVC = WatchVC()
    
    lazy var moreVC : MoreVC = MoreVC()
    
    lazy var bottomMenuBgView : UIView  = {() -> UIView in
        
        let bottomMenu : UIView = UIView.init()
        bottomMenu.backgroundColor = UIColor.init(red: 58 / 255, green: 68 / 255, blue: 73 / 255, alpha: 1.0)
        return bottomMenu
        
    }()
    
    lazy var topMenuBgView : UIView = {() -> UIView in
    
        let topMenu : UIView = UIView.init()
        topMenu.backgroundColor = UIColor.init(red: 65 / 255, green: 69 / 255, blue: 83 / 255, alpha: 0.8)
        return topMenu
    }()
    
    override func viewDidLoad() {
        
        initMenu()
        
//        let time: TimeInterval = 3.0
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
//           
//            self.updateTips(index: 2, count: 23)
//        }
        initBottomTopMenu()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        regMsgReciver()
    }
    
    /// 初始化菜单选项
    func initMenu() {
        
        self.view.backgroundColor = UIColor.white
        
        self.delegate = self as UITabBarControllerDelegate;
        
        self.yunVC.tabBarItem.title = "网盘"
        self.yunVC.view.tag = 0
        let diskChkedImg : UIImage = UIImage.init(named: "tab_filelist_checked")!
        self.yunVC.tabBarItem.selectedImage = diskChkedImg.reSizeImage(reSize: CGSize.init(width: 30, height: 30))
        let diskNormalImg : UIImage = UIImage.init(named: "tab_filelist_normal")!
        self.yunVC.tabBarItem.image = diskNormalImg.reSizeImage(reSize: CGSize.init(width: 30, height: 30))
        
        
        self.shareVC.tabBarItem.title = "分享"
        self.shareVC.view.tag = 1
        let shareChkImg : UIImage = UIImage.init(named: "tab_share_checked.png")!
        self.shareVC.tabBarItem.selectedImage = shareChkImg.reSizeImage(reSize: CGSize.init(width: 30, height: 30))
        let shareNormalImg : UIImage = UIImage.init(named: "tab_share_normal.png")!
        self.shareVC.tabBarItem.image = shareNormalImg.reSizeImage(reSize: CGSize.init(width: 30, height: 30))
        
    
        self.watchVC.tabBarItem.title = "看吧"
        self.watchVC.view.tag = 2
        let watchChkImg : UIImage = UIImage.init(named: "tab_discovery_checked")!
        self.watchVC.tabBarItem.selectedImage = watchChkImg.reSizeImage(reSize: CGSize.init(width: 30, height: 30))
        let watchNormalImg : UIImage = UIImage.init(named: "tab_discovery_normal")!
        self.watchVC.tabBarItem.image = watchNormalImg.reSizeImage(reSize: CGSize.init(width: 30, height: 30))
        
        self.moreVC.tabBarItem.title = "更多"
        self.moreVC.view.tag = 3
        let moreChkImg : UIImage = UIImage.init(named: "tab_about_me_checked")!
        self.moreVC.tabBarItem.selectedImage = moreChkImg.reSizeImage(reSize: CGSize.init(width: 30, height: 30))
        
        let moreNormalImg : UIImage = UIImage.init(named: "tab_about_me_normal")!
        self.moreVC.tabBarItem.image = moreNormalImg.reSizeImage(reSize: CGSize.init(width: 30, height: 30))
        
        
        self.viewControllers = [self.yunVC,self.shareVC,self.watchVC,self.moreVC];
        
    }
    
    /**
     初始顶部与底部菜单
     */
    func initBottomTopMenu(){
        
        //添加顶部背景
        self.view.addSubview(topMenuBgView)
        self.topMenuBgView.snp.makeConstraints {[unowned self] (make) in
            
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.top.equalTo(self.view).offset(-100)
            make.height.equalTo(100)
        }
        
        //添加顶部菜单
        let cancelBtn : UIButton = UIButton.init()
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.layer.borderWidth = 1.0
        topMenuBgView.addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints{ [unowned self] (make) in
        
            make.top.equalTo(40)
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.left.equalTo(self.topMenuBgView).offset(10)
        }
        
        let topTitleTips : UILabel = UILabel.init()
        topTitleTips.font = UIFont.systemFont(ofSize: 18)
        topTitleTips.textColor = UIColor.white
        topMenuBgView.addSubview(topTitleTips)
        topTitleTips.text = "已选中一个"
        topTitleTips.snp.makeConstraints({(make) in
        
            make.center.equalTo(self.topMenuBgView)
        })
        
        let chooseAllBtn : UIButton = UIButton.init()
        chooseAllBtn.setTitle("全部", for: UIControlState.normal)
        chooseAllBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        chooseAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        chooseAllBtn.layer.borderWidth = 1.0
        topMenuBgView.addSubview(chooseAllBtn)
        
        chooseAllBtn.snp.makeConstraints{ [unowned self] (make) in
            
            make.top.equalTo(40)
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.right.equalTo(self.topMenuBgView).offset(-10)
        }
        
    
        //添加底部菜单
        self.view.addSubview(self.bottomMenuBgView)
        self.bottomMenuBgView.snp.makeConstraints {[unowned self] (make) in
            
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(50)
            make.height.equalTo(50)
        }
        
        let titles:[String] = ["打开","下载","分享","删除","更多"]
        let icons :[String] = ["edit_tools_open","edit_tools_download","edit_tools_share",
                               "edit_tools_download","edit_tools_download"]
        
        let screenSize = UIScreen.main.bounds
        
        for i in 0 ..< 1 {
            
            for j in 0 ..< 5{
                
                if i * 5 + j >= titles.count {
                    
                    break
                }
                
                let menuItem = ImgLabelView.init(frame: CGRect(x : j * Int(screenSize.width / 5), y : i * 50 + 5, width:Int(screenSize.width / 5), height : 50))
                menuItem.image = icons[i * 5 + j]
                menuItem.sTips = titles[ i * 5 + j]
                menuItem.build(imgSize : CGSize.init(width: 20, height: 20),imgMarginTop: 0,textMarginTop: 0)
                menuItem.tag = i * 5 + j + 20
                menuItem.onClickListener = {(tag:Int) -> Void in
                    print("104--------------\(tag)")
                }
                bottomMenuBgView.addSubview(menuItem)
                
                
            }
            
        }

    }
    
    
    /// 更新底部菜单项的右上角红点提示
    ///
    /// - Parameters:
    ///   - index: 底部菜单项的索引
    ///   - withCount: 红点数
    func updateTips(index : Int, count: Int) {
        
        switch index {
        case 0:
            
            if(count == 0){
            
                self.yunVC.tabBarItem.badgeValue = nil
                return
            }
            self.yunVC.tabBarItem.badgeValue = String(count)
            self.yunVC.tabBarItem.badgeColor = UIColor.red
            break;
            
        case 1:
            
            if(count == 0){
                
                self.shareVC.tabBarItem.badgeValue = nil
                return
            }
            
            self.shareVC.tabBarItem.badgeValue = String(count)
            self.shareVC.tabBarItem.badgeColor = UIColor.red
            
            break;
            
        case 2:
            
            if(count == 0){
                
                self.watchVC.tabBarItem.badgeValue = nil
                return
            }
            
            self.watchVC.tabBarItem.badgeValue = String(count)
            self.watchVC.tabBarItem.badgeColor = UIColor.red
            
            break;
            
        case 3:
            
            if(count == 0){
                
                self.moreVC.tabBarItem.badgeValue = nil
                return
            }
            
            self.moreVC.tabBarItem.badgeValue = String(count)
            self.moreVC.tabBarItem.badgeColor = UIColor.red
            
            break;
            
        default:
            
            break;
       
        }
        
    }
    
    
    //implements 实现协议接口
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        updateTips(index: viewController.view.tag, count: 0)
    }
    
    
    //注册消息通知
    func regMsgReciver(){
        
        //算是列表单元格点击事件
        NotificationCenter.default.addObserver(self, selector:#selector(didMsgRecv(notification:)),
                                               name: NSNotification.Name(rawValue:"SelectItemInfo"), object: nil)
        
    }
    
    var bIsClose : Bool = false
    //通知处理函数
    func didMsgRecv(notification:NSNotification){
        //        let info : NSDictionary = notification.object as! NSDictionary
        //        let data = info.object(forKey: "ItemInfo")
        //        print("didMsgRecv: \(String(describing: data))")
        
        
        switchTopBottomMenu(close: bIsClose)
        bIsClose = !bIsClose
    }
    
    
    /// 切换顶部与底部菜单
    ///
    /// - Parameter close: 关闭开关
    func switchTopBottomMenu(close : Bool) {
        
        guard close == true else {
            
            //执行打开
            self.topMenuBgView.snp.remakeConstraints {[unowned self] (make) in
                
                make.leading.equalTo(self.view)
                make.trailing.equalTo(self.view)
                make.top.equalTo(self.view)
                make.height.equalTo(100)
            }
            
            self.bottomMenuBgView.snp.remakeConstraints { (make) in
                
                make.leading.equalTo(self.view)
                make.trailing.equalTo(self.view)
                make.bottom.equalTo(self.view)
                make.height.equalTo(50)
            }
            
            UIView.animate(withDuration: 0.5, animations: {[unowned self]() -> Void in
                self.view.layoutIfNeeded()
                
            })
            
            return
        }
        
        
        //执行关闭
        if bottomMenuBgView.superview != nil{
            
            self.topMenuBgView.snp.remakeConstraints {[unowned self] (make) in
                
                make.leading.equalTo(self.view)
                make.trailing.equalTo(self.view)
                make.top.equalTo(self.view).offset(-100)
                make.height.equalTo(100)
            }
            
            self.bottomMenuBgView.snp.updateConstraints { [unowned self](make) in
                
                make.leading.equalTo(self.view)
                make.trailing.equalTo(self.view)
                make.bottom.equalTo(self.view).offset(50)
                make.height.equalTo(50)
            }
            UIView.animate(withDuration: 0.5, animations: {[unowned self]() -> Void in
                self.view.layoutIfNeeded()
                
                })
            
        }
        
    }
    
    //页面消失时移除消息通知
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"SelectItemInfo"), object: nil)
    }

}
