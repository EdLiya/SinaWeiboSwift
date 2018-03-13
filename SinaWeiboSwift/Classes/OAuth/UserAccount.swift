//
//  UserAccount.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/13.
//  Copyright © 2018年 zyy. All rights reserved.
//  保存用户账号信息

import UIKit

class UserAccount: NSObject, NSCoding {

    /// 用于调用access_token，接口获取授权后的access token。
    var access_token: String?
    /// access_token的生命周期，单位是秒数。
    var expires_in: NSNumber?
    
    /// 当前授权用户的UID。
    var uid:String?
    
    /// 保存用户过期时间
    var expires_Date: Date?
    
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    /// 用户昵称
    var screen_name: String?
    
    // --------------------------------
    /// 保存路径
    static let accountPath = "account.plist".cacheDir()
    ///  账户信息
    static var account : UserAccount?
    // MARK: - method
    
    
    init(dict:[String : AnyObject]) {
        super.init()
        // 注意: 如果直接赋值, 不会调用didSet 所以用KVC (在初始化方法里不会触发didSet, )
        setValuesForKeys(dict)
    }
    
    ///  保存账户信息
    func saveAccount(){
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
    }
    
    class func loadAccount() -> UserAccount? {
        
        if account != nil {
            return account
        }
        
        account  = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
        
        // 是否过期
        if account?.expires_Date?.compare(Date()) == ComparisonResult.orderedAscending { // 过期
            return nil
        }
        return account
    }
    
    class func isUserLogin() -> Bool {
        return UserAccount.loadAccount() != nil
    }
    
    /// 根据获得的accessToken去加载用户数据
    func loadUserInfo(finished: @escaping (_ account: UserAccount?, _ error:Error?) -> ()){
        assert(access_token != nil, "没有授权")
        
        let path = "2/users/show.json"
        let params = ["access_token":access_token!, "uid":uid!]
        
        NetWorkTools.shareNetWorkTools().get(path, parameters: params, progress: nil, success: {
            (_,JSON) in
            
            // 1.判断字典是否有值
            if JSON != nil {
                let dict = JSON as! [String : AnyObject]
                self.screen_name = dict["screen_name"] as? String
                self.avatar_large = dict["avatar_large"] as? String
                
                finished(self, nil)
                
            } else {
                
                finished(nil , nil)
                
            }
            
        }, failure: {
            (_, error) in
            
            finished(nil , nil)
            print(error)
        })
    }
    
    
    // MARK: - NSCoding
    
     // 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_Date, forKey: "expires_Date")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
    
    // 解档
    required init?(coder aDecoder: NSCoder) {
        super.init()
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String?
        expires_in = aDecoder.decodeObject(forKey: "expires_in") as! NSNumber?
        uid = aDecoder.decodeObject(forKey: "uid") as! String?
        expires_Date = aDecoder.decodeObject(forKey:"expires_Date") as? Date
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
}


