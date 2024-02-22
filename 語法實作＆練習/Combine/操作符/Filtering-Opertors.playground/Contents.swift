import UIKit
import Combine


////filter:按條件過濾
//let numbers = (1...20).publisher
//
//numbers.filter { $0 % 2 == 0 }
//    .sink {
//        print($0)
//}

//----------------------------------

////compactMap: 可過濾可選值
//let strings = ["a","1.24","b","3.45","6.7"].publisher
//    .compactMap{ Float($0) }
//    .sink {
//    print($0)
//}

//----------------------------------

////ignoreOutput:直接忽略 output 值
//let numbers = (1...5000).publisher
//
//numbers.ignoreOutput().sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })

//----------------------------------

////dropFirst:忽略前幾項
//let numbers = (1...10).publisher
//
//numbers.dropFirst(8)
//    .sink {
//        print($0)
//}

//----------------------------------

////drop-untilOutputFrom:直到條件成立為止才開始發布
//let isReady = PassthroughSubject<Void, Never>()
//let taps = PassthroughSubject<Int, Never>()
//
//taps.drop(untilOutputFrom: isReady).sink {
//    print($0)
//}
//
//(1...10).forEach { n in
//    taps.send(n)
//
//    if n == 3 {
//        isReady.send()
//    }
//
//}

//----------------------------------

//prefix: 發布前幾項
let numbers = (1...10).publisher

numbers.prefix(2).sink {
    print($0)
}

numbers.prefix(while: { $0 < 3 }).sink {
    print($0)
}
