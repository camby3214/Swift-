//
//  ViewController.swift
//  Subject
//
//  Created by 李韋辰 on 2022/6/2.
//

import UIKit
import Combine

enum MyError: Error {
    case subscriberError
}

class StringSubscriber: Subscriber {
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
        return .max(1)
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Completion")
    }
    
    
    typealias Input = String
    typealias Failure = MyError
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Subjects
           // - Publisher
           // - Subscribers
        
        let subscriber = StringSubscriber()
        
        let subject = PassthroughSubject<String, MyError>()
        
        // - Subscribers
        subject.subscribe(subscriber)
        
        
        let subscription = subject.sink(receiveCompletion: { (completion) in
            
            print("Received Completion from sink")
            
        }) { value in
            
            print("Received Value from sink")
        }
        
        // - Publisher
        subject.send("A")
        subject.send("B")
        
        // cancel 不會取消 StringSubscriber 裡的動作，所以還是會印出 C D
        subscription.cancel()
        
        subject.send("C")
        subject.send("D")
        
    }


}

