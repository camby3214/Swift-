//
//  StoneLibrarySearchTool.swift
//  Adapter
//
//  Created by 李韋辰 on 2022/1/18.
//

import Foundation

class StoneLibrarySearchTool {
    
    // 搜索類型
    enum SearchType {
        case name // 根據書名搜索
        case category // 根據書籍類別搜索
    }
    
    // 資料源列表
    private var sources = [StoneLibraryDataSource]()
    
    // 所有書籍的列表
    var books: [StoneBook] {
        var results = [StoneBook]()
        for source in sources {
            results += source.books
        }
        return results
    }
    
    // 初始化方法
    init(sources: [StoneLibraryDataSource]) {
        self.sources = sources
    }
    
    // 根據搜索類型進行搜索
    func search(text: String, type: SearchType) -> [StoneBook] {
        var results = [StoneBook]()
        for source in sources {
            // 根據搜索類型選擇搜索方法
            results += type == .name ? source.searchByName(name: text) : source.searchByCategory(category: text)
        }
        return results
    }
}
