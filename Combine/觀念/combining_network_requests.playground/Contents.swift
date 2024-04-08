import Combine
import UIKit


struct MovieResponse: Decodable {
  let Search: [Movie]
}


struct Movie: Decodable {
  let title: String
  
  private enum CodingKeys: String, CodingKey {
    case title = "Title"
  }
}

// 獲取電影列表函數 (fetchMovies)
func fetchMovies(_ searchTerm: String) -> AnyPublisher<MovieResponse, Error> {
  // 建立 API 網址 (包含搜尋字詞、頁碼和 API 金鑰)
  let url = URL(string: "https://www.omdbapi.com/?s=\(searchTerm)&page=2&apikey=564727fa")!
  
  // 建立 URLSession.shared.dataTaskPublisher 發佈者，用於發起網路請求
  return URLSession.shared.dataTaskPublisher(for: url)
    // 提取數據部分
    .map(\.data)
    // 解碼成 MovieResponse 類型
    .decode(type: MovieResponse.self, decoder: JSONDecoder())
    // 指定接收數據的佇列 (主線程)
    .receive(on: DispatchQueue.main)
    // 轉換為 AnyPublisher 類型 (方便后续操作)
    .eraseToAnyPublisher()
}

// 空的可取消訂閱集合
var cancellables: Set<AnyCancellable> = []

// 使用 CombineLatest 操作符合併兩個發佈者
Publishers.CombineLatest(fetchMovies("Batman"), fetchMovies("Spiderman"))
  .sink(receiveCompletion: { completion in
    // 忽略訂閱完成通知 (因範例中非必要)
  }, receiveValue: { value1, value2 in
    // 分别打印 "Batman" 和 "Spiderman" 的搜尋結果
    print(value1.Search)
    print(value2.Search)
  })
  // 將訂閱關係加入到可取消訂閱集合中
  .store(in: &cancellables)
