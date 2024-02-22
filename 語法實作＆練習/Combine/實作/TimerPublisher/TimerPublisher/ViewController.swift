//
//  ViewController.swift
//  TimerPublisher
//
//  Created by 李韋辰 on 2022/6/2.
//

import UIKit
import Combine


class ViewController: UIViewController {

    private var store = [AnyCancellable]()
    
    let colors: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemCyan
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPublisher()
    }
    
    func setUpPublisher() {
        Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.view.backgroundColor = self?.colors.randomElement()
            }.store(in: &store)
    }


}

