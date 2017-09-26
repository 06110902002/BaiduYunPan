//
//  YunDiskTableView.swift
//  BaiduYunDisk_Swift
//
//  Created by 刘小兵 on 2017/9/20.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

import UIKit


//首页网盘列表
class YunDiskTableView : BaseTableView{


    override func initAttr() {
        
        super.initAttr()
        
        self.backgroundColor = UIColor.init(red: 235.0 / 255.0, green:238.0/255.0, blue:237.0/255.0, alpha:1.0)
        
        initData()
        
        //添加头部刷新视图
        let scrollHeadView : YunDiskHeadForTabView = YunDiskHeadForTabView.init(frame: self.frame)
        scrollHeadView.addTargetWith(scrollView: self)
        scrollHeadView.refrsh(block:{()-> Void in
            
            DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + Double(Int64(3 *  Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)){
                
                self.dataList?.removeAll()
                for i in 0 ..< 1{
                    
                    let model:YunDiskResModel = YunDiskResModel()
                    
                    model.name = String.init(format: "refresh data %d", i)
                    
                    self.dataList?.append(model)
                }
                
                self.reloadData()
                scrollHeadView.refreshComplete()
                
            }
            
        })
        
    }
    
    func initData() {
        
        let optionModel : YunDiskOptionModel = YunDiskOptionModel();
        self.dataList?.append(optionModel)
        
        let wrods:[String] = ["隐藏空间","我的资源","笑傲江湖TVB版"]
        for item in wrods{
            
            let model : YunDiskResModel = YunDiskResModel()
            
            model.name = item
            
            self.dataList?.append(model)
        }

        
    }
    
    
    //override 达到展现不同的视图
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let baseModel  : BaseModel = self.dataList![indexPath.row];
        
        var cell  : BaseTabViewCell?
    
        switch (baseModel.getItemType()) {
            
            case CellItemType.yunDiskResType:
            
                cell = YunDiskResCell(style:UITableViewCellStyle.default, reuseIdentifier : "YunDiskResType")
                break;
            
            case CellItemType.yunDiskOptionType:
            
                cell = YunDiskOptionCell(style:UITableViewCellStyle.default, reuseIdentifier : "YunDiskOptionType")
                break;
            
            default:
            
                break;
        }
        
        cell!.bindData(data: baseModel)
        
        return cell!
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let baseModel : BaseModel = self.dataList![indexPath.row];
        var height :CGFloat = 0;
        
        switch (baseModel.getItemType()) {
            
        case CellItemType.yunDiskResType:
            height = 80;
            break;
            
        case CellItemType.yunDiskOptionType:
            height = 50;
            break;
            
        default:
            break;
        }
        
        return height;

    }
    
}

    

