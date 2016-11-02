//
//  MainVC.swift
//  SinaWeb(Swift)
//
//  Created by cyz on 16/10/29.
//  Copyright © 2016年 yuze. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {
    var callBack:((String)->())?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // iOS7以后只需要设置tinColor,那么图片你和文字都会按照tintColor渲染
        tabBar.tintColor = UIColor.orange
        
        // 添加自控制器
        addChildViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.addSubview(composeButton)
        
    }
    
    // MARK: - 内部控制方法
    /// 添加所有子控制器
    private func addChildViewControllers() {
        // 1. 根据JSON文件创建控制器
        // 1.1读取JSON数据
        guard let filePath  = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            BLLog("JSON文件不存在")
            return
        }
        
        guard let data = NSData(contentsOfFile:filePath) else {
            BLLog("加载二进制数据失败")
            return
        }
        
        // 1.2将JSON数据转换为对象（数组字典)
        do {
            
            let obj =  try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:AnyObject]] // 声明解析出来的数据是数组，数组中存储着字典
            
            for dic in obj{
                let title = dic["title"] as? String
                let vcName = dic["vcName"] as? String
                let imageName = dic["imageName"] as? String
                addChildViewController(childControllerName: vcName, title: title, imageName: imageName)
            }
        } catch  {
            // 只要try对应的方法发生了异常，就会执行catch{}中的代码
            addChildViewController(childControllerName: "HomeVC", title: "首页", imageName: "tabbar_home")
            addChildViewController(childControllerName: "MessageVC", title: "消息", imageName:"tabbar_message_center")
                addChildViewController(childControllerName: "NULLVC", title: "", imageName: " ")
            addChildViewController(childControllerName: "DiscoverVC", title: "发现", imageName: "tabbar_discover")
            addChildViewController(childControllerName: "ProfileVC", title: "我", imageName: "tabbar_Profile")
            
        }
        
        
    }
       
    private func addChildViewController(childControllerName: String?, title: String?, imageName:String?) {
        
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
        guard let typeCls = cls as? UIViewController.Type else {
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
    
    // MARK: - 懒加载
    lazy var composeButton: UIButton = {
        ()->UIButton in 
        // 1. 创建按钮
        let btn = UIButton()
        // 2. 设置前景图片
//        UIImage.init(named: "tabbar_compose_icon_add") 等同于#imageLiteral(resourceName: "tabbar_compose_icon_add")
        btn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: UIControlState.normal)
        btn.setImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        // 3. 设置背景颜色
        btn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: UIControlState.normal)
        btn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        
        
//        UIButton.init(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_background_icon_add", state: .normal)
        
        // 4. 监听按钮点击
        btn.addTarget(self, action: #selector(compseBtnCLick(btn:)), for: UIControlEvents.touchUpInside)
        
        btn.sizeToFit() // 按钮大小自适应
        
        return btn
    }()
    
    /*
     如果给按钮的锦亭方法加上private就会报错，报错原因是因为监听事件是有运行循环触发的，而如果该方法是私有的只能在当前类中访问
     而相同的情况下OC中是没有问题的，因为OC是动态派发的
     而Swift不一样，Swift中所有的东西都是编译时确定的
     如果想让Swift中你的方法也支持动态派发可以在方法前面加上@objc
     加上@objc就告诉系统需要动态派发
     */
    @objc private func compseBtnCLick(btn:UIButton) -> Void {
        BLLog("点击了按钮")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
