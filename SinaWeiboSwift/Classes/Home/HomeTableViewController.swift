//
//  HomeTableViewController.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/10.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {
    /// 记录当前是否是展开
    var isPresent: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !userLogin {
            visitorView?.setupVisitorInfo(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 初始化导航条按钮
        setupNavgationItem()
        
        // 3.注册通知, 监听菜单
        NotificationCenter.default.addObserver(self, selector: #selector(change), name: PopoverAnimatorWillShowNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(change), name: PopoverAnimatorWilldismissNotificationName, object: nil)
        
    }

    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
     修改标题按钮的状态
     */
    @objc func change() {
        let titleBtn = navigationItem.titleView as! TitleButton
        titleBtn.isSelected = titleBtn.isSelected
        
    }
    // MARK: - 内部控制方法
    /**
     初始化导航条按钮
     */
    private func setupNavgationItem() {
        // 1.添加左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.crateBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(letBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.crateBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightBtnClick))
        
        let titleBtn = TitleButton()
        titleBtn.setTitle("极客江南 ", for: UIControlState.normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
    
   @objc func titleBtnClick(_ btn :UIButton) {
    
        btn.isSelected = !btn.isSelected
    
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        vc?.transitioningDelegate = popverAnimator // 交给专门负责转场动画的类处理
        vc?.modalPresentationStyle = .custom
    
        present(vc!, animated: true) {
        
        }
        // 2.1设置转场代理
        // 默认情况下modal会移除以前控制器的view, 替换为当前弹出的view
        // 如果自定义转场, 那么就不会移除以前控制器的view
    }

    
    @objc func letBtnClick() {
        print(#function)
    }
    
    @objc func rightBtnClick() {
        print(#function)
        let sb  = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let vc  = sb.instantiateInitialViewController()
        
        present(vc!, animated: true) {
            
        }
    }
    
    // MARK: - 懒加载
    /// 一定要定义一个属性来报错自定义转场对象, 否则会报错
    private lazy var popverAnimator : PopoverAnimator = {
        let pa = PopoverAnimator()
        pa.presentFrame = CGRect(x: 100, y: 56, width: 200, height: 200)
        return pa
    }()
    
    
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

