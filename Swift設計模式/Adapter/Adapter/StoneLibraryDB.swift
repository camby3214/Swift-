//
//  DataSources.swift
//  Adapter
//
//  Created by 李韋辰 on 2022/1/18.
//

import Foundation


class StoneLibraryDB: StoneLibraryDataSource {
    
    // 書籍列表
    var books = [StoneBook]()
    
    // 根據過濾條件搜索書籍並返回結果
    private func search(_ selector:((StoneBook) -> Bool)) -> [StoneBook] {
        var results = [StoneBook]()
        for book in books {
            if selector(book) {
                results.append(book)
            }
        }
        return results
    }
    
    // 根據書名進行搜索並返回結果
    func searchByName(name: String) -> [StoneBook] {
        return search({ book -> Bool in
            return book.name.range(of: name) != nil
        })
    }
    
    // 根據書籍類別進行搜索並返回結果
    func searchByCategory(category: String) -> [StoneBook] {
        return search({ book -> Bool in
            return book.category.range(of: category) != nil
        })
    }
    
}
 
class ComputerScienceDB: StoneLibraryDB {
    
    // 初始化方法
    override init() {
        super.init()
        // 添加計算機科學類別的書籍
        books.append(StoneBook(name: "Code Complete", category: "computer science"))
        books.append(StoneBook(name: "Algorithm", category: "computer science"))
    }
    
}


class FruitDB: StoneLibraryDB {
    
    // 初始化方法
    override init() {
        super.init()
        // 添加水果類別的書籍
        books.append(StoneBook(name: "apple", category: "fruit"))
        books.append(StoneBook(name: "orange", category: "fruit"))
    }
}
