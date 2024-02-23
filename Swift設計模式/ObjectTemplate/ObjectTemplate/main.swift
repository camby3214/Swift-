//
//  main.swift
//  ObjectTemplate
//
//  Created by 李韋辰 on 2022/1/12.
//

import Foundation


var product = Product(name: "coffee", description: "latté", price: 50, stock: 10)

var products = [Product(name: "Kayak", description: "A boat for one person", price: 50, stock: 10),
                Product(name: "Lifejacket", description: "Protective and fashionable", price: 10, stock: 20),
                Product(name: "Soccer Ball", description: "FIFA-approved size and weight", price: 5, stock: 30)]

func calculateStockValue(productsArray:[Product]) -> Double {
    
    // reduce : 用於將一個集合中的元素依照指定的規則合併為單一值
    return productsArray.reduce(0, {(total,product) -> Double in
        return total + product.stockValue
    })
}

print("Sales tax for Kayak: $\(products[0].calculateTax(rate: 0.1))")
print("Total value of stock: $\(calculateStockValue(productsArray: products))")
