//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by YYW on 2017/9/28.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

// Mark - 定义常量
private let kScrollLineH:CGFloat = 2
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)
// 该协议只能被类遵守，如果不表明是class，就可以被结构体，类或者枚举遵守
protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,selectedIndex:Int)
}

class PageTitleView: UIView {
    var titles:[String]
    var currentIndex:Int = 0
    // 定义代理的属性
    weak var delegate:PageTitleViewDelegate?
    
    lazy var scrollView:UIScrollView = {
        let scrollView:UIScrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollViewLine:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
    
    lazy var titleTabels:[UILabel] = [UILabel]()
    // 自定义构造函数，必须实现系统的默认的构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        // 布局界面
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView{
    func setupUI() {
        
        addSubview(scrollView)
        scrollView.frame = self.bounds
        // 添加文字
        setupTitleLabels();
        
        // 设置底线和滑块
        setupBottomLineAndScrollLine()
        
    }
    private func setupTitleLabels(){
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        for (index, title) in titles.enumerated(){
            let label = UILabel()
            label.tag = index
            label.text = title
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 设置label的frame
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleTabels.append(label)
            label.isUserInteractionEnabled = true
            let tapGs = UITapGestureRecognizer(target: self, action: #selector(self.tapGesClickAction(tap:)))
            label.addGestureRecognizer(tapGs)
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        line.frame = CGRect(x: 0, y: frame.height - 0.5, width: kScreenW, height: 0.5)
        addSubview(line)
        // guard 保镖
        guard let firstLabel = titleTabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollView.addSubview(scrollViewLine)
        scrollViewLine.frame = CGRect(x: firstLabel.frame.origin.x, y: firstLabel.frame.height - kScrollLineH + 1.5, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

// Mark - 监听手势
extension PageTitleView{
    @objc func tapGesClickAction(tap:UITapGestureRecognizer){
      print("点击")
        // 使用guar对currentLabel的值是否存在做一个保护
        guard let currentLabel = tap.view as? UILabel else{
            return
    }
        // 获取上一个label
        let oldLabel = titleTabels[currentIndex]
        currentIndex = currentLabel.tag
        
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        let scrollLineX = CGFloat(currentLabel.tag) * currentLabel.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollViewLine.frame.origin.x = scrollLineX
        }
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}


// Mark - 对外暴露一个方法
extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        let sourceLabel = titleTabels[sourceIndex]
        let targetLabel = titleTabels[targetIndex]
        
        // 处理滑块
        let movToX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX  = movToX*progress
        scrollViewLine.frame.origin.x = moveX + sourceLabel.frame.origin.x
        
        // 设置颜色的变化范围
        let colorData = (kSelectedColor.0 - kNormalColor.0,kSelectedColor.1 - kNormalColor.1,kSelectedColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorData.0 * progress, g: kSelectedColor.1 - colorData.1 * progress, b: kSelectedColor.2 - colorData.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorData.0 * progress, g: kNormalColor.1 + colorData.1 * progress, b: kNormalColor.2 + colorData.2 * progress)
        
        // 记录最新的currentIndex
        currentIndex = targetIndex
    }
}















