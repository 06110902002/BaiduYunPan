//
//  BaseModel.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import Foundation


enum CellItemType {
    
    case defaultType
    
    case yunDiskResType
    
    case yunDiskOptionType
    
}


/// 单元格对应的数据类型接口
protocol ItemType {
    
    func getItemType() -> CellItemType
}


class BaseModel : NSObject,ItemType{
    
    var name:String = "defalue name"
    
    var delegate: ItemType?
    
    override init() {
        super.init()
        
        self.delegate = self
    }
    
    //implement ItemType interface
    func getItemType() -> CellItemType {
        
        return CellItemType.defaultType
    }
    
    
}
