//
//  ViewController.swift
//  CustomAlert
//
//  Created by 李韋辰 on 2023/6/2.
//

import UIKit

class ViewController: UIViewController, CoustomAlertDelegate {
    func confirmAction() {
        print("123")
    }
    
    
    let alert = CustomAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.delegate = self
        alert.showAlert(with: "Congratulations!!", message: "", on: self, backgroundImg: "", crossImg: "" ,logoImg: "circle")
    }
    
    
}

