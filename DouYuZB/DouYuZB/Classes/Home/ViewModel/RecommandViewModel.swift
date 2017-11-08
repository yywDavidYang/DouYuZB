//
//  RecommandViewModel.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/11.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommandViewModel {
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    var bigDataGroup:AnchorGroup = AnchorGroup()
    var prettyGroup:AnchorGroup = AnchorGroup()
    var cycleModels:[HomeCycleModel] = [HomeCycleModel]()
    
}

extension RecommandViewModel {
    func requestCycleData(finishCallBack:@escaping ()->()) {
        NetworkTool.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/slide/6?version=1.0") { (result) in
            print("滚动数据=\(result)")
            // 转成字典类型
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            // 转成数组类型
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            for dic in dataArray{
                let data = try! JSONSerialization.data(withJSONObject: dic, options: [])
                let json = JSON(data: data)
                let model = HomeCycleModel.init(json)
                self.cycleModels.append(model)
            }
            finishCallBack()
        }
    }
    func requestData(finishCallBack:@escaping ()->()){
        //1.部分推荐数据
        // 创建一个group
        let disGroup = DispatchGroup()
        disGroup.enter()
        NetworkTool.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=\(NSDate.getCurrentTime())") { (result) in
            // 转成字典类型
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            // 转成数组类型
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            // 遍历数组，转成模型对象
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dic in dataArray{
                let data = try! JSONSerialization.data(withJSONObject: dic, options: [])
                let json = JSON(data: data)
                let model = AnchorModel.init(json)
                self.bigDataGroup.room_list.append(model)
            }
            disGroup.leave()
        }
        
        
        
        // 颜值数据
        disGroup.enter()
        let urlVerticalStr = "http://capi.douyucdn.cn/api/v1/getVerticalRoom?time=\(NSDate.getCurrentTime())"
        NetworkTool.requestData(type: .GET, url: urlVerticalStr) { (result) in
            // 转成字典类型
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            // 转成数组类型
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            // 遍历数组，转成模型对象
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dic in dataArray{
                let data = try! JSONSerialization.data(withJSONObject: dic, options: [])
                let json = JSON(data: data)
                let model = AnchorModel.init(json)
                self.prettyGroup.room_list.append(model)
            }
//            for model in self.prettyGroup.room_list{
//                print(model.nickname as Any)
//            }
            disGroup.leave()
        }
        
        // 热门数据
        disGroup.enter()
        let urlHotCateStr = "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=\(NSDate.getCurrentTime())"
        NetworkTool.requestData(type: .GET, url: urlHotCateStr) { (result) in
            // 转成字典类型
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            // 转成数组类型
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            // 遍历数组，转成模型对象
            for dic in dataArray{
                let data = try! JSONSerialization.data(withJSONObject: dic, options: [])
                let json = JSON(data: data)
                 let group = AnchorGroup.init(json)
                self.anchorGroups.append(group)
            }
            disGroup.leave()
        }
        disGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
    }
}
