//
//  OldLibraryBook.swift
//  Adapter
//
//  Created by 李韋辰 on 2022/1/18.
//

import Foundation

class OldLibraryBook {
    
    // 書名
    private var name: String
    // 書籍類別
    private var kind: String
    
    // 初始化方法
    init(name: String, kind: String) {
        self.name = name
        self.kind = kind
    }
    
    // 返回書名
    func getName() -> String {
        return name
    }
    
    // 返回書籍類別
    func getKind() -> String {
        return kind
    }
    
}
 
class OldLibraryDirectory {
    
    // 儲存舊圖書館目錄項目的字典
    private var items: [String: OldLibraryBook]
    
    // 初始化方法
    init() {
        // 初始化舊圖書館目錄項目字典
        items = ["gone girl": OldLibraryBook(name: "gone girl", kind: "novel"),
                "the martian" : OldLibraryBook(name: "the martian", kind: "novel")
        ]
    }
    
    // 返回舊圖書館目錄項目字典
    func getItems() -> [String: OldLibraryBook] {
        return items
    }
    
}
