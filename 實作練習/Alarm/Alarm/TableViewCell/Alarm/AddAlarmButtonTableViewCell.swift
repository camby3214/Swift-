//
//  addAlarmButtonTableViewCell.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/3.
//

import UIKit

class AddAlarmButtonTableViewCell: UITableViewCell {
    
    static let identifier = "addAlarmButtonTableViewCell"
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.1734634042, green: 0.1683282256, blue: 0.1771324873, alpha: 1)

        self.accessoryView = UISwitch(frame: .zero)
        addViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.addSubview(titleLabel)
    }
    
    func setLayouts(){
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
        
    }
    
}
