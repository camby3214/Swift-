//
//  ViewController.swift
//  ImplementingSubscriber
//
//  Created by 李韋辰 on 2022/6/2.
//

import UIKit
import Combine

class StringSubscriber: Subscriber {
    
    //接收到publisher時的動作
    func receive(subscription: Subscription) {
        print("Received Subscription")
        subscription.request(.max(3)) // backpressure
    }
    
    //處理接收到的值，Subscribers.Demand為是否要繼續接收更多的值
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received Value", input)
//        return .unlimited
        return .none

    }
    
    //接收完成
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
    
    
    typealias Input = String
    typealias Failure = Never
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publisher = ["A","B","C","D","E","F","G","H","I","J","K"].publisher
        
        let subscriber = StringSubscriber()
        
        publisher.subscribe(subscriber)
        
    }
   

}

