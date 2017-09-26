//
//  BaseTableView.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//
import Foundation
import UIKit

class BaseTableView : UITableView,UITableViewDelegate,UITableViewDataSource{
    
    
    var dataList:Array<BaseModel>?
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.frame = frame
        initAttr()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttr(){
        
        self.dataList = Array()
        self.dataSource = self
        self.delegate = self
        
    }
    
    
    
    /// 获取单元格高度--子类需要重载
    ///
    /// - Returns: 单元格高度
    func getCellHeight() -> CGFloat {
        
        return 70.0
    }
    
    
    /// 构建单元格视图子类需重载，不然显示默认视图
    ///
    /// - Returns: 单元格视图
    func buildTableViewCell() -> BaseTabViewCell {
        print("子类赶紧去重载吧，不然单元格是默认视图")
        
        return BaseTabViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "BaseCell")
        
    }
    
    //implements protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataList?.count)!
    }
    
    
    //implements protocol
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return getCellHeight()
    }
    
    //implements protocol
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = buildTableViewCell()
        
        cell.frame = CGRect(x : 0, y : 0, width : self.frame.width, height : self.getCellHeight())
        
        
        let data :BaseModel = (dataList?[indexPath.row])!
        
        cell.bindData(data: data)
        
        return cell
        
    }
    
    
}
