//
//  BackupServer.swift
//  Singleton
//
//  Created by 李韋辰 on 2021/12/14.
//

import Foundation

class DataItem {
    enum ItemType : String {
        case Email = "Email Address"
        case Phone = "Telephone Number"
        case Card = "Credit Card Number"
    }
    
    var type:ItemType;
    var data:String;
    
    init(type:ItemType, data:String){
        self.type = type
        self.data = data
    }
}

class BackupServer {
    let name:String
    private var data = [DataItem]()
    
    init(name:String){
        self.name = name
        Logger.globalLogger.log(msg: "Creat new Server \(name)")
    }
    func backup(item:DataItem){
        data.append(item)
        Logger.globalLogger.log(msg: "\(name) backed up item of type \(item.type.rawValue)")
    }
    func getData() -> [DataItem]{
        return data
    }
}
