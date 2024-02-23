//
//  ViewController.swift
//  AnalyticsDemo
//
//  Created by 李韋辰 on 2023/8/1.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseAnalytics


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onPress(_ sender: Any) {
        Analytics.logEvent("weq", parameters: nil)
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-123",
          AnalyticsParameterItemName: "123",
          AnalyticsParameterContentType: "cont",
        ])

    }
    
}

