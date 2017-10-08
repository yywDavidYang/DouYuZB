//
//  MainViewController.swift
//  DouYuZB
//
//  Created by YYW on 2017/9/25.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBarChildVC(storyboardName: "Home")
        addTabBarChildVC(storyboardName: "Live")
        addTabBarChildVC(storyboardName: "Follow")
        addTabBarChildVC(storyboardName: "Profile")
        
        // Do any additional setup after loading the view.
    }

    private func addTabBarChildVC(storyboardName:String){
        let childVC = UIStoryboard.init(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
