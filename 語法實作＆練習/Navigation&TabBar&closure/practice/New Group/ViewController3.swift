//
//  ViewController3.swift
//  practice
//
//  Created by 李韋辰 on 2022/3/2.
//

import UIKit

class ViewController3: UIViewController {
    
    
    lazy var changTabButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setTitle("changTab", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(tab), for: .touchUpInside)
        return button
    }()
    
    
    lazy var callBackViewButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("Call Back View", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(plus), for: .touchUpInside)
        return button
    }()
    
    lazy var callBackLabel : UILabel = {
        let label = UILabel()
        label.text = "call back test"
        label.textColor = .brown
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    

    
//MARK: - Views
    func initView(){
        setNavigation()
        addViews()
        setLayout()
        self.view.backgroundColor = .gray
    }
    
    func addViews(){
        self.view.addSubview(changTabButton)
        self.view.addSubview(callBackViewButton)
        self.view.addSubview(callBackLabel)
    }
    
    func setLayout(){
        
        //changTabButton setting
        changTabButton.snp.makeConstraints{ make in
            make.leading.top.equalTo(self.view).offset(100)
            make.trailing.equalTo(self.view).offset(-100)
            make.height.equalTo(150)
        }
        
        //view3Button setting
        callBackViewButton.snp.makeConstraints{ make in
            make.top.equalTo(changTabButton.snp.bottom).offset(100)
            make.leading.equalTo(self.view).offset(100)
            make.trailing.equalTo(self.view).offset(-100)
            make.height.equalTo(150)
        }
        
        
        callBackLabel.snp.makeConstraints{ make in
            make.top.equalTo(callBackViewButton.snp.bottom).offset(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(20)
        }
        
    }
    
    func setNavigation(){
        let plusButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(done))
        let plusButton2 = UIBarButtonItem(title: "done2", style: .plain, target: self, action: #selector(done))
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        plusButton.tintColor = .orange
        plusButton2.tintColor = .brown
        self.navigationItem.rightBarButtonItems = [plusButton,plusButton2]
        
        backButton.tintColor = .brown
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left.circle")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left.circle")
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        self.navigationItem.title = "View3"
        
        
        

        
    }
    
    
    
    
    
    
    
    
    
    
//MARK: - select function
    @objc func tab(){
        tabBarController?.selectedIndex = 1
    }
    
    
    @objc func plus(){
        let vc = ViewControllerCallBack()
        vc.testClosure = myClosure
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    
    @objc func done(){
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
//MARK: - 傳值
    func myClosure(testStr: String)->Void{
        callBackLabel.text = testStr;
    }

    
}
