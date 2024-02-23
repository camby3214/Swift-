//
//  ViewController.swift
//  Local_Notification
//
//  Created by 李韋辰 on 2022/3/8.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        creatNotification()
    }
    
    func creatNotification(){
        let content = UNMutableNotificationContent()
        var date = DateComponents()
        date.hour = 10
        date.minute = 9
        
        
        content.title = "推播"
        content.subtitle = "副標題"
        content.body = "推播內容"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        //到後台一段時間後
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        //
        let trigger1 = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger1)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }


}

