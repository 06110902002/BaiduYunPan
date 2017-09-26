//
//  BaseTabViewCell.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import Foundation

import UIKit


/// UItableView 中的单元格基类  所有的单元格均需要重载本灰
class BaseTabViewCell: UITableViewCell {
    
    
    var label:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initItemView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 子类需要重载本接口
    func initItemView() {
        
        label = UILabel(frame:CGRect(x : 10.0 , y : self.center.y, width : 80, height:30))
        
        label?.text = "韦小宝"
        
        label?.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(label!)
        
    }
    
    
    
    /// 将数据模型与单元格绑定起来，子类需要重载本接口
    ///
    /// - Parameter data: <#data description#>
    func bindData(data:BaseModel){
        
    }
    
    
    /// 回收资源接口，子类必要时重载
    func recycRes(){
        
    }
    
}
