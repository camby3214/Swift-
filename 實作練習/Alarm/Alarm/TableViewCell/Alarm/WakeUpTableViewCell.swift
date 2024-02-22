//
//  WakeUpTableViewCell.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/4.
//

import UIKit

class WakeUpTableViewCell: UITableViewCell {
    static let identifier = "wakeUpTableViewCell"
    
    lazy var wakeUpLabel: UILabel = {
            let label = UILabel()
            label.text = "沒有鬧鐘"
            label.textColor = .gray
            return label
        }()
        
    lazy var settingButton: UIButton = {
            let button = UIButton()
            button.setTitle("設定", for: .normal)
            button.setTitleColor(.orange, for: .normal)
            return button
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        addViews()
        setLayouts()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.addSubview(wakeUpLabel)
        self.addSubview(settingButton)
    }
    
    func setLayouts(){
        wakeUpLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(10)
        }
                
        settingButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-10)
        }
    }
}
