## Combine

---

Apple 官方的 FRP (Functional Reactive Programming ，函數式反應式程式設計) 框架 。



### Usage

```swift
// 一般的命令式寫法
let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
    if let data = data {
        print(data)
    }
})
task.resume()
```

```swift
// Combine 的宣告式寫法
let subscription = URLSession.shared.dataTaskPublisher(for: url)
    .map { $0.data }
    .sink(receiveCompletion: { completion in
        print(completion)
    },
          receiveValue: { data in
        print(data)
    })

```



### 基礎使用方式

Combine 框架主要分成發布者 (Publisher)、操作者 (Operator)、和訂閱者 (Subscriber) 三大部分。可以透過這三種元件的組裝，來建立各式各樣的訂閱關係 (Subscription)：

```swift
// 4. 訂閱關係
let subscription = 

    // 1. 發布者
    URLSession.shared.dataTaskPublisher(for: url)

    // 2. 操作者
    .map { $0.data }

    // 3. 訂閱者
    .sink(receiveCompletion: { completion in 
    	// 處理 completion...  
    },receiveValue: { data in 
    	// 處理 data...  
    })
```

1. 回傳一個發布者結構體。發布者代表的，是值的產生源頭。
2. 使用 `map(_:)` 與其它操作者方法，來對發布者產生的值做變動。
3. 使用 `sink(receiveCompletion:receiveValue:)` 等訂閱者方法，來處理最後拿到的值，並且啟動與發布者之間的訂閱關係。
4. 代表訂閱關係的實體，可以用來取消訂閱。