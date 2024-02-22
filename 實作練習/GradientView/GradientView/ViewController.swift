//
//  ViewController.swift
//  GradientView
//
//  Created by 李韋辰 on 2022/7/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fwef: UIButton!
    @IBOutlet weak var gradientView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let barAppearance =  UINavigationBarAppearance()
        var naviAndStatusBar: CGRect = self.navigationController?.navigationBar.bounds ?? CGRect()
        
        
        naviAndStatusBar.size.height += 100
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = naviAndStatusBar
        gradientLayer.colors = [UIColor(red: 151.0/255.0, green: 64.0/255.0, blue: 201.0/255.0, alpha: 1).cgColor, UIColor(red: 122.0/255.0, green: 67.0/255.0, blue: 199.0/255.0, alpha: 1).cgColor, UIColor(red: 8.0/255.0, green: 103.0/255.0, blue: 181.0/255.0, alpha: 1).cgColor]
        gradientLayer.locations = [0, 0.42, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        barAppearance.backgroundImage = imageFromLayer(layer: gradientLayer)
        self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    func imageFromLayer(layer:CALayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
}

