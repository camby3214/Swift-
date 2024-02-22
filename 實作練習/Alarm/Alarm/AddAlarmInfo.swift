//
//  AddAlarmInfo.swift
//  Alarm
//
//  Created by 李韋辰 on 2022/3/5.
//

import Foundation

struct AddAlarmInfo {
    let time: Date
    let annotation: String
    
    init(time: Date,annotation: String){
        self.time = time
        self.annotation = annotation
    }
}
