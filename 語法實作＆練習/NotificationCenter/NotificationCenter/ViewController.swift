//
//  ViewController.swift
//  NotificationCenter
//
//  Created by 李韋辰 on 2022/6/8.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func button(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(sendResult), name: NSNotification.Name(rawValue: "send"), object: nil)

    }
    
    @objc func sendResult(notification:Notification) {
        guard let a = notification.userInfo!["send"] else {return}
        let result = a as? String ?? String()
        label.text = result
    }
    
    

}

