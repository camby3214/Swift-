//
//  addAlarmContentTableViewCell.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/3.
//

import UIKit

class AddAlarmContentTableViewCell: UITableViewCell {
    
    static let identifier = "addAlarmContentTableViewCell"
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    
    lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    lazy var detailImageView : UIImageView = {
        var imageView = UIImageView()
        imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setLayouts()
        
        self.backgroundColor = #colorLiteral(red: 0.1734634042, green: 0.1683282256, blue: 0.1771324873, alpha: 1)
        self.accessoryType = .disclosureIndicator
        self.tintColor = .white
        self.accessoryView = detailImageView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addViews(){
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
    }
    
    func setLayouts(){
        titleLabel.snp.makeConstraints{ make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
        
        contentLabel.snp.makeConstraints{make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-50)
        }
    }


}
