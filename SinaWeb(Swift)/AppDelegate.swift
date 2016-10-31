//
//  AppDelegate.swift
//  SinaWeb(Swift)
//
//  Created by cyz on 16/10/29.
//  Copyright © 2016年 yuze. All rights reserved.
//

import UIKit
import QorumLogs
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        BLLog(123456)
//        BLLog(QL1(123456))
        // 1. 创建Widow
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white;
        
        // 2. 设置根控制器
        window?.rootViewController = MainVC();
        
        // 3. 显示window
        window?.makeKeyAndVisible();
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
// 在

/// 自定义Log,在DEBUG状态下才有打印输出,发布隐藏
///
/// - parameter message:    输出信息
/// - parameter fileName:   文件名
/// - parameter methodName: 方法名
/// - parameter lineName:   行号
func BLLog<T>(_ message:T,fileName:String = #file, methodName:String = #function, lineName:Int = #line)
{
    
    #if DEBUG
        let className = (fileName as NSString).pathComponents.last!.components(separatedBy: ".")[0]
        print("\(className)->\(methodName)[\(lineName)] \(message)")
    #endif
    
}



