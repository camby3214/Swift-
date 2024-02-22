//
//  AlarmLabelViewController.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/3.
//

import UIKit

class AlarmLabelViewController: UIViewController {
    weak var updateAlarmLabelDelegate: UpdateAlarmLabelDelegate?
    
//MARK: - UI懶加載
    lazy var alarmLabelTextField : UITextField = {
        let textField = UITextField()
        textField.text = "鬧鐘"
        textField.textColor = .white
        textField.backgroundColor = #colorLiteral(red: 0.1537905931, green: 0.1488661468, blue: 0.1617964804, alpha: 1)
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()

    
//MARK: - 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let text = alarmLabelTextField.text {
            if text == "" {
                updateAlarmLabelDelegate?.updateAlarmLabel(alarmLabelText: "鬧鐘")
            }else{
                updateAlarmLabelDelegate?.updateAlarmLabel(alarmLabelText: text)
            }
        }
    }
//MARK: - View 初始化
    func initView(){
        addViews()
        setLayouts()
        self.view.backgroundColor = #colorLiteral(red: 0.1097886786, green: 0.1098149046, blue: 0.1183715835, alpha: 1)
        self.title = "標籤"
        self.navigationController?.navigationBar.tintColor = .orange
    }
    
    func addViews(){
        self.view.addSubview(alarmLabelTextField)
    }
    
    func setLayouts(){
        alarmLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(300)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(50)
        }
    }

}
//MARK: - protocal
protocol UpdateAlarmLabelDelegate: AnyObject{
    func updateAlarmLabel(alarmLabelText: String)
}
