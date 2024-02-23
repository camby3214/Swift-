//
//  ViewController.swift
//  CollectionView
//
//  Created by 李韋辰 on 2022/1/14.
//

import UIKit

class ColorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        self.view.addSubview(myCollectionView)
    }
    static func initWithfram (view:UIView,self:ColorViewController,fram: CGRect) -> UICollectionView{
        // 設置cell相關屬性
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // section與section之間的距離(如果只有一個section，可以想像成frame)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // cell的寬、高
        layout.itemSize = CGSize(width: 200, height: 120)
        // 滑動方向為「垂直」的話即「上下」的間距;滑動方向為「平行」則為「左右」的間距
        layout.minimumLineSpacing = CGFloat(integerLiteral: 10)
        // 滑動方向為「垂直」的話即「左右」的間距;滑動方向為「平行」則為「上下」的間距
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        // 滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let myCollectionView = UICollectionView(frame: fram, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.backgroundColor = UIColor.purple
        return myCollectionView
    }
    // MARK: - DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.orange : UIColor.brown
        return cell
    }
    
    // MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return  .zero
//    }
    
    
}

