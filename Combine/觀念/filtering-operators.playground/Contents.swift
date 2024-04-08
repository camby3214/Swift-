import UIKit
import Combine

//filter
/*
 // 建立一個從 1 到 10 的數值序列的發佈者
 let numbersPublisher = (1...10).publisher

 // 使用 filter 操作符篩選序列中的偶數，並建立一個新的發佈者
 // filter 會篩選發佈者序列中的值，只保留符合指定條件的值，並生成新的序列。
 let evenNumberPublisher = numbersPublisher.filter { $0 % 2 == 0 }

 // 訂閱 evenNumberPublisher，並在收到偶數時列印
 evenNumberPublisher.sink { value in
   print(value)
 }
*/

// compactMap
/*
 // 建立一個包含字串的發佈者
 let stringsPublisher = ["1","2","3","A","5"]

 // 使用 compactMap 操作符嘗試將每個字串轉換為整數，並建立一個新的發佈者
 // compactMap 會嘗試將發佈者序列中的每個值轉換為另一種型態，但僅保留轉換成功的結果，並生成新的序列。
 let numbersPublisher = stringsPublisher.compactMap { Int($0) }

 // 訂閱轉換後的數字發佈者，並在收到整數時列印
 let cancellable = numbersPublisher.sink { value in
   print(value)
 }
*/

// debounce

// 建立一個接受字串的發佈者 (PassthroughSubject)
let textPublisher = PassthroughSubject<String, Never>()

// 使用 debounce 操作符延遲發佈，降低發佈頻率
// debounce 會在收到一連串值之後，延遲指定的時間才發佈最新的值。
let debouncedPublisher = textPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)

// 訂閱延遲後的字串發佈者，並在收到值時列印
let cancellable = debouncedPublisher.sink { value in
  print(value)
}

// 發佈多個字串到 textPublisher
textPublisher.send("A")
textPublisher.send("B")
textPublisher.send("C")
textPublisher.send("D")
textPublisher.send("E")
textPublisher.send("F")
textPublisher.send("G")

