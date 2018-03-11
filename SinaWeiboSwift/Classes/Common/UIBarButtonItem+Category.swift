//
//  UIBarButtonItem+Category.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/11.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func crateBarButtonItem(imageName:String, target: AnyObject?, action: Selector) -> UIBarButtonItem
    {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
        
        
    }
}
