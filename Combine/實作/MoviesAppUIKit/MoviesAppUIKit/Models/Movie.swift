//
//  Movie.swift
//  MoviesAppUIKit
//
//  Created by 李韋辰 on 2024/4/1.
//

import Foundation


struct MovieResponse: Decodable {
    let Search: [Movie]
}

struct Movie: Decodable {
    let title: String
    let year: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
}
