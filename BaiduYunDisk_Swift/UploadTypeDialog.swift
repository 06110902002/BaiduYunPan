//
//  UploadTypeDialog.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit

class UploadTypeDialog : BaseDialog{

    static var uploadDialogInstance : UploadTypeDialog = UploadTypeDialog.init(frame: CGRect.init(x : 0, y : 0, width : UIScreen.main.bounds.width,
                                                                                                  height : UIScreen.main.bounds.height))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func initView() {
        super.initView()
        
        buildMenuItem()
    }

    
    func buildMenuItem() {
        
        let titles:[String] = ["图片","文档","音乐","视频","全部"]
        let icons :[String] = ["netdisk_category_image_normal","netdisk_category_document_normal","netdisk_category_video_normal",
                               "netdisk_category_bt_normal","netdisk_category_audio_normal"]
        
        for i in 0 ..< 2 {
            
            for j in 0 ..< 3{
                
                if i * 3 + j >= titles.count {
                    
                    break
                }
                
                let menuItem = ImgLabelView.init(frame: CGRect(x : j * Int((self.frame.width - 40) / 3),
                                                               y : i * 100 + 25,
                                                               width : Int((self.frame.width - 40) / 3),
                                                               height : 100))
                menuItem.image = icons[i * 3 + j]
                menuItem.sTips = titles[ i * 3 + j]
                menuItem.build(imgSize : CGSize.init(width: 50, height: 50),imgMarginTop: 20,textMarginTop: 25)
                menuItem.tag = i * 3 + j + 10
                menuItem.onClickListener = {(tag:Int) -> Void in
                    print("104--------------\(tag)")
                }
                self.menuItemPanel.addSubview(menuItem)
            }
            
        }

        
    }
    

}
