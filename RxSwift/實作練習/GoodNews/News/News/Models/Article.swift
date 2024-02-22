//
//  Article.swift
//  News
//
//  Created by 李韋辰 on 2022/4/12.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}


struct Article: Decodable {
    let title:String
    let description: String
}
