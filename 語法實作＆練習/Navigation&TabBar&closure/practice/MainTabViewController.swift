//
//  MaintabViewController.swift
//  practice
//
//  Created by 李韋辰 on 2022/3/1.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    var view1: ViewController1 = {
        ViewController1()
    
    }()
    let view2 = ViewController2()
    var nav1 = UINavigationController()
    var nav2 = UINavigationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
    }
    
    func initView(){
        setTabBarItem()
        setNav()
        setViewControllers([nav1,nav2], animated: false)
    }
    
    func setTabBarItem(){
        view1.tabBarItem.image = UIImage(systemName: "alarm.fill")
        view1.title = "鬧鐘"
        
        view2.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        view2.title = "碼表"
        
        self.tabBar.backgroundColor = .gray
        self.tabBar.tintColor = .orange
    }
    
    func setNav(){
        
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.blue
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.backgroundColor = .red
        nav1 = UINavigationController(rootViewController: view1)
        nav2 = UINavigationController(rootViewController: view2)
        
        
    }
    
    
}
