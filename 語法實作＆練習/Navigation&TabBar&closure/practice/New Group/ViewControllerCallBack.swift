//
//  ViewControllerCallBack.swift
//  practice
//
//  Created by 李韋辰 on 2022/3/2.
//

import UIKit
import RxSwift

class ViewControllerCallBack: UIViewController, UITextFieldDelegate {

    typealias sendValueClosure = (_ string:String)->Void
    
    
    var testClosure:sendValueClosure?
    
    lazy var callBackTextFiled : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .darkGray
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callBackTextFiled.delegate = self
        initView()

    }
    
    
    //MARK: - View
    
    func initView(){
        addViews()
        setLayout()
        setNavigation()
        self.view.backgroundColor = .gray
    }
    
    func addViews(){
        self.view.addSubview(callBackTextFiled)
    }
    
    func setLayout(){
        //callBackTextFiled Setting
        callBackTextFiled.snp.makeConstraints{ make in
            make.center.equalTo(self.view.center)
            make.height.equalTo(30)
            make.width.equalTo(400)
        }
        
    }
    
    func setNavigation(){
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = doneButton
    }
//MARK: - select function
    @objc func done(){
        //閉包傳值
        testClosure!(callBackTextFiled.text!)
        //回前一頁
        //self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
//MARK: - delegate & override
    //點擊return收起鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //任意點擊view，收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
