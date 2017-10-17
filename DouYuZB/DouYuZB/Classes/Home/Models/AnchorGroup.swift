//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/11.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import SwiftyJSON

public class AnchorGroup:NSObject{
    // 在该组中对应的信息
    var tag_name : String?
    var icon_name : String?
    var push_nearby : String?
    var tag_id : Int?
    var small_icon_url : String?
    var icon_url : String?
    var push_vertical_screen : Double?
    var room_list = [AnchorModel]()
    
    override init() {
        
    }
    // MARK:- 自定义构造函数  KVC实现字典转模型
    init(_ json : JSON) {
        super.init()
        self.tag_name  = json["tag_name"].string
        self.push_nearby  = json["push_nearby"].string
        self.tag_id  = json["tag_id"].intValue
        self.small_icon_url  = json["small_icon_url"].string
        self.icon_url  = json["icon_url"].string
        self.push_vertical_screen  = json["push_vertical_screen"].doubleValue
        
        let list = json["room_list"].arrayValue
        for dic in list{
            if let dataJson = dic.dictionaryObject{
                let json = JSON(dataJson)
                self.room_list.append(AnchorModel.init(json))
            }
        }
    }
    
    
}




















