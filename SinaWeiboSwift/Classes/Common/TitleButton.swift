//
//  TitleButton.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/12.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor.darkGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // layoutSubviews 会调用两次, 用偏移量不靠谱
        /*
         // 设置偏移位
         titleLabel?.frame.offsetInPlace(dx: -imageView!.bounds.width * CGFloat(0.5), dy: 0)
         imageView?.frame.offsetInPlace(dx: titleLabel!.bounds.width * CGFloat(0.5), dy: 0)
         */
        
        // 写死坐标
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)!
    }
    
    // 试试这个
//    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
//        <#code#>
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
