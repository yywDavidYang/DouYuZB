//
//  RecommendCycleViewCell.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/23.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendCycleViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewContent: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cycleModel : HomeCycleModel? {
        didSet{
            labelTitle?.text = cycleModel?.title
            guard let iconUrl = NSURL.init(string: cycleModel?.pic_url ?? "") else {
                return
            }
            imageViewContent?.kf.setImage(with: ImageResource.init(downloadURL: iconUrl as URL))
        }
    }
    
}
