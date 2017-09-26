//
//  YunDiskVC.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/19.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit
import SnapKit

class YunDiskVC: BaseVC {
    
    
    /// 使用懒加载作为头部背景，同时使用闭包作为属性，也可心视为闭包函数
    lazy var imgHeadBg:() -> UIImageView = {() -> UIImageView in
    
        let bg : UIImageView = UIImageView.init(frame: CGRect.init(x : 0, y : 20,
                                                                   width : self.view.frame.size.width,
                                                                   height : 100))
        
        bg.image = UIImage.init(named: "about_me_title_background")
        bg.contentMode = UIViewContentMode.scaleToFill
        
        return bg
        
    }
    
    var imgHead : UIImageView?
    
    var labelName : UILabel?
    
    var imgVIP : UIImageView?
    
    let middleView = UIView.init()
    lazy var viewClassify : UIView = UIView.init()
    lazy var viewUpload : UIView = UIView.init()
    lazy var viewTransList : UIView = UIView.init()
    
    lazy var classifyMenuPanel : UIView  = UIView.init()                //分类菜单面板
    lazy var classifyMenuMask : UIView = UIView.init()                  //分类菜单背蒙层
    
    var bIsExpand : Bool = false
    
    lazy var bottomMenuBgView : UIView  = {() -> UIView in
    
        let bottomMenu : UIView = UIView.init()
        bottomMenu.backgroundColor = UIColor.init(red: 58 / 255, green: 68 / 255, blue: 73 / 255, alpha: 1.0)
        return bottomMenu
        
    }()
    
    override func viewDidLoad() {
        
        initView()
    }

    
    func initView(){
    
        setStatusBarBackground(color: UIColor.black)
        setStatusFontStyle(style: UIStatusBarStyle.lightContent)
        
        buildYunDiskResList()
        /**------------------添加分类菜单背景蒙层----------------------*/
        self.view.addSubview(classifyMenuMask)
        classifyMenuMask.backgroundColor = UIColor.init(red: 97 / 255, green: 100 / 255, blue: 99 / 255, alpha: 0.5)
        classifyMenuMask.addOnClickListener(target: self, action: #selector(tabOnclassifyMenuMask))
        classifyMenuMask.snp.updateConstraints {[unowned self] (make) in
            
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.height.equalTo(0)
            make.top.equalTo(self.view).offset(0)
        }

    
        //添加分类菜单面板
        self.view.addSubview(classifyMenuPanel)
        classifyMenuPanel.backgroundColor = UIColor.init(red: 49.0 / 255.0, green: 59.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
        classifyMenuPanel.snp.makeConstraints { (make) in
            
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.height.equalTo(0)
            make.top.equalTo(self.view).offset(100)
        }
        /**------------------添加分类菜单背景蒙层----------------------*/
        
        
        self.view.addSubview(imgHeadBg())
    
        imgHead = UIImageView.init(image: UIImage.init(named: "head.png"))
        imgHead?.contentMode = UIViewContentMode.scaleToFill
        self.view.addSubview(imgHead!)
        
        imgHead!.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.view).offset(15)
            make.centerY.equalTo(imgHeadBg().center.y)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        }
        
        labelName = UILabel.init()
        labelName?.text = "越女阿青"
        labelName?.textColor = UIColor.white
        labelName?.sizeToFit()
        labelName?.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(labelName!)
        labelName!.snp.makeConstraints { (make) in
            
            make.leading.equalTo(imgHead!).offset(80)
            make.centerY.equalTo(imgHead!)
        }
        
        imgVIP = UIImageView.init(image: UIImage.init(named:"normal_account_icon"))
        imgVIP?.highlightedImage = UIImage.init(named: "normal_account_icon_pressed")
        imgVIP?.contentMode = UIViewContentMode.scaleToFill
        self.view.addSubview(imgVIP!)
        
        imgVIP!.snp.makeConstraints { (make) in
            
            make.leading.equalTo(labelName!).offset(Int((labelName?.frame.size.width)!) + 15)
            make.centerY.equalTo(imgHead!)
            make.size.equalTo(CGSize.init(width: 50, height: 30))
        }
        
        
        initMiddleMenu()
        buildClassifyMenuItem()
        self.classifyMenuPanel.isHidden = true
        
        
        //添加底部与顶部菜单
//        self.view.addSubview(self.bottomMenuBgView)
//        self.bottomMenuBgView.snp.makeConstraints {[unowned self] (make) in
//            
//            make.leading.equalTo(self.view)
//            make.trailing.equalTo(self.view)
//            make.bottom.equalTo(self.view).offset(-50)
//            make.height.equalTo(50)
//        }
    }
    
    
    func initMiddleMenu() {
        
        
        middleView.backgroundColor = UIColor.init(red: 66.0 / 255.0, green: 133.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
        self.view.addSubview(middleView)
        
        middleView.snp.makeConstraints { (make) in
            
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.top.equalTo(self.view).offset(imgHeadBg().frame.size.height)
            make.height.equalTo(50)
        }
        
       
        //处理分类菜单
        middleView.addSubview(viewClassify)
        //viewClassify.backgroundColor = UIColor.orange
        viewClassify.addOnClickListener(target: self, action: #selector(tabOnClassify))
        viewClassify.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: self.view.frame.width / 3, height: 50))
            make.leading.equalToSuperview()
            
        }
        
