//
//  ViewController.swift
//  CollectionView
//
//  Created by 李韋辰 on 2022/1/14.
//

import UIKit

class ViewController: UIViewController{
    var myColorViewController = ColorViewController()
    var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        myCollectionView = ColorViewController.initWithfram(view: self.view, self: myColorViewController, fram: CGRect(x: 0, y: 45, width: self.view.bounds.width, height: 150))
        self.view.addSubview(myCollectionView)
    }
    
}

