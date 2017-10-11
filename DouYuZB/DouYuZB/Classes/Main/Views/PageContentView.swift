//
//  PageContentView.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/7.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

private let ContenCellID = "ContenCellID"

protocol PageContentViewDelegate :class{
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

class PageContentView: UIView {

    var childVCs:[UIViewController]
    weak var parentViewController:UIViewController?// 可选链
    var startOffSetX:CGFloat = 0
    weak var delegate:PageContentViewDelegate?
    var  isForbidScroll:Bool = false
    
    // 创建UICollectionView
    // weak 只能修饰可选类型
    lazy var colletionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!// 如果确定self一定存在，那么就可以强制进行解包
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContenCellID)
       return collectionView
    }()
    
    init(frame: CGRect,childVCs:[UIViewController],parentViewController:UIViewController) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView{
    func setupUI(){
        for childVC in childVCs{
           parentViewController?.addChildViewController(childVC)
        }
        // 添加UICollectionView
        addSubview(colletionView)
        colletionView.frame = bounds
    }
}

// Mark - 遵循datasource协议
extension PageContentView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContenCellID, for: indexPath)
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}

// Mark - 遵循delegate协议
extension PageContentView:UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffSetX = scrollView.contentOffset.x
        isForbidScroll = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScroll {return}
        var progress:CGFloat = 0
        var sourceIndex = 0
        var targetIndex = 0
        
        let contentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        let ratio = contentOffSetX/scrollViewW
        
        if scrollView.contentOffset.x>startOffSetX{// 左滑
            progress = ratio - floor(ratio)
            sourceIndex = Int(ratio)
            targetIndex = sourceIndex + 1
            if(targetIndex >= childVCs.count){
                targetIndex = childVCs.count - 1
            }
            
            if contentOffSetX - startOffSetX == scrollViewW{
                progress = 1.0
                targetIndex = sourceIndex
            }
        }else{//右滑
            progress = 1 - (ratio - floor(ratio))
            targetIndex = Int(ratio)
            sourceIndex = targetIndex + 1
            if(sourceIndex >= childVCs.count){
                sourceIndex = childVCs.count - 1
            }
        }
        
        print("progress:\(progress),sourceIndex:\(sourceIndex),tagetIndex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



extension PageContentView{
    func setCurrentIndex(currentSelectIndex:Int){
        isForbidScroll = true
        let offsetX = CGFloat(currentSelectIndex) * colletionView.frame.width
     colletionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
}






