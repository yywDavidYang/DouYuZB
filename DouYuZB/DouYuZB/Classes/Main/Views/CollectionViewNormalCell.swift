//
//  CollectionViewNormalCell.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/9.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewNormalCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var labelDscri: UILabel!
    @IBOutlet weak var btnOnline: UIButton!
    @IBOutlet weak var labelItemTitle: UILabel!
    
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
            labelDscri.text = anchor.room_name
            labelItemTitle.text = anchor.nickname
            btnOnline.setTitle(onlineStr, for: .normal)
            
            guard let iconUrl = NSURL.init(string: anchor.vertical_src!) else {
                return
            }
            itemImageView.kf.setImage(with: ImageResource.init(downloadURL: iconUrl as URL))
        }
    }

}
