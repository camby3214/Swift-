//
//  ViewController.swift
//  Eraser
//
//  Created by 李韋辰 on 2022/6/2.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
class DataPublisher {
    private var dataPublisher: AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
    
    var cancellable: AnyCancellable?
    
    init(){
        let url = URL(string: "http://v.juhe.cn/toutiao/index?type=top")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        
        
        self.dataPublisher = session.dataTaskPublisher(for: request).eraseToAnyPublisher()
        
        cancellable = dataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in
                
            }){
                (data: Data, response: URLResponse) in
                }
            
    }
}
