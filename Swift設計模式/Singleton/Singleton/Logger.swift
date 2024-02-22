//
//  Logger.swift
//  Singleton
//
//  Created by 李韋辰 on 2021/12/14.
//

import Foundation
    
class Logger{
    static let globalLogger = Logger()
    private var data = [String]()
    // 防止無意義初始化
    private init() {}
    func log(msg:String){
        data.append(msg)
    }
    
    func printLog(){
        for msg in data {
            print("Log: \(msg)")
        }
    }
}
