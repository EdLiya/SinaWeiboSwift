//
//  HomeTableViewController.swift
//  SinaWeiboSwift
//
//  Created by 张杨燕 on 2018/3/10.
//  Copyright © 2018年 zyy. All rights reserved.
//

import UIKit

let XMGHomeReuseIdentifier = "XMGHomeReuseIdentifier"
class HomeTableViewController: BaseTableViewController {

    /// 保存微博数组
    var statuses: [Status]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !userLogin {
            visitorView?.setupVisitorInfo(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 初始化导航条按钮
        setupNavgationItem()
        
        
        // 注册一个cell
        tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: XMGHomeReuseIdentifier)
        
        tableView.rowHeight = 200
//        tableView.estimatedRowHeight = 200
//        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        loadData()
    }

    private func loadData() {
        Status.loadStatuses { (statusArray, error) in
            guard error == nil else { return }
            
            self.statuses = statusArray
//            print(statusArray)
        }
    }
    
    // MARK: - 内部控制方法
    /**
     初始化导航条按钮
     */
    private func setupNavgationItem() {
        // 1.添加左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.crateBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(letBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.crateBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightBtnClick))
        
        let titleBtn = TitleButton()
        titleBtn.setTitle("极客江南 ", for: UIControlState.normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
    
   @objc func titleBtnClick(_ btn :UIButton) {
    
        btn.isSelected = !btn.isSelected
    }

    @objc func letBtnClick() {
        print(#function)
    }
    
    @objc func rightBtnClick() {
        print(#function)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XMGHomeReuseIdentifier, for: indexPath) as! StatusTableViewCell

        let status = statuses![indexPath.row]
        
        cell.status = status
//        cell.textLabel?.text = status.text

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
