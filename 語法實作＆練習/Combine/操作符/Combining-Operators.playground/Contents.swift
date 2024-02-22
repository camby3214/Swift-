import UIKit
import Combine


////prepend:在發布前新增元素
//let numbers = (1...5).publisher
//let publisher2 = (500...510).publisher
//
//numbers.prepend(100,101)
//    .prepend(-1,-2)
//    .prepend([45,67])
//    .prepend(publisher2)
//    .sink {
//    print($0)
//}
//
//---------------------------------------------
////append:在發布後新增元素
//let numbers = (1...10).publisher
//let publisher = (100...110).publisher
//
//numbers.append(11,12)
//.append(13,14)
//.append(publisher)
//    .sink {
//    print($0)
//}
//
//---------------------------------------------

////switchToLatest:切換到最新的publisher
//let publisher1 = PassthroughSubject<String, Never>()
//let publisher2 = PassthroughSubject<String, Never>()
//
//let publishers = PassthroughSubject<PassthroughSubject<String, Never>,Never>()
//
//
//publishers.switchToLatest().sink {
//    print($0)
//}
//
//publishers.send(publisher1)
//
//publisher1.send("Publisher 1 - Value 1")
//publisher1.send("Publisher 1 - Value 2")
//
//publishers.send(publisher2) // switching to publisher 2
//
//publisher2.send("Publisher 2 - Value 1")
//
//publisher1.send("Publisher 1 - Value 3")//以切換到publisher2，不會打印

//---------------------------------------------

////merge:合併publisher
//let publisher1 = PassthroughSubject<Int, Never>()
//let publisher2 = PassthroughSubject<Int, Never>()
//
//publisher1.merge(with: publisher2).sink {
//    print($0)
//}
//
//publisher1.send(10)
//publisher2.send(11)

//---------------------------------------------

////combineLatest:合併不同的publisher並發布各publisher最新的值
//let publisher1 = PassthroughSubject<Int, Never>()
//let publisher2 = PassthroughSubject<String,Never>()
//
//publisher1.combineLatest(publisher2)
//    .sink {
//        print("P1: \($0), P2: \($1)")
//}
//
//publisher1.send(1) //另一個publisher還沒有值不會單獨發佈
//publisher1.send(2) //publisher2 有值後 publisher1 最新的值為2 所以打印結果不會出現1
//publisher2.send("A")
//publisher2.send("B")

//---------------------------------------------

//zip:照順序配對 publisher 若沒配對到就不會發佈
let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<String, Never>()

publisher1.zip(publisher2).sink {
    print("P1: \($0), P2: \($1)")
}

publisher1.send(1)
publisher1.send(2)
publisher2.send("3")
publisher2.send("4")
publisher1.send(5)
publisher1.send(6)
publisher1.send(7) //沒有配對到不會發佈
publisher1.send(8) //沒有配對到不會發佈
publisher2.send("9")
publisher2.send("10")
