//
//  VisitorView.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/11.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit
import SnapKit

protocol VisitorViewDelegate: NSObjectProtocol {
    // 登录回调
    func loginBtnWillClick()
    // 注册回调
    func registerBtnWillClick()
}

class VisitorView: UIView {
    // 定义一个属性保存代理对象
    // 一定要加上weak, 避免循环引用
    weak var delegate: VisitorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 1.添加子控件
        addSubview(iconView)
        addSubview(maskBGView)
        addSubview(homeIcon)
        addSubview(messageLabel)
        addSubview(loginButton)
        addSubview(registerButton)
        
        // 2.布局子控件
        iconView.snp.makeConstraints { (make) in
            make.center.equalToSuperview() // 好像也可以这么写嘛
        }
        
        homeIcon.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom)
            make.width.equalTo(224) //--
        }
        // 这里是自动布局的万能公式
        // "哪个控件" 的 "什么属性" "等于(关系)" "另外一个控件" 的 "什么属性" 乘以 "多少" 加上 "多少"
//        let widthCons = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 224)
//        addConstraint(widthCons)
        
        registerButton.snp.makeConstraints { (make) in
            make.left.equalTo(messageLabel)
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }

        loginButton.snp.makeConstraints { (make) in
            make.right.equalTo(messageLabel)
            make.top.size.equalTo(registerButton)
        }
        
        maskBGView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    func setupVisitorInfo(isHome:Bool, imageName:String, message:String) {
        iconView.isHidden = !isHome
        homeIcon.image = UIImage(named: imageName)
        messageLabel.text = message
        
        if isHome {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        // 创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.duration = 20
        anim.repeatCount = MAXFLOAT
        // Defaults to YES , 表示动画只要执行完毕就被移除
        anim.isRemovedOnCompletion = false
        // 将动画添加到图层上
        iconView.layer.add(anim, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loginBtnClick() {
        delegate?.loginBtnWillClick()
    }
    
    @objc func registerBtnClick() {
        delegate?.registerBtnWillClick()
    }
    
    // MARK: - 懒加载控件
    // 转盘
    private lazy var iconView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iv
    }()
    
    /// 图标
    private lazy var homeIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return iv
    }()
    /// 文本
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        label.text = "打附加赛可垃圾分类考试的减肥了快速的减肥两款手机的两款手机立刻"
        return label
    }()
    /// 登录按钮
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitle("登陆", for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: .normal)
        btn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        return btn
    }()
    /// 注册按钮
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        
        btn.setTitleColor(UIColor.orange, for: .normal)
        btn.setTitle("注册", for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: .normal)
        btn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)

        return btn
    }()
    
    private lazy var maskBGView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return iv
    }()
}
