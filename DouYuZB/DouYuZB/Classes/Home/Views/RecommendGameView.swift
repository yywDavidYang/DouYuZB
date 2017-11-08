//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/23.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

class RecommendGameView: UIView {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var groups:[AnchorGroup]?{
        didSet{
            groups?.removeFirst()
            groups?.removeFirst()
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        collectionView.register(UINib(nibName: "RecommendGameViewCell", bundle: nil), forCellWithReuseIdentifier: "GameCellID")
    }
}

extension RecommendGameView{
    class func recommandGameView()->RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCellID", for: indexPath) as! RecommendGameViewCell
//        cell.contentView.backgroundColor = indexPath.item % 2 == 0 ? UIColor.orange:UIColor.brown
        let model = groups![indexPath.item]
        cell.group = model
        return cell
    }
}
