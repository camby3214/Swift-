//
//  RepeatAlarmTableViewCell.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/3.
//

import UIKit

class RepeatAlarmTableViewCell: UITableViewCell {
    
    static let identifier = "repeatAlarmTableViewCell"
    
    
    lazy var titleLabel :UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setLayout()
        
        self.backgroundColor = #colorLiteral(red: 0.1333159506, green: 0.1333458424, blue: 0.1419014633, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.addSubview(titleLabel)
    }
    func setLayout(){
        titleLabel.snp.makeConstraints{ make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
    }
    
}
