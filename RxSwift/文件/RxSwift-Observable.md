## Observable

---

### Define

Rx 的一個核心觀念就是 observable 或稱 sequence 。在 Rx 的世界，都是由 observable 構成。 

## <img src="image/Observable01.png" alt="Observable01" style="zoom:50%;" />

可將observable視為一個當方向的 flow

上圖可以解釋成 : 向訂閱者發送一個數字 “1”，然後間隔了一下，再發送數字 “3” 跟 “7” ，然後結束了這個Observable（直線代表完成）。



### 建立Observable

建立一個Observable有許多方式，這裡先用最簡單的方式，使用`of`建立一個有限序列，`of`可將多個**相同型態**的元素，建立成一個Observable。

```swift
let observable = Observable.of(1, 3, 7)
```



### 訂閱Observable

使用`.subscribe`來訂閱Observable，藉此來接收值得變化。

```swift
let disposeBag = DisposeBag()

observable
    .subscribe(onNext: { element in
        print(element)
    }, onError: { error in
        print(error)
    }, onCompleted: {
        print("onCompleted")
    }, onDisposed: {
        print("onDisposed")
    })
    .disposed(by: disposeBag)
```

從程式碼可以對應到我們上面的描述，當訂閱者收到Observable發出的.next、.error、.completed事件時，會依據我們定義好的程式執行。執行結果如下。

```
1
3
7
onCompleted
onDisposed
```

### Dispose

上個範例有提到Dispose，這是跟Observable銷毀機制有關，Observable某種程度算是無限的，所以就不得不考慮何時需要把Observable銷毀。想像有一個袋子，裡面放著球，當把這個袋子丟掉，球也一起被丟掉了，從上個例子來看，`disposeBag`就是那個袋子，訂閱者就是那顆球，我們將訂閱者裝進去，當 ViewController deinit 時，Observable卻還沒結束，這時裝在 `DisposeBag` 中的所有 `Disposable` 就會執行`dispose()`，藉此來釋放資源。

如果你撰寫程式時，進行了`.subscribe()`卻忘記寫`.disposed()`，這很有可能會造成Memory leak。



### 常見的建立Observable的方式

#### - interval

『固定間隔時間，發送元素』的Observable

```swift
let observable = Observable<Int>.interval(.milliseconds(500), scheduler: MainScheduler.instance)
```

#### - just

單一物件的Observable，當要把一個pure value轉成Observable時就可以用，像是bool。

```swift
let observable = Observable.just(true)
// — - true — - | ->
```

#### - from

- 可以把陣列轉成Observable，執行結果是將陣列內每個元素逐一發送。

```swift
let observable = Observable.from([1, 3, 7])
// - - 1 - - 3 - - 7 — - | ->
```

- 如果optional types變數不為nil，就發送出去。

```swift
let number: Int? = 5
let observable = Observable.from(optional: number)
// - - 5 - - | -> number為5的情況
// - - | -> number為nil的情況
```

#### - create

提供客製化Observable方式，在需要自訂成功、失敗條件時很好用。

```swift
func isEven(number: Int) -> Observable<Int> {
    // 1
    return Observable.create { observer in
        
        if number % 2 == 0 {
			  // 2
            observer.onNext(number)
            observer.onCompleted()
        } else {
			  // 3
            observer.onError(NSError.init(domain: "不是偶數", code: 401, userInfo: nil))
        }
        // 4
        return Disposables.create()
        
    }
}
```