//
//  AppDelegate.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/8.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // // 注册一个通知, 用于切换控制器
        NotificationCenter.default.addObserver(self, selector: #selector(switchRootViewController(_ :)), name: XMGSwitchRootViewController, object: nil)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController =  defaultContoller() //  MainViewController()
        window?.makeKeyAndVisible()
        
        // 设置导航条和工具条的外观
        // 因为外观一旦设置全局有效, 所以应该在程序一进来就设置
        UINavigationBar.appearance().tintColor = UIColor.orange
        UITabBar.appearance().tintColor = UIColor.orange
        
//        if #available(iOS 11.0,*) {
//            let scroll = UIScrollView.appearance()
//            scroll.contentInsetAdjustmentBehavior = .never
//        }
        return true
    }
    
    /**
     用于获取默认界面
     :returns: 默认界面
     */
    private func defaultContoller() -> UIViewController {
        // 1.检测用户是否登录
        if UserAccount.isUserLogin() {
            return isNewupdate() ? NewFeatureViewController() : WelcomeViewController()
        }
        return MainViewController()
    }
    
    private func isNewupdate() -> Bool {
        
        // 1.获取当前软件的版本号 --> info.plist
        let currentVersion = Bundle.main.infoDictionary![bundleVersionKey] as! String
        // 2.获取以前的软件版本号 --> 从本地文件中读取(以前自己存储的)
        let snandboxVersion = UserDefaults.standard.object(forKey: bundleVersionKey) as? String ?? ""
        
        // 3.比较当前版本号和以前版本号
        if currentVersion.compare(snandboxVersion) == .orderedDescending { // 有新版本
            // 3.1.1存储当前最新的版本号
            UserDefaults.standard.set(currentVersion, forKey: bundleVersionKey)
            
            return true
        } else {
            // 没有新版本
            return false
        }
    }

    @objc func switchRootViewController(_ notify: Notification) {
        
        if notify.object as! Bool {
            window?.rootViewController = MainViewController()
        } else {
            window?.rootViewController = WelcomeViewController()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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

