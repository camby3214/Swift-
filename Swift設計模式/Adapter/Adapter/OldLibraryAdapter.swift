//
//  OldLibraryAdapter.swift
//  Adapter
//
//  Created by 李韋辰 on 2022/1/18.
//

import Foundation

class OldLibraryAdapter: StoneLibraryDataSource {
    
    // 儲存舊圖書館目錄的實例
    fileprivate let directory: OldLibraryDirectory
    
    // 初始化方法
    init() {
        directory = OldLibraryDirectory() // 創建舊圖書館目錄的實例
    }
    
    // StoneLibraryDataSource 協議的要求，返回 StoneBook 類型的書籍列表
    var books: [StoneBook] {
        // 透過舊圖書館目錄的項目創建 StoneBook 的書籍列表
        return directory.getItems().values.map { item -> StoneBook in
            return StoneBook(name: item.getName(), category: item.getKind())
        }
    }
    
    // StoneLibraryDataSource 協議的要求，根據書名進行搜索並返回結果
    func searchByName(name: String) -> [StoneBook] {
        // 使用 createBooks 方法根據搜尋條件過濾舊圖書館目錄中的項目
        return createBooks(filter: {(oldBook: OldLibraryBook) -> Bool in
            return oldBook.getName().range(of: name) != nil
        })
    }
    
    // StoneLibraryDataSource 協議的要求，根據書籍類別進行搜索並返回結果
    func searchByCategory(category: String) -> [StoneBook] {
        // 使用 createBooks 方法根據搜尋條件過濾舊圖書館目錄中的項目
        return createBooks(filter: {(oldBook: OldLibraryBook) -> Bool in
            return oldBook.getKind().range(of: category) != nil
        })
    }
    
    // 根據過濾條件將舊圖書館目錄中的項目轉換為 StoneBook 書籍列表
    func createBooks(filter filterClosure: ((OldLibraryBook) -> Bool)) -> [StoneBook] {
        var results = [StoneBook]()
        for item in directory.getItems().values {
            if filterClosure(item) {
                let aBook = StoneBook(name: item.getName(), category: item.getKind())
                results.append(aBook)
            }
        }
        return results
    }
}
