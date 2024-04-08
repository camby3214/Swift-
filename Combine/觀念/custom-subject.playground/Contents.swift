import Combine

class EvenSubject<Failure: Error>: Subject {

  // 輸出資料型態 (Output) 限制為整數 (Int)
  typealias Output = Int
  
  // 内部使用的 PassthroughSubject 物件
  private let wrapped: PassthroughSubject<Int, Failure>

  // 初始化方法，設定初始值
  init(initialValue: Int) {
    self.wrapped = PassthroughSubject()
    // 確保初始值一定是偶數
    let evenInitialValue = initialValue % 2 == 0 ? initialValue : 0
    send(initialValue)
  }

  // 遵循 Subject 協議，轉發訂閱訊息
  func send(subscription: Subscription) {
    wrapped.send(subscription: subscription)
  }

  // 覆寫 Subject 的 send 方法，只發送偶數
  func send(_ value: Int) {
    if value % 2 == 0 {
      wrapped.send(value)  // 僅傳遞偶數給内部的 PassthroughSubject
    }
  }

  // 遵循 Subject 協議，轉發完成訊息
  func send(completion: Subscribers.Completion<Failure>) {
    wrapped.send(completion: completion)
  }

  // 遵循 Subject 協議，訂閱處理
  func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Int == S.Input {
    wrapped.receive(subscriber: subscriber)
  }
}

// 建立 EvenSubject 物件，初始值為 4
let subject = EvenSubject<Never>(initialValue: 4)

// 訂閱 subject，並列印收到的值
let cancellable = subject.sink { value in
  print(value)
}

// 測試送入各種數值
subject.send(12)  // 偶數，會被送出
subject.send(13)  // 奇數，不會被送出
subject.send(14)  // 偶數，會被送出
