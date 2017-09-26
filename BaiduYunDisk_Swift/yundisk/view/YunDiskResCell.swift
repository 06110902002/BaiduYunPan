//
//  YunDiskResCell.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class YunDiskResCell : BaseTabViewCell{

    
    var labelResName : UILabel?
    
    lazy var labelTime : UILabel = UILabel()
    
    lazy var imgResIcon : UIImageView = UIImageView()
    
    lazy var imgResStatus : UIImageView  = UIImageView()
    
    var data:YunDiskResModel?
    
    
    override func initItemView() {
        
        self.backgroundColor = UIColor.white
        
        imgResIcon.image = UIImage.init(named: "inbox_unknow_folder.png")
        imgResIcon.contentMode = UIViewContentMode.scaleToFill
        
        self.addSubview(imgResIcon)
        imgResIcon.snp.makeConstraints({(make)in
            
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 59, height: 53))
        
        })
        
        labelResName = UILabel()
        labelResName?.text = "韦小宝"
        labelResName?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(labelResName!)
        
        labelResName?.snp.makeConstraints({(make)in
            
            make.leading.equalTo(self).offset(59 + 20)
            make.trailing.equalTo(self).offset(-50)
            make.top.equalTo(self).offset(20)
            
        })
        
       
        labelTime.text = "2017-09-20"
        labelTime.font = UIFont.systemFont(ofSize: 12)
        labelTime.textColor = UIColor.init(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1.0)
        self.addSubview(labelTime)
        
        labelTime.snp.makeConstraints({ [unowned self] (make)in
            make.left.equalTo(self.labelResName!)
            make.top.equalTo(self.labelResName!).offset(30)
            make.width.equalTo(140)
            
        })

        self.addOnClickListener(target: self, action: #selector(onClick))
        
        
    }
    
    override func bindData(data: BaseModel) {
        
        if self.data != data {
            
            self.data = data as? YunDiskResModel
            labelResName?.text = self.data?.name
        }
    }


    func onClick() {
      
        
        guard let msgInfo = self.data else {
            return
        }
        
        let info : NSDictionary = NSDictionary.init(object: msgInfo, forKey: "ItemInfo" as NSCopying)
        NotificationCenter.default.post(name:NSNotification.Name(rawValue:"SelectItemInfo"), object: info, userInfo: nil)
    }

}
