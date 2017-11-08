//
//  RecommendGameViewCell.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/24.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendGameViewCell: UICollectionViewCell {
    var group:AnchorGroup?{
        didSet{
            labelTitle?.text = group?.tag_name
            guard let iconUrl = NSURL.init(string: group?.icon_url ?? "") else {
                return
            }
            imageViewContent?.kf.setImage(with: ImageResource.init(downloadURL: iconUrl as URL))
        }
    }
    @IBOutlet weak var imageViewContent: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewContent.layer.cornerRadius = imageViewContent.frame.width / 2.0
        imageViewContent.layer.masksToBounds = true
    }

}
