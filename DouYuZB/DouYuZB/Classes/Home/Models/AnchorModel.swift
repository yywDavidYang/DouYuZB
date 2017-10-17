//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/15.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import SwiftyJSON

public class AnchorModel{
    // 在该组中对应的信息
    var room_id :Int = 0
    var vertical_src : String?
    var isVertical : Int = 0
    var room_name : String?
    var nickname : String?
    var online:Int = 0
    var anchor_city:String?
    
    
    // MARK:- 自定义构造函数  KVC实现字典转模型
    init(_ json : JSON) {
        self.room_id = json["room_id"].intValue
        self.vertical_src = json["vertical_src"].string
        self.isVertical   = json["isVertical"].intValue
        self.room_name    = json["room_name"].string
        self.nickname     = json["nickname"].string
        self.online       = json["online"].intValue
        self.anchor_city  = json["anchor_city"].string
    }
}
