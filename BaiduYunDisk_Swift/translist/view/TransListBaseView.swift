//
//  TransListVC.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/26.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit

class TransListBaseView: UIView {
    
    lazy var imgTips : UIImageView = { return UIImageView() }()
    
    lazy var labelTips : UILabel = { return UILabel()}()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setImgTips(size : CGRect,imgName : String) {
        
        imgTips.frame = size
        imgTips.image = UIImage.init(named: imgName)
        imgTips.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(imgTips)
    }
    
    func setLabelTips(size : CGRect, text : String,color : UIColor, font : UIFont) {
        
        labelTips.frame = size
        labelTips.text = text
        labelTips.textColor = color
        labelTips.font = font
        labelTips.textAlignment = NSTextAlignment.center
        self.addSubview(labelTips)
    }
}
