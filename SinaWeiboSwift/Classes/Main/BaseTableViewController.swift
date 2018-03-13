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
    var userLogin = false
    // 定义属性保存未登录界面
    var visitorView: VisitorView?
    
    override func loadView() {
         userLogin ? super.loadView() : setupVisitorView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
