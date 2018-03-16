//
//  NewFeatureViewController.swift
//  SinaWeiboSwift
//
//  Created by Zhengsw on 2018/3/17.
//  Copyright © 2018年 zyy. All rights reserved.
// 新特性界面用UICollectionViewController 感觉比UIPageViewController更好用

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {

    /// 布局属性
    private let nLayout = NewfeatureLayout()
    /// 页面个数
    private let pageCount = 4
    
    private let reuseIdentifier = "NewfeatureCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(NewfeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

   //  因为init 不是系统指定的初始化方法所以不用override
    init() {
        super.init(collectionViewLayout: nLayout)
    }
    
//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(collectionViewLayout: nLayout)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pageCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewfeatureCell
    
        cell.imageIndex = indexPath.item
        // Configure the cell
    
        if indexPath.item != pageCount - 1 {
            // 不是最后一张,就隐藏按钮
            cell.startButton.isHidden = true
        } else {
            cell.startButton.isHidden = false
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
     // 完全显示一个cell之后调用
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // 1.拿到当前显示的cell对应的索引
        let path = collectionView.indexPathsForVisibleItems.last
        // 2.拿到当前索引对应的cell
        let cell = collectionView.cellForItem(at: path!) as! NewfeatureCell
        
        if path?.item == (pageCount - 1) {
            // 3.让cell执行按钮动画
            cell.startBtnAnimation()
        }
        
    }
    
}

private class NewfeatureLayout : UICollectionViewFlowLayout {
    
    /// Tells the layout object to update the current layout.
    override func prepare() {
        super.prepare()
        
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
    }
}

private class NewfeatureCell: UICollectionViewCell {
    var imageIndex: Int? {
        willSet {
            iconView.image = UIImage(named: "new_feature_\(newValue! + 1)")
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1.添加子控件到contentView上
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        // 2.布局子控件的位置
        
        iconView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        startButton.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(200)
        }
    }
    
    func startBtnAnimation() {
        startButton.isHidden = false
        startButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        startButton.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.startButton.transform = CGAffineTransform.identity
        }) { (_) in
            self.startButton.isUserInteractionEnabled = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func startBtnClick()  {
        print("startBtnClick")
    }
    
    lazy var iconView = UIImageView()
    
    lazy var startButton : UIButton = {
       
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "new_feature_button"), for: .normal)
        btn.setBackgroundImage(#imageLiteral(resourceName: "new_feature_button_highlighted"), for: .highlighted)
        
        btn.isHidden = true
        btn.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)
        return btn
    }()
}
