//
//  ViewController.swift
//  Publisher
//
//  Created by 李韋辰 on 2022/6/2.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification = Notification.Name("MyNotification")
        
        
//        //一般寫法
//        let observer = NotificationCenter.default.addObserver(forName: notification, object: nil, queue: nil) { notification in
//            print("Notification recevied!")
//        }
//
//        NotificationCenter.default.post(name: notification, object: nil)
//
//        NotificationCenter.default.removeObserver(observer)
        
        
        //Combine
        //發布者
        let publisher = NotificationCenter.default.publisher(for: notification, object: nil)
        
        //訂閱者
        let subscription = publisher.sink { _ in
                  print("Notification recevied")
        }
        
        //執行時訂閱者會被觸發
        NotificationCenter.default.post(name: notification, object: nil)
        
        //cancel後就不會再觸發
        subscription.cancel()
        NotificationCenter.default.post(name: notification, object: nil)
      
       
    }


}

