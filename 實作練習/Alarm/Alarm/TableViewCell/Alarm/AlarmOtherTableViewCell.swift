//
//  AlarmOtherTableViewCell.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/5.
//

import UIKit

class AlarmOtherTableViewCell: UITableViewCell {
    
    static let identifier = "alarmOtherTableViewCell"
    
    lazy var alarmTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.text = "05:50"
        label.textColor = .lightGray
        return label
    }()
    
    lazy var alarmNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "吃香蕉"
        label.textColor = .lightGray
        return label
    }()
    
    lazy var accessorySwitch: UISwitch = {
        let uiSwitch = UISwitch(frame: .zero)
        uiSwitch.backgroundColor = .lightGray
        uiSwitch.layer.cornerRadius = uiSwitch.frame.height/2.0
        return uiSwitch
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.accessoryView = accessorySwitch
        
        addViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.addSubview(alarmTimeLabel)
        self.addSubview(alarmNoteLabel)
    }
    
    func setLayout(){
        alarmTimeLabel.snp.makeConstraints{ make in
            make.top.equalTo(self)
            
        }
        alarmNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(alarmTimeLabel.snp.bottom)
            make.bottom.equalTo(self).offset(-10)
        }
    }
    
}
