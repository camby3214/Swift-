//
//  MainTabbarViewController.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/2/26.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //TabBar item 初始化
        let worldClockVC = WorldClockViewController()
        let alarmVC = AlarmViewController()
        let stopWatchVC = StopWatchViewController()
        let timerVC = TimerViewViewController()
        
        //TabBar item 設定值
        worldClockVC.tabBarItem.image = UIImage(systemName: "network")
        worldClockVC.title = "世界時鐘"
        
        alarmVC.tabBarItem.image = UIImage(systemName: "alarm.fill")
        alarmVC.title = "鬧鐘"
        
        stopWatchVC.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        stopWatchVC.title = "碼表"
        
        timerVC.tabBarItem.image = UIImage(systemName: "timer")
        timerVC.title = "計時器"
        
        //Navigation Setting
        let navAlarm = UINavigationController(rootViewController: alarmVC)
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = .black
        navAppearance.titleTextAttributes = [.foregroundColor:UIColor.white]
        navAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                  .font: UIFont.boldSystemFont(ofSize: 40)]
        navAlarm.navigationBar.scrollEdgeAppearance = navAppearance
        navAlarm.navigationBar.standardAppearance = navAppearance
        navAlarm.navigationBar.compactAppearance = navAppearance
        navAlarm.setNavigationBarHidden(false, animated: false)
        navAlarm.navigationBar.prefersLargeTitles = true
        
        
        
        //tabBarSetting
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.9)
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        self.tabBar.tintColor = .orange
        self.tabBar.barTintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.9)
        
        setViewControllers([worldClockVC,navAlarm,stopWatchVC,timerVC] ,animated: false)
    }
    


}