        let classifyIcon : UIImageView = UIImageView.init(image: UIImage.init(named: "navigation_bar_category_icon"))
        viewClassify.addSubview(classifyIcon)
        classifyIcon.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.left.equalToSuperview().offset(30)
            
        }
        
        let classifyLabel : UILabel = UILabel.init()
        classifyLabel.text = "分类"
        classifyLabel.textColor = UIColor.white
        classifyLabel.font = UIFont.systemFont(ofSize: 14)
        classifyLabel.sizeToFit()
        viewClassify.addSubview(classifyLabel)
        
        classifyLabel.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.left.equalTo(classifyIcon).offset(25 + 10)
            
        }
        
        
        //处理上传菜单 
        
        middleView.addSubview(viewUpload)
        //viewUpload.backgroundColor = UIColor.gray
        viewUpload.addOnClickListener(target: self, action: #selector(tabOnUpload))
        viewUpload.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: self.view.frame.width / 3, height: 50))
            make.left.equalTo(viewClassify.snp.right)
            
        }
        
        let uploadIcon : UIImageView = UIImageView.init(image: UIImage.init(named: "navigation_bar_upload_icon"))
        viewUpload.addSubview(uploadIcon)
        uploadIcon.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.left.equalToSuperview().offset(30)
            
        }
        
        let uploadLabel : UILabel = UILabel.init()
        uploadLabel.text = "上传"
        uploadLabel.textColor = UIColor.white
        uploadLabel.font = UIFont.systemFont(ofSize: 14)
        uploadLabel.sizeToFit()
        viewUpload.addSubview(uploadLabel)
        
        uploadLabel.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.left.equalTo(uploadIcon).offset(25 + 10)
            
        }

        
        
        
        
        

        //处理传输列表
        
        middleView.addSubview(viewTransList)
        //viewTransList.backgroundColor = UIColor.blue
        viewTransList.addOnClickListener(target: self, action: #selector(tabOnTransList))

        viewTransList.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: self.view.frame.width / 3, height: 50))
            make.left.equalTo(viewUpload.snp.right)
            
        }
        
        
        let transIcon : UIImageView = UIImageView.init(image: UIImage.init(named: "navigation_bar_transferlist_icon"))
        viewTransList.addSubview(transIcon)
        transIcon.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.left.equalToSuperview().offset(30)
            
        }
        
        let transLabel : UILabel = UILabel.init()
        transLabel.text = "传输列表"
        transLabel.textColor = UIColor.white
        transLabel.font = UIFont.systemFont(ofSize: 14)
        transLabel.sizeToFit()
        viewTransList.addSubview(transLabel)
        
        transLabel.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.left.equalTo(transIcon).offset(25 + 10)
            
        }

        
        
    }
    
    
    
    /// 构建分类面板中菜单选项
    func buildClassifyMenuItem() {
        
        let titles:[String] = ["图片","文档","视频","BT种子",
                               "音乐","应用","其他"]
        let icons :[String] = ["netdisk_category_image_normal","netdisk_category_document_normal","netdisk_category_video_normal",
                               "netdisk_category_bt_normal","netdisk_category_audio_normal","netdisk_category_apk_normal","netdisk_category_other_normal"]
        
        for i in 0 ..< 2 {
            
            for j in 0 ..< 4{
                
                if i * 4 + j >= titles.count {
                
                    break
                }
                
                let menuItem = ImgLabelView.init(frame: CGRect(x : j * Int(getScreenSize().width / 4), y : i * 100 + 15, width:Int(getScreenSize().width / 4), height : 100))
                menuItem.image = icons[i * 4 + j]
                menuItem.sTips = titles[ i * 4 + j]
                menuItem.build(imgSize : CGSize.init(width: 50, height: 50),imgMarginTop: 20,textMarginTop: 25)
                menuItem.tag = i * 4 + j + 100
                menuItem.onClickListener = {(tag:Int) -> Void in
                    print("104--------------\(tag)")
                }
                classifyMenuPanel.addSubview(menuItem)
                
                
            }
            
        }

    }
    
    
    //构建中间资源列表视图
    func buildYunDiskResList() {
        
        let qwv: YunDiskTableView = YunDiskTableView.init(frame:CGRect(x : 0, y : 150,width: self.view.frame.width, height: self.view.frame.height))
        qwv.initAttr()
        qwv.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10)
        qwv.tableFooterView = UIView(frame:CGRect.zero)
        
        self.view.addSubview(qwv)
        
    }
    
    func tabOnclassifyMenuMask() {
        
        //先收缩菜单面板，再收缩背景面板
        UIView.animate(withDuration: 0.5, animations: {[unowned self] in
            
            
            self.classifyMenuPanel.snp.updateConstraints{ [unowned self] (make) in
                
                make.leading.equalTo(self.view)
                make.trailing.equalTo(self.view)
                make.height.equalTo(0)
                make.top.equalTo(self.view).offset(0)
            }
            
            }, completion: {(true) -> Void in
                
                UIView.animate(withDuration: 0.2, animations: {[unowned self] in
                    
                    self.classifyMenuPanel.alpha = 0
                })
                
                //再收缩背景蒙层
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.classifyMenuMask.snp.updateConstraints {[unowned self] (make) in
                        
                        make.leading.equalTo(self.view)
                        make.trailing.equalTo(self.view)
                        make.height.equalTo(0)
                        make.top.equalTo(self.view).offset(0)
                    }
                    
                    self.view.layoutIfNeeded()
                    
                }, completion: {[unowned self] (true) -> Void in
                    
                    self.bIsExpand = false
                })
                
        })

        
    }
    
    
    func tabOnClassify() {
        
        if bIsExpand {
        
            //先收缩菜单面板，再收缩背景面板
            UIView.animate(withDuration: 0.8, animations: {[unowned self] in
                
                    self.classifyMenuPanel.snp.updateConstraints{ [unowned self] (make) in
                    
                        make.leading.equalTo(self.view)
                        make.trailing.equalTo(self.view)
                        make.height.equalTo(0)
                        make.top.equalTo(self.view).offset(0)
                    }
                
                }, completion: {(true) -> Void in
                    
                    UIView.animate(withDuration: 0.2, animations: {[unowned self] in
                    
                        self.classifyMenuPanel.alpha = 0
                    })
                    //再收缩背景蒙层
                    UIView.animate(withDuration: 0.8, animations: {[unowned self] in
                        
                        self.classifyMenuMask.snp.updateConstraints {[unowned self] (make) in
                            
                            make.leading.equalTo(self.view)
                            make.trailing.equalTo(self.view)
                            make.height.equalTo(0)
                            make.top.equalTo(self.view).offset(0)
                        }
                        
                        self.view.layoutIfNeeded()
                        
                    }, completion: {[unowned self] (true) -> Void in
                        
                        self.bIsExpand = false
                    })
            
            })
            
            
            
        }else{
            
            //先展开背景面板，再展开菜单面板
            UIView.animate(withDuration: 0.8, animations: { [unowned self] in
                
                self.classifyMenuMask.snp.updateConstraints {(make) in
                    
                    make.leading.equalTo(self.view)
                    make.trailing.equalTo(self.view)
                    make.height.equalTo(self.view.frame.size.height - 150)
                    make.top.equalTo(self.view).offset(150)
                }

            
            
            }, completion: { [unowned self] (true) -> Void in
                self.classifyMenuPanel.alpha = 1.0
                self.classifyMenuPanel.isHidden = false
                //展开菜单面板
                UIView.animate(withDuration: 0.8, animations: {
                    
                    self.classifyMenuPanel.snp.updateConstraints { [unowned self] (make) in
                        
                        make.leading.equalTo(self.view)
                        make.trailing.equalTo(self.view)
                        make.height.equalTo(240)
                        make.top.equalTo(self.view).offset(150)
                    }
                    
                    self.view.layoutIfNeeded()
                    
                    
                }, completion: {[unowned self] (true) -> Void in
                    
                    self.bIsExpand = true
                })
                
            })
            
        }
        
    
        
    }
    
    func tabOnUpload() {
        
        let uploadDialog : UploadTypeDialog = UploadTypeDialog.uploadDialogInstance
        
        uploadDialog.setOutSideCloseDialog(close: true)
        uploadDialog.setTitle(title: "选择上传文件类型")
        uploadDialog.show(parentView: self.view)
        
    }
    
    func tabOnTransList() {
        
    }
    
    
       
}








