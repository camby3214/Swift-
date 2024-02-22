## Subject

---

### Define

同時是Observable跟Observer

### PublishSubject

- PublishSubject :『開始是空的，只會發送新的元素給訂閱者』

```swift
let subject = PublishSubject<String>()

subject.onNext("Issue 1")

subject.subscribe{ event in
    print(event)
}
subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.dispose()

subject.onNext("Issue 4")
```

執行結果：

```
next(Issue 2)
next(Issue 3)
```

PublishSubject只會發送新的元素給訂閱者所以 "Issue 1" 沒有印出來，dispose()後就不再觀察了，所以 "Issue 4" 沒有印出來。



### BehaviorSubject

- BehaviorSubject : 開始是預設值，發送目前的最後一個值給訂閱者』，不管什麼時候訂閱，都會有元素可以收到（至少有預設值）。

```swift
let subject2 = BehaviorSubject(value: "Initial Value")

subject2.onNext("Last Issue")

subject2.subscribe { event in
    print(event)
}

subject2.onNext("Issue 1")
```

執行結果：

```
next(Last Issue)
next(Issue 1)
```

只發送目前的最後一個值給訂閱者，所以 "Initial Value" 不會顯示



### ReplaySubject

- ReplaySubject:一訂閱就拿到上n次的值，定義是『開始時給訂一個暫存大小（buffer size），發送時會將最後的n個元素存進暫存，並將暫存的元素發給訂閱者』

```swift
let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.subscribe {
    print($0)
}

subject.onNext("Issue 4")
subject.onNext("Issue 5")
subject.onNext("Issue 6")

print("[Subscription 2]")
subject.subscribe {
    print($0)
}

```

執行結果：

```
next(Issue 2) -------> //訂閱前2個元素
next(Issue 3) -------> //訂閱前2個元素
next(Issue 4)
next(Issue 5)
next(Issue 6)
[Subscription 2]
next(Issue 5) -------> //訂閱前2個元素
next(Issue 6) -------> //訂閱前2個元素
```





Subject可以發送元素給他的訂閱者，這時Subject作為一個Observable的角色，所以也可以寫成 :

```swift
subject.asObservable()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
```

