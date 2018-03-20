//
//  WelcomeViewController.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/17.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.添加子控件
        view.addSubview(bgIV)
        view.addSubview(iconView)
        view.addSubview(messageLabel)
        
        // 2.布局子控件
        bgIV.frame = view.bounds
        
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-150)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(20)
        }
        
        // 3.设置用户头像
        if let iconUrl  = UserAccount.loadAccount()?.avatar_large {
            
            let  url  = URL(string: iconUrl)
            
            iconView.sd_setImage(with: url, completed: nil)
        }
    }


    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        
        let bottomConstant = UIScreen.main.bounds.size.height - 100 - 35
        
        iconView.snp.updateConstraints { (make) in
            
            make.bottom.equalToSuperview().offset(-bottomConstant)
        }
        
        view.setNeedsUpdateConstraints()
        view.needsUpdateConstraints()
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            
            self.view.layoutIfNeeded()
        }, completion: {
            (_) in
            
            UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
                
                self.messageLabel.alpha = 1.0
                
            }, completion: {
                (_) in
                // 去主页
                print("OK")
                NotificationCenter.default.post(name: XMGSwitchRootViewController, object: true)
                
            })
            
        })
        
    }
    
    // MARK: -懒加载
    private lazy var bgIV: UIImageView = UIImageView(image: #imageLiteral(resourceName: "ad_background"))
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "欢迎回来"
        label.sizeToFit()
        label.alpha = 0.0
        return label
    }()
    
}
