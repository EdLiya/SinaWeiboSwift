//
//  QRCodeViewController.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    /// 底部视图
    @IBOutlet weak var customTabBar: UITabBar!
    
    /// 扫描容器高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    /// 冲击波视图顶部约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    /// 冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.设置底部视图默认选中第0个
        customTabBar.selectedItem = customTabBar.items?.first
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startAnimation()
    }
    
    /**
     执行动画
     */
    private func startAnimation() {
        // 让约束从顶部开始
        scanLineCons.constant = -scanLineCons.constant
        scanLineView.layoutIfNeeded()
        // 执行冲击波动画
        UIView.animate(withDuration: 2.0) {
            // 1.修改约束
            self.scanLineCons.constant = self.containerHeightCons.constant
            // 设置动画指定的次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            // 2.强制更新界面
            self.scanLineView.layoutIfNeeded()
        }
    }

    @IBAction func closeBtnClick(_ sender: Any) {
        
        dismiss(animated: true) {
            
        }
    }
    
}
