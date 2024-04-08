import UIKit
import Combine

// 定義 Post 資料模型，包含使用者 ID、文章 ID、標題和內容
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badServerResponse
}



// 定義 fetchPosts 函數，用於取得文章列表
func fetchPosts() -> AnyPublisher<[Post], Error> {
    // 設定 API 網址
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    // 建立 URLSession.shared.dataTaskPublisher 發佈者，用於發起網路請求
    return URLSession.shared.dataTaskPublisher(for: url)
    // 提取數據部分
        .tryMap { data, response in
            print("retry")
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkError.badServerResponse
            }
            return data
        }
    // 解碼成 [Post] 陣列
        .decode(type: [Post].self, decoder: JSONDecoder())
    // 請求失敗重試次數
        .retry(3)
    // 指定接收數據的佇列 (主線程)
        .receive(on: DispatchQueue.main)
    // 轉換為 AnyPublisher 類型 (方便后续操作)
        .eraseToAnyPublisher()
}

// 建立空的可取消訂閱集合
var cancellables: Set<AnyCancellable> = []

// 訂閱 fetchPosts() 發佈者
fetchPosts()
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("更新使用者介面")
        case .failure(let error):
            print(error)
        }
    }, receiveValue: { posts in
        print(posts)
    })
// 將訂閱關係加入到可取消訂閱集合中，以便统一管理
    .store(in: &cancellables)
