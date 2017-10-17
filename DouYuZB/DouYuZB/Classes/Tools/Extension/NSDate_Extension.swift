//
//  NSDate_Extension.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/11.
//  Copyright © 2017年 YYW. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
