//
//  RepeatAlarmViewController.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/3.
//

import UIKit

class RepeatAlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var isSelected: [Int] = []
    let titleDatas : [String] = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
    
//MARK: - UI懶加載
    lazy var repeatTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(RepeatAlarmTableViewCell.self, forCellReuseIdentifier: RepeatAlarmTableViewCell.identifier)
        tableView.bounces = false
        return tableView
    }()

//MARK: - 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
//MARK: - View 初始化
    func initView(){
        self.title = "重複"
        self.navigationController?.navigationBar.tintColor = .orange
        self.view.backgroundColor = #colorLiteral(red: 0.1097886786, green: 0.1098149046, blue: 0.1183715835, alpha: 1)
        self.repeatTableView.delegate = self
        self.repeatTableView.dataSource = self
        addViews()
        setLayouts()
    }
    
    func addViews(){
        self.view.addSubview(repeatTableView)
    }
    
    func setLayouts(){
        repeatTableView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(350)
        }
    }

//MARK: - tableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepeatAlarmTableViewCell.identifier, for: indexPath) as? RepeatAlarmTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = titleDatas[indexPath.row]
        
        cell.selectionStyle = .none
        if self.isSelected.contains(indexPath.row){
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isSelected.contains(indexPath.row){
            //篩選
            self.isSelected = self.isSelected.filter{$0 != indexPath.row}
        }else{
            self.isSelected.append(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}
