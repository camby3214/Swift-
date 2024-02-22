//
//  MathStuff.swift
//  UnitTestDEMO
//
//  Created by 李韋辰 on 2022/6/14.
//

import Foundation

class MathStuff {
    
    func addNumbers(x: Int, y: Int) -> Int {
        return x + y
    }
    
    func mutipleNumbers(x: Int, y: Int) -> Int {
        return x * y
    }
    
    func divideNumbers(x: Int, y: Int) -> Int {
        return x / y
    }
    
    func timeStringChangeTimeStamp(time: String) -> Int {
        let datefmatter = DateFormatter()
        datefmatter.dateFormat="yyyy / MM / dd HH"
        let date = datefmatter.date(from: time)
        guard let dateStamp = date?.timeIntervalSince1970 else { return 0}
        let dateStr = Int(dateStamp)
        return dateStr
    }
}
