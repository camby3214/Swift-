import Combine

// Subjects : 可發布及訂閱

// PassthroughSubject： 將收到的值傳遞給所有訂閱者。
/*
let subject = PassthroughSubject<Int, Never>()

subject.sink { value in
    print(value)
}

subject.send(1)
subject.send(2)
*/

// CurrentValueSubject： 保留最新發送的值，並在有新的值發送時更新最新值。

let currentValueSubject = CurrentValueSubject<String, Never>("John")

let camcellable = currentValueSubject.sink { value in
    print(value)
}

currentValueSubject.send("Mary")

print(currentValueSubject.value)
