//
//  YunDiskOptionModel.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit

class YunDiskOptionModel: BaseModel {
    
    lazy var sortIcon : String = ""
    
    lazy var newDirectoryIcon : String = ""
    
    lazy var searchIcon : String = ""
    
    
    override func getItemType() -> CellItemType {
        
        return .yunDiskOptionType
    }
}
