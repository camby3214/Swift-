//
//  Employee.swift
//  Adapter
//
//  Created by 李韋辰 on 2022/1/18.
//

import Foundation


struct StoneBook {
    
    // 書名
    var name: String
    // 書籍類別
    var category: String
}


// StoneLibraryDataSource 協議
protocol StoneLibraryDataSource {
    
    // 書籍列表
    var books: [StoneBook] { get }
    
    // 根據書名進行搜索並返回結果
    func searchByName(name: String) -> [StoneBook]
    
    // 根據書籍類別進行搜索並返回結果
    func searchByCategory(category: String) -> [StoneBook]
    
}
