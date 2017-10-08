//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by YYW on 2017/9/25.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    // 使用懒加载实现pageTitleView
    lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleViewFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleViewFrame, titles: titles)
        titleView.delegate = self as! PageTitleViewDelegate
        return titleView
    }()
    
    lazy var pageContentView:PageContentView = {
        let contentH = kScreenH - (kStatusBarH + kNavigationBarH + kTitleViewH)
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
        let contentViewColors = [UIColor.orange,UIColor.blue,UIColor.red,UIColor.white]
        for _ in 0...3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏按钮
        setupUI()
       
        
    }
}

extension HomeViewController{
    func setupUI() {
        // 设置导航栏
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let historyItem = UIBarButtonItem(imageName: "image_my_history", heightImage: "Image_my_history_click", size: CGSize(width: 40, height: 40))
        let searchItem = UIBarButtonItem(imageName: "btn_search", heightImage: "btn_search_clicked", size: CGSize(width: 40, height: 40))
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", heightImage: "Image_scan_click", size: CGSize(width: 40, height: 40))
    
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
    }
}

// Mark - 遵守PageTitleViewDelegate协议
extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        print(selectedIndex)
        pageContentView.setCurrentIndex(currentSelectIndex: selectedIndex)
    }
}

// Mark - 遵守PageContentViewDelegate协议
extension HomeViewController:PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

















