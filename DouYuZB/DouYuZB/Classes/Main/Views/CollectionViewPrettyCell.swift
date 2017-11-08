//
//  CollectionViewPrettyCell.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/9.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: HomeCollectionViewBaseCell {

    @IBOutlet weak var labelOnlineNum: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var btnAddress: UIButton!
    
    var anchor:AnchorModel?
    {
        didSet{
            guard let anchor = anchor else {return}
            var onlineStr:String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/10000))"
            }else{
                onlineStr = "\(Int(anchor.online/10000))"
            }
            labelOnlineNum.text = onlineStr
            itemTitle.text = anchor.nickname
            btnAddress.setTitle(anchor.anchor_city, for: .normal)
            
            guard let iconUrl = NSURL.init(string: anchor.vertical_src!) else {
                return
            }
            itemImageView.kf.setImage(with: ImageResource.init(downloadURL: iconUrl as URL))
        }
    }
    
}
