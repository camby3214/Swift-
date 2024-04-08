//
//  MovieListViewModel.swift
//  MoviesAppUIKit
//
//  Created by 李韋辰 on 2024/4/1.
//

import Foundation
import Combine

/// 電影列表 ViewModel
class MovieListViewModel {

  /// 電影資料陣列Publisher
  @Published private(set) var movies: [Movie] = []

  /// 資料載入完成狀態Publisher
  @Published var loadingCompleted: Bool = false

  /// 管理訂閱
  private var cancellables: Set<AnyCancellable> = []

  /// HTTP 網路請求
  private let httpClient: HTTPClient

  /// 搜尋主題，使用 CurrentValueSubject 保存當前搜尋字串
  private var searchSubject = CurrentValueSubject<String, Never>("")

  /// 初始化
  /// - Parameter httpClient: HTTP 客戶端實例
  init(httpClient: HTTPClient) {
    self.httpClient = httpClient
    setupSearchPublisher()
  }

  /// 設定搜尋Subject
  private func setupSearchPublisher() {
    searchSubject
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // 延遲 0.5 秒發送搜尋，避免過度頻繁的請求
      .sink(receiveValue: { [weak self] searchText in
        self?.loadMovies(search: searchText) // 接收搜尋字串，發起電影資料載入
      }).store(in: &cancellables) // 保存訂閱
  }

  /// 設定搜尋字串
  ///
  /// - Parameter searchText: 搜尋字串
  func setSearchText(_ searchText: String) {
    searchSubject.send(searchText) // 發送新的搜尋字串
  }

  /// 載入電影資料
  ///
  /// - Parameter search: 搜尋字串
  func loadMovies(search: String) {
    httpClient.fetchMovies(search: search)
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          self?.loadingCompleted = true // 載入完成，更新狀態
        case .failure(let error):
          print(error) // 載入失敗，打印錯誤訊息
        }
      }, receiveValue: { [weak self] movies in
        self?.movies = movies // 更新電影資料
      }).store(in: &cancellables) // 保存訂閱
  }
}
