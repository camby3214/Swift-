//
//  TaskListViewController.swift
//  GoodList
//
//  Created by 李韋辰 on 2022/3/17.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa


class TaskListViewController: UIViewController{
    
   let disposeBag = DisposeBag()
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //轉跳頁面時訂閱
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addTVC = navC.viewControllers.first as? AddTaskViewController else{
                  fatalError("Controller not found")
              }
        
        addTVC.taskSubjectObservable
            .subscribe(onNext:{ task in
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                
                self.filterTasks(by: priority)
                
            }).disposed(by: disposeBag)
    }
    
    
    @IBAction func priorityValueChanged(_ sender: UISegmentedControl) {
        let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
        
    }
    
    
    
    //資料過濾
    private func filterTasks(by priority: Priority?){
        if priority == nil{
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        }else{
            self.tasks.map{ tasks in
                return tasks.filter{ $0.priority == priority! }
            }.subscribe(onNext: {[weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
            }).disposed(by: disposeBag)
        }
    }
    
    //列表畫面更新
    private func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}




extension TaskListViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
        
    }
    
}
