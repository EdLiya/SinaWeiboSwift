//
//  User.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/20.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

class User: NSObject {

    /// 用户ID
   @objc var id: Int = 0
    /// 友好显示名称
   @objc var name: String?
    /// 用户头像地址（中图），50×50像素
   @objc var profile_image_url: String?
    /// 时候是认证, true是, false不是
   @objc var verified: Bool = false
    /// 用户的认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
   @objc var verified_type: Int = -1
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
    
    // 打印当前模型
    var properties = ["id", "name", "profile_image_url", "verified", "verified_type"]
    override var description: String {
        let dict = dictionaryWithValues(forKeys: properties)
        return "\(dict)"
    }
}
