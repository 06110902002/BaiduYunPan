//
//  YunDiskResModel.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import Foundation

class YunDiskResModel : BaseModel{

    var time : String = "2017-09-20"
    
    var resIcon : String  = ""
    
    var resSelectStatus : Bool = false
    
    override func getItemType() -> CellItemType {
        
        return .yunDiskResType
    }

}
