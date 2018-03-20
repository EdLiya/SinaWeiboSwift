//
//  Status.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/20.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

class Status: NSObject {
    /// 微博创建时间
   @objc var created_at: String = ""
    /// 微博ID
   @objc var id: Int = 0
    /// 微博信息内容
   @objc var text: String = ""
    /// 微博来源
   @objc var source: String = ""
    /// 配图数组
   @objc var pic_urls: [[String: AnyObject]]?

    /// 用户信息
    var user: User?
    
    class func loadStatuses(finished:@escaping (_ models:[Status]?, _ error:Error?) -> ()) {
        let path = "2/statuses/home_timeline.json"
        let params = ["access_token": UserAccount.loadAccount()!.access_token!]
        
        NetWorkTools.shareNetWorkTools().get(path, parameters: params, progress: nil, success: { (_, JSON) in
//            print(JSON)
            if let json  = JSON {
                
                let models = dict2Model((json as! [String: AnyObject])["statuses"] as! [[String : AnyObject]])
                
                // 2.通过闭包将数据传递给调用者
                finished(models, nil)
            }
            
        }) { (_, error) in
            print(error)
            
            finished(nil,error)
        }
    }
    
    /// 将字典数组转换为模型数组
    class func dict2Model(_ list:[[String: AnyObject]]) -> [Status] {
        var models = [Status]()
        for dict  in list {
            models.append(Status(dict: dict))
        }
        return models
    }
    
    // 字典转模型
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeys(dict)
    }
    
    /// setValuesForKeys内部会调用以下方法
    override func setValue(_ value: Any?, forKey key: String) {
        
//        print("key = \(key), value = \(value)")
        // 1.判断当前是否正在给微博字典中的user字典赋值
        if key == "user" {
            
            user = User(dict: value as! [String : AnyObject])
            // 拦截这个key的处理, 并返回
            return
        }
        
        // 3,调用父类方法, 按照系统默认处理
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
    
    /// 用于打印当前模型
    var properties = ["created_at", "id", "text", "source", "pic_urls"]
    override var description: String {
        let dict  = dictionaryWithValues(forKeys: properties)
        return "\(dict)"
    }
    
}
