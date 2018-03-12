//
//  PopoverPresentationController.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {

    /// 定义属性保存菜单的大小
    var presentFrame = CGRect.zero
    
    /**
     初始化方法, 用于创建负责转场动画的对象
     
     :param: presentedViewController  被展现的控制器
     :param: presentingViewController 发起的控制器, Xocde6是nil, Xcode7是野指针
     
     :returns: 负责转场动画的对象
     */
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
    }
    
    /**
     即将布局转场子视图时调用
     */
    override func containerViewWillLayoutSubviews() {
        // 1.修改弹出视图的大小
        //        containerView; // 容器视图
        //        presentedView() // 被展现的视图
        if presentFrame == CGRect.zero {
            
            presentedView?.frame = CGRect(x: 100, y: 56, width: 200, height: 200) // TODO 动态获取
        } else {
            presentedView?.frame = presentFrame
        }
        
        
        // 2.在容器视图上添加一个蒙版, 插入到展现视图的下面
        // 因为展现视图和蒙版都在都一个视图上, 而后添加的会盖住先添加的
        containerView?.insertSubview(coverView, at: 0)
//        containerView?.sendSubview(toBack: coverView)
    }
    
    // MARK: - 懒加载
    
    private lazy var coverView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.frame = UIScreen.main.bounds
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    @objc func close() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}


