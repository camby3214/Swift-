//
//  Date+extention.swift
//  PGTalkLiteProvingGround
//
//  Created by 李韋辰 on 2022/6/28.
//

import Foundation

extension Date {
    func setTimestampToLeaveFormat(time: Int) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy / MM / dd HH"
        let currentTime = dformatter.string(from: date)
        return currentTime
    }
    func stringToTimeStamp(_ string: String, dateFormat: String = "yyyy / MM / dd HH") -> Int64 {
        let datefmatter = DateFormatter()
        datefmatter.dateFormat = dateFormat
        let date = datefmatter.date(from: string)
        
        guard let dateStamp = date?.timeIntervalSince1970 else { return 0}
        let dateStr = Int64(dateStamp * 1000)
        return dateStr
    }
    func stringToDate(_ string: String, dateFormat: String = "yyyy / MM / dd") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date ?? Date()
    }
    
    func dateToString(date: Date, dateFormat: String = "yyyy年MM月dd日 HH:mm") -> String {
        var result = String()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        result = formatter.string(from: date)
        return result
    }
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

}
