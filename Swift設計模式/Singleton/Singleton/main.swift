//
//  main.swift
//  Singleton
//
//  Created by 李韋辰 on 2021/12/14.
//

import Foundation


var server = BackupServer(name: "Server#1")
server.backup(item: DataItem(type: DataItem.ItemType.Email, data: "camby3214@gmail.com"))
server.backup(item: DataItem(type: DataItem.ItemType.Phone, data: "0909679791"))

Logger.globalLogger.log(msg: "Backed up 2 item to \(server.name)")


var otherServer = BackupServer(name: "Server#2");
otherServer.backup(item: DataItem(type: DataItem.ItemType.Email, data: "camby3214@gmail.com"))
otherServer.backup(item: DataItem(type: DataItem.ItemType.Phone, data: "0909679791"))

Logger.globalLogger.log(msg: "Backed up 1 item to \(otherServer.name)")

Logger.globalLogger.printLog()
