//
//  MoviesTableViewController.swift
//  MoviesAppUIKit
//
//  Created by Mohammad Azam on 10/12/23.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class MoviesViewController: UIViewController {
    
    /// 電影列表 ViewModel 實例
    private let viewModel: MovieListViewModel
    
    /// 取消訂閱集合
    private var cancellables: Set<AnyCancellable> = []
    
    /// 初始化
    ///
    /// - Parameter viewModel: 電影列表 ViewModel 實例
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    /// 程式碼生成器初始化方法
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 搜尋欄位
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "搜尋"
        searchBar.delegate = self
        return searchBar
    }()
    
    /// 電影列表表格
    lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    /// viewDidLoad 方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 設定背景色
        view.backgroundColor = .white
        
        /// 註冊表格使用的 UITableViewCell 類別
        moviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
        setupUI()
       
        /// 訂閱 ViewModel 的 `loadingCompleted` 發佈者，在資料載入完成時更新表格
        viewModel.$loadingCompleted
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] completed in
                if completed {
                    self?.moviesTableView.reloadData()
                }
            })
            .store(in: &cancellables)
    }
    
    /// 設定使用者介面的外觀和約束條件
    private func setupUI() {
        /// 建立 UIStackView 垂直容器，用於排列搜尋欄位和表格
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        /// 設定 StackView 的約束條件
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        /// 將搜尋欄位和表格加入 StackView
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(moviesTableView)
        
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath)
        
        let movie = viewModel.movies[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = movie.title
        cell.contentConfiguration = content
        
        return cell
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    /// 監控搜尋欄位的文字變化
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.setSearchText(searchText)
    }
}

/// 預覽畫面
struct MoviesViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = MoviesViewController
    
    func updateUIViewController(_ uiViewController: MoviesViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> MoviesViewController {
        MoviesViewController(viewModel: MovieListViewModel(httpClient: HTTPClient()))
    }
}

#Preview {
    MoviesViewControllerRepresentable()
}


