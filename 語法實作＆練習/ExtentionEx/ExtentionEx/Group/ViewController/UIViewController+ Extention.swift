//
//  UIViewController+ Extention.swift
//  ExtentionEx
//
//  Created by 李韋辰 on 2022/12/12.
//

import UIKit


fileprivate var aView: UIView?

extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView?.center ?? CGPoint(x: 10.0, y: 10.0)
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView ?? UIView())
        
        // Test
//        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { [self](t) in
//            removeSpinner()
//        })
        
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    
}
