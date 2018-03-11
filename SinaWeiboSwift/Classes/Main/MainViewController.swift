//
//  MainViewController.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/10.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置当前控制器对应的tabbar颜色
//        tabBar.tintColor = UIColor.orange
        addChildViewControllers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupComposeBtn()
    }
    
   
    private func setupComposeBtn() {
        // 1.添加加号按钮
        tabBar.addSubview(composeBtn)
        
        // 2.调整加号按钮的位置
        let width = UIScreen.main.bounds.size.width / CGFloat(viewControllers!.count)
        let rect  = CGRect(x: 0, y: 0, width: width, height: 49).offsetBy(dx: 2*width, dy: 0)
        
        // 第一个参数:是frame的大小
        // 第二个参数:是x方向偏移的大小
        // 第三个参数: 是y方向偏移的大小
        composeBtn.frame = rect
    }
    
    func addChildViewControllers() {
        
        let path = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil)
        
        if let jsonPath = path {
            
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonPath))

                do {
                    let dictArr = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
                    for dict in dictArr as! [[String: String]] {
                        addChildViewController(childControllerName: dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                    }
                    
                } catch {
                    print(error)
                }
                
                
                
            } catch {

                print(error)
            }
            
            
            
            addChildViewController(childControllerName: "HomeTableViewController", title: "首页", imageName: "tabbar_home")
            
            addChildViewController(childControllerName: "MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            
            addChildViewController(childControllerName: "NullViewController", title: "", imageName: "")
            
            addChildViewController(childControllerName: "DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
            
            addChildViewController(childControllerName: "ProfileTableViewController", title: "我", imageName: "tabbar_profile")
        }
        
    }
    
    func addChildViewController(childControllerName: String, title:String, imageName:String) {
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        
        let classString = nameSpace + "." + childControllerName
        
        let cls:AnyClass = NSClassFromString(classString)!
        let vcCls = cls as! UIViewController.Type
        let vc = vcCls.init()
        
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        vc.title = title
        
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        
        addChildViewController(nav)
    }

    /**
     监听加号按钮点击
     注意: 监听按钮点击的方法不能是私有方法
     按钮点击事件的调用是由 运行循环 监听并且以消息机制传递的，因此，按钮监听函数不能设置为 private
     */
     @objc func composeBtnClick() {
        
        print(tabBar.frame.height)
        print(#function)
    }
    
    // MARK: - 懒加载
    private lazy var composeBtn: UIButton = {
         let btn = UIButton()
        // 2.设置前景图片
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: .normal)
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        
        // 3.设置背景图片
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        
        // 4.添加监听
        btn.addTarget(self, action: #selector(composeBtnClick), for: .touchUpInside)
        
        return btn
    }()
    
    
    
}
