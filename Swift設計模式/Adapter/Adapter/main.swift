//
//  main.swift
//  Adapter
//
//  Created by 李韋辰 on 2022/1/18.
//

import Foundation

// 創建 StoneLibrarySearchTool 實例 searchTool，設置資料源並執行搜索操作
let searchTool = StoneLibrarySearchTool(sources: [ComputerScienceDB(), FruitDB(), OldLibraryAdapter()])

// 列印所有書籍名稱
print("== list ==")
for book in searchTool.books {
    print(book.name)
}

// 按類別搜索並列印書籍名稱
print("== search ==")
for book in searchTool.search(text: "computer science", type: .category) {
    print(book.name)
}
