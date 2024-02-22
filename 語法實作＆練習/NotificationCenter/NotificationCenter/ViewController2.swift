//
//  ViewController2.swift
//  NotificationCenter
//
//  Created by 李韋辰 on 2022/6/8.
//

import UIKit

class ViewController2: UIViewController {

    
    @IBOutlet weak var textfeild: UITextField!
    @IBAction func button(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "send"), object: self, userInfo: ["send": textfeild.text ?? ""])
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
