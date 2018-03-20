//
//  BaseTableViewController.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/11.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    // 定义一个变量保存用户当前是否登录
    var userLogin = UserAccount.isUserLogin()
    // 定义属性保存未登录界面
    var visitorView: VisitorView?
    
    override func loadView() {
         userLogin ? super.loadView() : setupVisitorView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 如果没有登录就设置未登录界面信息
        if !userLogin {
            
            if self is HomeTableViewController {
                print("home")
                visitorView?.setupVisitorInfo(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            } else if self is MessageTableViewController {
                print("message")
                visitorView?.setupVisitorInfo(isHome: false, imageName: "visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
            } else if self is DiscoverTableViewController {
                print("discover")
                visitorView?.setupVisitorInfo(isHome: false, imageName: "visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
            } else if self is ProfileTableViewController {
                visitorView?.setupVisitorInfo(isHome: false, imageName: "visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            }
            
        }
    }

    
    // MARK: - 内部控制方法
    /**
     创建未登录界面
     */
    private func setupVisitorView() {
        // 初始化未登录页面
        let customView = VisitorView()
        customView.delegate = self
        view = customView
        visitorView = customView
        
        // 2.设置导航条未登录按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(registerBtnWillClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action: #selector(loginBtnWillClick))
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

extension BaseTableViewController: VisitorViewDelegate {
    // MARK: - VisitorViewDelegate
    @objc func loginBtnWillClick() {
        print(#function)
        let oa = OAuthViewController()
        
        let nav  = UINavigationController(rootViewController: oa)
        
        present(nav, animated: true, completion: nil)
    }
    
    @objc func registerBtnWillClick() {
        print(#function)
    }
}
