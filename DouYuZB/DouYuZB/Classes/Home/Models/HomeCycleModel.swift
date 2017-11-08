//
//  HomeCycleModel.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/21.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeCycleModel: NSObject {
    var title:String?
    var pic_url:String?
    var room:[String : NSObject]?{
        didSet{
            guard let room = room else {
                return
            }
            let data = try! JSONSerialization.data(withJSONObject: room, options: [])
            let json = JSON(data: data)
            anchor = AnchorModel.init(json)
        }
    }
    var anchor : AnchorModel?
    // MARK:- 自定义构造函数  KVC实现字典转模型
    init(_ json : JSON) {
        self.title = json["title"].string
        self.pic_url = json["pic_url"].string
        self.room    = (json["room"].object as! [String : NSObject])
    }
}
