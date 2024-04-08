//
//  HTTPClient.swift
//  MoviesAppUIKit
//
//  Created by 李韋辰 on 2024/4/1.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
}

class HTTPClient {
    
    let apiKey = "15fbc32"
    
    /// 根據搜尋條件獲取電影資料
    ///
    /// - Parameter search: 搜尋字串
    /// - Returns: 發佈成功時會傳送電影資料陣列，失敗時會傳送錯誤
    func fetchMovies(search: String) -> AnyPublisher<[Movie], Error> {
        // 將搜尋字串編碼為 URL 格式
        guard let encodedSearch = search.urlEncoded,
              let url = URL(string: "https://www.omdbapi.com/?s=\(encodedSearch)&page=2&apiKey=\(apiKey)")
        else {
            // URL 無效時傳送錯誤
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url) // 建立資料任務發佈者
            // 取出資料任務的結果資料
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                // 將資料解碼成字串並打印
                print(String(decoding: data, as: UTF8.self))
            })
            .decode(type: MovieResponse.self, decoder: JSONDecoder()) // 將資料解碼成 MovieResponse 型別
            .map(\.Search) // 取出 MovieResponse 物件中的 Search 屬性，該屬性包含電影資料陣列
            .receive(on: DispatchQueue.main) // 在主執行緒上接收資料
            .eraseToAnyPublisher() // 擦除發佈者的類型
    }
}
