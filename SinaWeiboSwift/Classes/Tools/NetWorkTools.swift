//
//  NetWorkTools.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/13.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit
import AFNetworking

class NetWorkTools: AFHTTPSessionManager {

    static let tools : NetWorkTools = {
        let url = URL(string: "https://api.weibo.com/") // 一定要以 / 结尾
        let t = NetWorkTools(baseURL: url)
        /*
         设置接收类型
         application/json
         text/json
         text/javascript
         text/plain
         */
        t.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript", "text/plain"]
        return t
    }()
    
    class func shareNetWorkTools() -> NetWorkTools {
        return tools
    }
    
}
