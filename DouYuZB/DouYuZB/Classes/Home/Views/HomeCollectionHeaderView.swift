//
//  HomeCollectionHeaderView.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/9.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

class HomeCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var imageViewSection: UIImageView!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var labelSectionTitle: UILabel!
    var group:AnchorGroup?{
        didSet{
            labelSectionTitle.text = group?.tag_name
            imageViewSection.image = UIImage(named:group?.icon_name ?? "home_header_normal")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
