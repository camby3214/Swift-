//
//  ViewController1.swift
//  practice
//
//  Created by 李韋辰 on 2022/3/1.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
class ViewController1: UIViewController {
    
    let disposeBag = DisposeBag()
    lazy var jumpView3Button : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0, green: 179, blue: 102, alpha: 0.5)
        button.layer.cornerRadius = 20
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("View3", for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.rx.tap.subscribe(onNext: {element in
            print(element)
            let vc = ViewController3()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    
    
    func initView(){
        self.view.backgroundColor = .white
        addViews()
        setLayout()
        
    }
    
    
    func addViews(){
        self.view.addSubview(jumpView3Button)
    }
    
    func setLayout(){
        
        //buttonView3
        jumpView3Button.snp.makeConstraints{ make in
            make.center.equalTo(self.view.center)
            make.height.width.equalTo(100)
        }
        
        
    }
    
    func view3(){
        let vc = ViewController3()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
