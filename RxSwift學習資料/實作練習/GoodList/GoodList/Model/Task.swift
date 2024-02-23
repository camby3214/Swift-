//
//  Task.swift
//  GoodList
//
//  Created by 李韋辰 on 2022/3/18.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
