//
//  OAuthViewController.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/13.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit
import SVProgressHUD
import YYKit
import WebKit


class OAuthViewController: UIViewController {

    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = APP_title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(close))
        
        // 获取未授权的RequestToken
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(App_Key)&redirect_uri=\(Redirect_uri)"
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
//            mWebView.load(request)
    }

    @objc func close () {
        dismiss(animated: true, completion: nil)
    }
    
    
    // 获取AccessToken
    private func loadAccessToken(_ code:String) {
        
        // 1. 定义路径
        let path = "oauth2/access_token"
        
        // 2. 封装参数
        let params = ["client_id":App_Key,
                      "client_secret":App_Secret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":Redirect_uri]
        
        // 3. 发送POST请求
        NetWorkTools.shareNetWorkTools().post(path, parameters: params, progress: nil, success: {
            (_, JSON) in
            /*
             "access_token" = "2.00wZ4rYDmRCcgEab34205a47cYIPBC";
             "expires_in" = 157679999;
             "remind_in" = 157679999;
             uid = 3263515944;
             */
            SVProgressHUD.dismiss()
            print(JSON!)
            
            let account = UserAccount(dict: JSON as! [String : AnyObject])
            
            account.loadUserInfo(finished: { (account, error ) in
                
                if account != nil {
                    
                    // 加载完毕后, 归档账户数据
                    account?.saveAccount()
                    
                    // 去欢迎界面
                    NotificationCenter.default.post(name: XMGSwitchRootViewController, object: false)
                } else {
                    SVProgressHUD.setStatus("网络不给力...")
                }
                
            })
            
        }, failure: {
            (_, error ) in
            SVProgressHUD.dismiss()
            print(error)
        })
    }
    
    
    // MARK: - 懒加载
    private lazy var webView : UIWebView = {
        let webView = UIWebView()
        webView.delegate = self
        return webView
    }()

    // MARK: - 懒加载
//    private lazy var mWebView : WKWebView = {
//        let webView = WKWebView()
//
//        webView.navigationDelegate = self
//
//        return webView
//    }()
}


extension OAuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
        
        print(webView.url!.absoluteString)
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        print(webView.url!.absoluteString)
        print("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
    }
}

extension OAuthViewController : UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // Optional("http://user.qzone.qq.com/763041363/main?code=0e1ab3ab7fadb07066b00287a70a8ae4")
        
        let urlStr = request.url?.absoluteString
        // 如果不是授权回调页, 就继续加载
        if !(urlStr!.hasPrefix(Redirect_uri)) {
            return true
        }
        
        // 来到授权回调也有两种情况
        
        // 判断是否授权成功
        if let codeStr = request.url?.query {
            // 授权成功
            print("授权成功")
             // 取出授权成功的RequestToken
            // code=aa7a2ab9874befe342a332c96ea70e27
            /// TODO  没有code= 的时候会崩
            let code  = codeStr[codeStr.index(after: codeStr.index(of: "=")!)...]
            print(code)
            
            // 利用已经授权成功的RequestToken换取access token
            loadAccessToken(String(code))
        } else {
            // 取消了授权
            print("授权失败")
            // 关闭界面
            close()
        }
        

        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show(withStatus: "正在加载...")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
