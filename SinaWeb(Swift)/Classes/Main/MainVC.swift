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
        
        tabBar.tintColor = UIColor.orange
        
        // 1.添加子控制器
        // 创建一子控制器，在Swift中你定义变量时候先使用let（常量），只有真正需要修改的时候才用var
        let VC = HomeVC();
        VC.tabBarItem.title = "首页"
        
        // Do any additional setup after loading the view.
        
        testClosure() // 调用方法
    }
    
    private func testClosure() {
        // 1. 没有参数没有返回值的写法
        let say:() -> Void = {
            () -> () in // 当没有参数没有返回值的时候这行可以省略
            BLLog("没有返回值的闭包")
        }
        say()
        
        // 2. 有参数没有返回值的闭包
        let say2:((Int) -> Void) = {
            (a) -> () in
            BLLog("a=\(a)")
        }
        say2(3)
        
    }
    
    // Swift中支持方法的重载，方法名允许相同，参数名不同
    
    private func addChildViewController(childControllerName: String?, title: String, imageName:String?) {
        // 1. 动态获取命名空间
        guard let name = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String else {
            BLLog("获取命名空间失败")
            return
        }
        // 2. 根据字符串获取Class
        var cls:AnyClass? = nil
        if let vcName = childControllerName {
            cls = NSClassFromString(name + "." + vcName)
        }
        
        // 3. 通过Class创建对象
        // Swift中如果想通过一个CLass来创建一个对象，必须告诉系统这个Class的确切类型
        guard let typeCls = cls as? UITableViewController.Type else {
            BLLog("cls不能当做UITabelVIewController")
            return
        }
        // 通过Class创建对象
        let childController = typeCls.init()
        
        // 1.2设置子控制器的相关属性
        childController.title = title
        if let ivName = imageName {
            childController.tabBarItem.image = UIImage(named: ivName)
            childController.tabBarItem.selectedImage = UIImage(named:ivName + "_highlighted")
        }
        
        // 1.3 包装一个导航控制器
        let nav = UINavigationController(rootViewController: childController)
        // 1.4 将子控制器添加到UITabController中
        addChildViewController(nav) // 这个方法是UITabbarController自带的方法
    }
//    override func addChildViewController(_ childController: UIViewController) {
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
