//
//  ViewController.swift
//  page
//
//  Created by 李韋辰 on 2022/7/5.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    var segmentedControl = UISegmentedControl()
    var pageViewControl = UIPageViewController()
    var viewControllerArr = Array<UIViewController>()
    var selectedIndex: Int = 0
    
    
    
    
    @objc func segmentedChange(sender: UISegmentedControl) {
        // index
        print(sender.selectedSegmentIndex)
        // 文字
        print(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        pageViewControl.setViewControllers([viewControllerArr[sender.selectedSegmentIndex]], direction: .forward, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl = UISegmentedControl(items: ["過去的訂單","即將推出"])
        segmentedControl.backgroundColor = UIColor.lightGray
        segmentedControl.frame = CGRect.init(x: 0, y: 44, width: self.view.frame.width, height: 30)
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        self.view.addSubview(segmentedControl)
        
        pageViewControl = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewControl.view.frame = CGRect.init(x: 0, y: 74, width: self.view.frame.width, height: self.view.frame.height - 74)
        pageViewControl.delegate = self
        pageViewControl.dataSource = self
        pageViewControl.isEditing = true
        self.addChild(pageViewControl)
        self.view.addSubview(pageViewControl.view)
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = UIColor.init(red: 1, green: 0.2, blue: 0.4, alpha: 0.3)
        viewController1.view.tag = 0

        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = UIColor.init(red: 0.4, green: 0.3, blue: 1, alpha: 0.3)
        viewController2.view.tag = 1

        viewControllerArr.append(viewController1)
        viewControllerArr.append(viewController2)

        pageViewControl.setViewControllers([viewControllerArr[0]], direction: .forward, animated: false)
        
        pageViewControl = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)


    }
}





extension ViewController {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        selectedIndex = viewController.view.tag
        segmentedControl.selectedSegmentIndex = selectedIndex
        let pageIndex = viewController.view.tag + 1
        if pageIndex > 1 {
            return nil
        }
        return viewControllerArr[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        selectedIndex = viewController.view.tag
        segmentedControl.selectedSegmentIndex = selectedIndex
        let pageIndex = viewController.view.tag - 1
        if pageIndex < 0 {
            return nil
        }
        return viewControllerArr[pageIndex]
    }
}
