//
//  Product.swift
//  ObjectTemplate
//
//  Created by 李韋辰 on 2022/1/13.
//

import Foundation

class Product {
    
    // MARK: - 欄位定義
    var name:String
    var description:String
    var price:Double
    var stockQuantity:Int = 0
    
    // 庫存
    var stock:Int{
        get{
            return stockQuantity
        }
        set{
            // 取較大值
            stockQuantity = max(0, newValue)
        }
    }
    
    // MARK: - 初始化設定
    init(name:String, description:String, price:Double, stock:Int){
        self.name = name
        self.description = description
        self.price = price
        self.stock = stock
    }
    
    // 計算稅金
    func calculateTax(rate: Double) -> Double{
        return self.price * rate
    }
    
    // 庫存總值
    var stockValue: Double{
        get{
            return self.price * Double(self.stock)
        }
    }
    
}
