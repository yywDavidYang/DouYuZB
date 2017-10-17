//
//  RecommandViewController.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/8.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * 10)/2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH:CGFloat = kItemW * 4 / 3
private let kHeaderH : CGFloat = 50
private let kNormalCellID  = "kNormalCellID"
private let kPrettyCellID  = "kPrettyCellID"
private let kHeaderViewID  = "kHeaderViewID"


class RecommandViewController: UIViewController {
     lazy var recommandViewModel:RecommandViewModel = RecommandViewModel()
    // 懒加载
    private lazy var reCollectionView:UICollectionView = {[weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = kItemMargin
        flowLayout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        // 设置UI界面
        setupUI()
        // 网络请求
        loadData()
    }
}

extension RecommandViewController{
    private func setupUI(){
        // 添加collectionView
        view.addSubview(reCollectionView)
    }
}

// Mark - 网络请求
extension RecommandViewController{
    private func loadData(){
        recommandViewModel.requestData(finishCallBack: {
            self.reCollectionView.reloadData()
        })
    }
}

// Mark - 遵守协议
extension RecommandViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommandViewModel.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommandViewModel.anchorGroups[section]
        return group.room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group  = recommandViewModel.anchorGroups[indexPath.section]
        let anchor = group.room_list[indexPath.row]
        if(indexPath.section == 1){
            let cell:CollectionViewPrettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
            cell.anchor = anchor
            return cell
        }else{
            let cell:CollectionViewNormalCell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
            cell.anchor = anchor
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! HomeCollectionHeaderView
        let group = recommandViewModel.anchorGroups[indexPath.section]
        headerView.group = group
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(indexPath.section == 1){
            return CGSize.init(width: kItemW, height: kPrettyItemH)
        }
        return CGSize.init(width: kItemW, height: kItemH)
    }
}














