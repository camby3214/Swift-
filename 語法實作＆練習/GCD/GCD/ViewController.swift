//
//  ViewController.swift
//  GCD
//
//  Created by 李韋辰 on 2021/12/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //使用 Serial 的佇列，並使用 Sync 的方式建立 Task，故會等到 Serial 的佇列執行完畢後才會接著執行主執行緒的迴圈。
//        let serialQueue: DispatchQueue = DispatchQueue(label: "serialQueue")
//
//        serialQueue.sync {
//            for i in 1 ... 10{
//                print("i: \(i)")
//            }
//        }
//
//        for j in 100 ... 109 {
//                    print("j: \(j)")
//                }
        
        //因使用 Concurrent 的佇列，故會同時開始執行，但下一個迴圈不會等到上一個迴圈執行完才開始執行，而且每個 async block 都會開啟不同的執行緒。
//        let concurrentQueue: DispatchQueue = DispatchQueue(label: "CorrentQueue", attributes: .concurrent)
//
//        concurrentQueue.async {
//            for i in 1 ... 1000 {
//                print("i: \(i)")
//            }
//        }
//
//        concurrentQueue.async {
//            for j in 1 ... 1000 {
//                print("j: \(j)")
//            }
//        }
//
//        concurrentQueue.async {
//            for k in 1 ... 1000 {
//                print("k: \(k)")
//            }
//        }
        
        
        let group: DispatchGroup = DispatchGroup()
                
                let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent)
                queue1.async(group: group) {
                    // 事件A
                    for i in 1 ... 100 {
                        print("i: \(i)")
                    }
                }
                let queue2 = DispatchQueue(label: "queue2", attributes: .concurrent)
                queue2.async(group: group) {
                    // 事件B
                    for j in 101 ... 200 {
                        print("j: \(j)")
                    }
                }
        
                group.notify(queue: DispatchQueue.main) {
                    // 已處理完事件A和事件B
                    print("處理完成事件A和事件B...")
                }
        
    }
    


}

