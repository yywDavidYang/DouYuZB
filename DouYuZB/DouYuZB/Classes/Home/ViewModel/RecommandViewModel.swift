//
//  RecommandViewModel.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/11.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

class RecommandViewModel {
   private lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
}

extension RecommandViewModel {
    func requestData(){
        //1.部分推荐数据
        //2.颜值数据
        //3.游戏数据
        
        
        NetworkTool.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getHotCate") { (result) in
            print(result)
            // 转成字典类型
            guard let resultDic = result as? [String : NSObject] else {
                return
                
            }
            // 转成数组类型
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            // 遍历数组，转成模型对象
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups{
                print(group.tag_name)
            }
        }
    }
}
