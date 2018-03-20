//
//  UIColor+Category.swift
//  Swift 视图测试
//
//  Created by dev on 17/1/6.
//  Copyright © 2017年 dev. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256)) / 255.0
        let g = CGFloat(arc4random_uniform(256)) / 255.0
        let b = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }


}
