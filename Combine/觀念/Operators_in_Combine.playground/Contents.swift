import UIKit
import Combine

// Map
/*
// 建立一個從 1 到 5 的數值序列的發佈者
let numbersPublisher = (1...5).publisher

// map 會對發佈者序列中的每個值進行轉換，並生成新的序列。
let squaredPublisher = numbersPublisher.map { $0 * $0 }

// 訂閱 squaredPublisher，並在收到值時列印
let cancellable = squaredPublisher.sink(receiveValue: { value in
  print(value)
})
*/
// flatMap
/*
// 建立一個包含多個名字的發佈者
let namePublisher = ["John", "Mary", "Steven"].publisher

// 使用 flatMap 操作符將每個名字拆分為單個字母的發佈者序列
// flatMap 會將發佈者序列中的每個值（名字）轉換為另一個序列（字母序列），
// 並將所有序列合併為一個新的扁平化序列。
let flattedNamePublisher = namePublisher.flatMap { name in
  name.publisher
}

// 訂閱扁平化後的字母發佈者，並在收到字母時列印
let cancellable = flattedNamePublisher.sink { char in
  print(char)
}
 */
// Merge

// 建立兩個單獨的數字發佈者
let numbersPublisher1 = [1, 2, 3].publisher
let numbersPublisher2 = [4, 5, 6].publisher

// 使用 Merge 操作符將兩個發佈者合併為一個發佈者
// Merge 會將多個發佈者合併為一個單一的發佈者，所有序列的值將交錯混合在一起。
let mergePublisher = Publishers.Merge(numbersPublisher1, numbersPublisher2)

// 訂閱合併後的發佈者，並在收到值時列印
let cancellable = mergePublisher.sink(receiveValue: { value in
  print(value)
})
