//
//  AlarmViewViewController.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/2/26.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    var alarmDatas: [AddAlarmInfo] = []{
        didSet{
            alarmTableView.reloadData()
        }
    }
//MARK: - UI懶加載
   lazy var alarmTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(WakeUpTableViewCell.self, forCellReuseIdentifier: WakeUpTableViewCell.identifier)
        tableView.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: AlarmOtherTableViewCell.identifier)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
//MARK: - 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        self.alarmTableView.delegate = self
        self.alarmTableView.dataSource = self
        
    }
    
//MARK: - View 初始化
    func initView(){
        addViews()
        setLayouts()
        setNavigation()
    }
    
    func addViews(){
        self.view.addSubview(alarmTableView)
    }
    
    func setLayouts(){
        alarmTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self.view)
        }
        
    }
//MARK: - Navigation設定
    func setNavigation(){
        let editButton = UIBarButtonItem(title: "編輯", style: .plain, target: self, action: #selector(editAlarm))
        editButton.tintColor = .orange
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAlarm))
        addButton.tintColor = .orange
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
    }
    
    
//MARK: - select function
    @objc func editAlarm(){
        
    }
    @objc func addAlarm(){
        let vc = AddAlarmViewController()
        let nv = UINavigationController(rootViewController: vc)
        let navAppearance = UINavigationBarAppearance()
        navAppearance.titleTextAttributes = [.foregroundColor:UIColor.white]
        nv.navigationBar.scrollEdgeAppearance = navAppearance
        nv.navigationBar.standardAppearance = navAppearance
        nv.navigationBar.compactAppearance = navAppearance
        nv.setNavigationBarHidden(false, animated: false)
        
        vc.updateAlarmListDelegate = self
        present(nv, animated: true, completion: nil)
    }
    

//MARK: - tableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section {
            case 0:
                return 1
            case 1:
                return alarmDatas.count
            default:
                return 0
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WakeUpTableViewCell.identifier, for: indexPath) as? WakeUpTableViewCell else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmOtherTableViewCell.identifier, for: indexPath) as? AlarmOtherTableViewCell else { return UITableViewCell() }
            
            cell.alarmTimeLabel.text = dateToString(date: alarmDatas[indexPath.row].time, format: "HH:mm")
            cell.alarmNoteLabel.text = alarmDatas[indexPath.row].annotation
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
                // 第一個 Section 內顯示的文字
                case 0:
                    return "睡眠｜起床鬧鐘"
                // 第二個 Section 內顯示的文字
                case 1:
                    return "其他"
                // 其他 Section (基本上用不到)
                default:
                    return ""
                }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view: AlarmHeaderView = {
                let view = AlarmHeaderView()
                view.headerViewLabel.text = "睡眠｜起床鬧鐘"
                return view
            }()
            return view
        case 1:
            let view: AlarmHeaderView = {
                let view = AlarmHeaderView()
                view.headerViewLabel.text = "其他"
                return view
            }()
            return view
        default:
            break
        }
        
        return UIView()
    }
    
    
//MARK: - Other function
    func dateToString(date: Date,format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    
}

//MARK: - protolcal實作
extension AlarmViewController: UpdateAlarmListDelegate{
    func updateAlarmList(alarmData: AddAlarmInfo) {
//        print(alarmData)
        self.alarmDatas.append(alarmData)
    }
}

//MARK: - AlarmHeaderView
class AlarmHeaderView: UIView {
    
    let headerViewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setLayouts()
        self.backgroundColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.addSubview(headerViewLabel)
    }
    
    func setLayouts(){
        headerViewLabel.snp.makeConstraints{ make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
    }
    
}
