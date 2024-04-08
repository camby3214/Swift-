import Combine

// combineLatest:會組合來自每個發佈者的最新值，並生成一個元組序列。
/*
let publisher1 = CurrentValueSubject<Int, Never>(1)
let publisher2 = CurrentValueSubject<String, Never>("Hello")
 
let combinedPublisher = publisher1.combineLatest(publisher2)

let cancellable = combinedPublisher.sink{ value1, value2 in
    print("Value1: \(value1), Value2: \(value2)")
}
publisher1.send(3)
publisher2.send("Introduction to Combine")
*/

// zip：使用 zip 操作符配對來自每個發佈者的值，並生成一個元組序列
/*
let publisher1 = [1, 2, 3, 4].publisher
let publisher2 = ["A", "B", "C"].publisher
let publisher3 = ["Allen", "Bob", "Camby"].publisher

//let zippedPublisher = publisher1.zip(publisher2)

let zippedPublisher = Publishers.Zip3(publisher1, publisher2, publisher3)

//let cancellable = zippedPublisher.sink{ value1, value2, value3 in
//    print("Value1: \(value1), Value2: \(value2), Value3: \(value3)")
//}

// 簡化代碼 用解包方式訪問元組的值
let cancellable = zippedPublisher.sink{ value in
    print("Value1: \(value.0), Value2: \(value.1), Value3: \(value.2)")
}
*/

// switchToLatest: 操作符會訂閱由外層發佈者發出的內部發佈者。
// 每當外層發佈者發出一個新的內部發佈者時，switchToLatest 就會取消對先前訂閱的內部發佈者的訂閱，並開始訂閱新發出的內部發佈者。
// 因此，switchToLatest 會確保我們始終只接收最新內部發佈者發出的值。

// outerPublisher (外部發佈者)
let outerPublisher = PassthroughSubject<AnyPublisher<Int, Never>, Never>()

// innerPublisher1 (内部發佈者 1)
let innerPublisher1 = CurrentValueSubject<Int, Never>(1)

// innerPublisher2 (内部發佈者 2)
let innerPublisher2 = CurrentValueSubject<Int, Never>(2)

// 訂閱 outerPublisher，並使用 switchToLatest 操作符
let cancellable = outerPublisher
  .switchToLatest()
  .sink { value in
    print(value)
  }

// 透過 outerPublisher 發送 innerPublisher1
outerPublisher.send(AnyPublisher(innerPublisher1))

// innerPublisher1 發送值 10
innerPublisher1.send(10)

// 透過 outerPublisher 發送 innerPublisher2
outerPublisher.send(AnyPublisher(innerPublisher2))

// innerPublisher2 發送值 20
innerPublisher2.send(20)
