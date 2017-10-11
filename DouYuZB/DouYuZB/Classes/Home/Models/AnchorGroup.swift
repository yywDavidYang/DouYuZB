//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/11.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    // 在该组中对应的信息
    var room_list : [[String:NSObject]]?
    var tag_name : String?
    var push_nearby : String?
    var tag_id : String?
    var small_icon_url : String?
    var icon_url : String?
    var push_vertical_screen : String?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
