//
//  MainVC.swift
//  SinaWeb(Swift)
//
//  Created by cyz on 16/10/29.
//  Copyright © 2016年 yuze. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
        // 1.添加子控制器
        // 创建一子控制器，在Swift中国你定义变量时候先使用let（常量），只有真正需要修改的时候才用var
        let VC = HomeVC();
        VC.tabBarItem.title = "首页"
        
        // Do any additional setup after loading the view.
    }
    
    // Swift中支持方法的重载，方法名允许相同，参数名不同
    override func addChildViewController(_ childController: UIViewController) {
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
