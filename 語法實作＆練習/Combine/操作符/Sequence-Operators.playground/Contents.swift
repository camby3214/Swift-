import UIKit
import Combine


////max,min
//let publisher = [1,-45,3,45,100].publisher
//
//publisher
//.max()
//    .sink {
//        print($0)
//}
//
//publisher
//.min()
//    .sink {
//        print($0)
//}

//--------------------------------------------

////first,last
//let publisher = ["A","B","C","D","E"].publisher
//
//publisher.first().sink {
//    print($0)
//}
////符合條件的第一個
//publisher.first(where: {"Cat".contains($0)}).sink {
//    print($0)
//}
//
//
//publisher.last().sink {
//    print($0)
//}

//--------------------------------------------

////output:發布索引值
//let publisher = ["A","B","C","D"].publisher
//
//publisher.output(at: 2).sink {
//    print($0)
//}
//
//print("Output(in)")
//
//publisher.output(in: (0...2)).sink {
//    print($0)
//}

//--------------------------------------------

////count:發布數量
//let publisher = ["A","B","C","D"].publisher
//let publisher1 = PassthroughSubject<Int, Never>()
//
//publisher.count().sink {
//    print($0)
//}
//
//publisher1.count().sink {
//    print($0)
//}
//publisher1.send(10)
//publisher1.send(completion: .finished)

//----------------------------------------------

////contain:判斷是否包含
//let publisher = ["A","B","C","D"].publisher
//publisher.contains("C").sink {
//    print($0)
//}

//--------------------------------------------

////allSatisfy:判斷是否全部符合判斷式
//let publisher = [12,2,14,4,6,8].publisher
//
//publisher.allSatisfy { $0 % 2 == 0 }.sink { allEven in
//    print(allEven)
//}

//--------------------------------------------

////reduce:序列會剩一個特定值。accumulator->累加器
//let publisher = [1,2,3,4,5,6].publisher
//
//publisher.reduce(0) { accumulator, value in
//    print("accumulator: \(accumulator) and the value is \(value)")
//    return accumulator + value
//}.sink {
//    print($0)
//}

