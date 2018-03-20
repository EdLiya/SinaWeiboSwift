//
//  StatusTableViewCell.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/20.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit
import SnapKit

class StatusTableViewCell: UITableViewCell {

    var status: Status? {
        didSet {
            nameLabel.text = status?.user?.name
            
            timeLabel.text = "刚刚"
            sourceLabel.text = "来自: 小霸王学习机"
            contentLabel.text = status?.text
        }
    }
    
    // 自定义一个类需要重写的init方法是 designated
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        // 1.添加子控件
        contentView.addSubview(iconView)
        contentView.addSubview(verifiedView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(vipView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(footerView)
        footerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        
        nameLabel.backgroundColor = UIColor.randomColor()
        // 布局
        iconView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.width.height.equalTo(50)
        }
        verifiedView.snp.makeConstraints { (make) in
            make.width.height.equalTo(14)
            make.bottom.right.equalTo(iconView).offset(5)
        }
        nameLabel.snp.makeConstraints { (make ) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(10)
        }
        vipView.snp.makeConstraints { (make ) in
            make.top.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.width.height.equalTo(14)
        }
        timeLabel.snp.makeConstraints { (make ) in
            make.bottom.equalTo(iconView)
            make.left.equalTo(nameLabel)
        }
        sourceLabel.snp.makeConstraints { (make ) in
            make.bottom.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp.right).offset(10)
        }
        contentLabel.snp.makeConstraints { (make ) in
            make.left.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        footerView.snp.makeConstraints { (make ) in
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(44)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - 懒加载
    /// 头像
    private lazy var iconView: UIImageView =
    {
        let iv = UIImageView(image: #imageLiteral(resourceName: "avatar_default_big"))
        return iv
    }()
    /// 认证图标
    private lazy var verifiedView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "avatar_enterprise_vip"))
    
    /// 昵称
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    /// 会员图标
    private lazy var vipView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    
    /// 时间
    private lazy var timeLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    /// 来源
    private lazy var sourceLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    /// 正文
    private lazy var contentLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 20
        return label
    }()
    
    /// 底部工具条
    private lazy var footerView: StatusFooterView = StatusFooterView()
}

class StatusFooterView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        // 1.添加子控件
//        addSubview(retweetBtn)
//        addSubview(unlikeBtn)
//        addSubview(commonBtn)
        addArrangedSubview(retweetBtn)
        addArrangedSubview(unlikeBtn)
        addArrangedSubview(commonBtn)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 懒加载
    // 转发
    private lazy var retweetBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "timeline_icon_retweet"), for: .normal)
        btn.setTitle("转发", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.setBackgroundImage(#imageLiteral(resourceName: "timeline_card_bottom_background"), for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }()
    
    // 赞
    private lazy var unlikeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "timeline_icon_unlike"), for: .normal)
        btn.setTitle("赞", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.setBackgroundImage(#imageLiteral(resourceName: "timeline_card_bottom_background"), for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }()
    
    // 评论
    private lazy var commonBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "timeline_icon_comment"), for: .normal)
        btn.setTitle("评论", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.setBackgroundImage(#imageLiteral(resourceName: "timeline_card_bottom_background"), for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }()
    
}
