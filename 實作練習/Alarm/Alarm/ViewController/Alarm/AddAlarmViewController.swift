//
//  AddAlarmViewController.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/1.
//

import UIKit

class AddAlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateAlarmLabelDelegate {
    
    weak var updateAlarmListDelegate: UpdateAlarmListDelegate?
    
    //MARK: - UI懶加載
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "時間"
        return label
    }()
    
    lazy var addAlarmTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(AddAlarmContentTableViewCell.self, forCellReuseIdentifier: AddAlarmContentTableViewCell.identifier)
        tableView.register(AddAlarmButtonTableViewCell.self, forCellReuseIdentifier: AddAlarmButtonTableViewCell.identifier)
        tableView.bounces = false
        return tableView
    }()
    
    var addAlarmTitles = ["重複","標籤","提示聲","重複提醒"]
    var addAlarmDetails = ["永不","鬧鐘","雷達",""]{
        didSet{
            addAlarmTableView.reloadData()
        }
    }
    

    //MARK: - 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        self.addAlarmTableView.delegate = self
        self.addAlarmTableView.dataSource = self
        
    }
    
    //MARK: - View 初始化
    func initView(){
        addViews()
        setLayouts()
        setNavigation()
        self.view.backgroundColor = .black
    }
    
    
    
    func addViews(){
      //  self.view.addSubview(datePicker)
        self.view.addSubview(timeLabel)
        self.view.addSubview(addAlarmTableView)
    }
    func setLayouts(){
//        datePicker.snp.makeConstraints{ make in
//            make.trailing.equalTo(self.view).offset(-17)
//            make.top.equalTo(self.view).offset(120)
//        }
        
//        timeLabel.snp.makeConstraints{ make in
//            make.top.bottom.equalTo(datePicker)
//            make.leading.equalTo(self.view).offset(17)
//        }
        
        addAlarmTableView.snp.makeConstraints{make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(timeLabel.snp.bottom).offset(50)
            make.height.equalTo(200)
        }
    }
    
//MARK: - Navigation設定
    func setNavigation(){
        
        
        self.title = "加入鬧鐘"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.barTintColor = .orange
        
        let cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(backToMain))
        cancelButton.tintColor = .orange
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAlarm))
        saveButton.tintColor = .orange
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = saveButton
        
    }
    
//MARK: - select function
    @objc func backToMain(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveAlarm(){
//        let saveAlarmData = AddAlarmInfo(time: self.datePicker.date, annotation: self.addAlarmDetails[1])
//        updateAlarmListDelegate?.updateAlarmList(alarmData: saveAlarmData)
//        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: - tableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addAlarmTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmButtonTableViewCell.identifier, for: indexPath) as? AddAlarmButtonTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = addAlarmTitles[indexPath.row]
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmContentTableViewCell.identifier, for: indexPath)
                                as? AddAlarmContentTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = addAlarmTitles[indexPath.row]
            cell.contentLabel.text = addAlarmDetails[indexPath.row]
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = RepeatAlarmViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 1:
            let vc = AlarmLabelViewController()
            vc.updateAlarmLabelDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
//MARK: - call back
    func updateAlarmLabel(alarmLabelText: String) {
        self.addAlarmDetails[1] = alarmLabelText
    }
}
//MARK: - protocal
protocol UpdateAlarmListDelegate: AnyObject{
    func updateAlarmList(alarmData: AddAlarmInfo)
}
