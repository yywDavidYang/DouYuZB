//
//  UIBarButton_Extension.swift
//  DouYuZB
//
//  Created by YYW on 2017/9/28.
//  Copyright © 2017年 YYW. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName:String,heightImage:String,size:CGSize) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:heightImage), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.init(x: 0, y: 0), size: size)
        return UIBarButtonItem(customView: btn)
    }*/
    convenience init(imageName:String ,heightImage:String = "",size:CGSize = CGSize.zero){
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if heightImage != ""{
            btn.setImage(UIImage(named:heightImage), for: .highlighted)
        }
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView:btn)
    }
}

