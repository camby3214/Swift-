import Foundation

//func swapTwoValues<T>( a: inout T, b: inout T) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
//var aInt = 10
//var bInt = 20
//swap(&aInt, &bInt)
//print("a = \(aInt),b = \(bInt)")
//
//var aString = "a"
//var bString = "b"
//swap(&aString, &bString)
//print("a = \(aString),b = \(bString)")

struct Stack<Element> {
    // 將型別參數用於型別標註 設置一個型別為 [Element] 的空陣列
        var items = [Element]()

        // 型別參數用於方法的參數型別 方法功能是增加一個元素到陣列最後一員
        mutating func push(item: Element) {
            items.append(item)
        }

        // 型別參數用於方法的返回值型別 方法功能是移除陣列的最後一個元素
        mutating func pop() -> Element {
            return items.removeLast()
        }
}

var stackOfStrings = Stack<String>()

// 依序放入三個字串
stackOfStrings.push(item: "one")
stackOfStrings.push(item: "two")
stackOfStrings.push(item: "three")

// 然後移除掉最後一個元素 即字串 "three"
stackOfStrings.pop()
print(stackOfStrings)

var stackOfInt = Stack<Int>()

// 依序放入三個字串
stackOfInt.push(item: 1)
stackOfInt.push(item: 2)
stackOfInt.push(item: 3)

// 然後移除掉最後一個元素 即字串 "three"
stackOfInt.pop()
print(stackOfInt)

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
