//
//  UIColor_Extension.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/7.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat){
        self.init(red:r/255,green:g/255,blue:b/255,alpha:1)
    }
}
