import UIKit
import RxSwift
import PlaygroundSupport



let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

//// ignoreElements ：忽略所有發布
////值被忽略 所以 Subscription is called 只顯示一次（onCompleted()）
//strikes.ignoreElements()
//    .subscribe { _ in
//        print("[Subscription is called]")
//}.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
//strikes.onCompleted()

////elementAt : 觀察指定元素
////只發佈第二個元素給觀察者
//strikes.element(at: 2)
//    .subscribe(onNext:{ element in
//        print(element)
//    }).disposed(by: disposeBag)
//
//strikes.onNext("0")
//strikes.onNext("1")
//strikes.onNext("2")
//strikes.onNext("3")

////filter : 過濾元素
//Observable.of(1,2,3,4,5,6,7,8,9,0)
//    .filter { $0 % 2 == 0}
//    .subscribe(onNext : {
//        print($0)
//    }).disposed(by: disposeBag)

////skip : 跳過元素
//Observable.of("A","B","C","D","E","F")
//    .skip(3)
//    .subscribe(onNext : {
//        print($0)
//    }).disposed(by: disposeBag)

////skipWhile : 跳過符合條件式的元素
//Observable.of(2,2,3,4,4)
//    .skip(while:{ $0 % 2 == 0})
//    .subscribe(onNext:{
//        print($0)
//    }).disposed(by: disposeBag)

////skipUntil : 觸發前的所有發布都被跳過
//let trigger = PublishSubject<String>()
//
//strikes.skip(until: trigger)
//    .subscribe(onNext:{
//        print($0)
//    }).disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//
//trigger.onNext("X")
//
//strikes.onNext("C")

////take : 取前幾個發布
//Observable.of(1,2,3,4,5,6)
//    .take(3)
//    .subscribe(onNext:{
//        print($0)
//    }).disposed(by: disposeBag)

//takeWhile : 取特定條件的發佈
//發布條件不符合之後的發布，即使符合也不會發布
Observable.of(2,4,6,7,8,10)
    .take(while: {
        return $0 % 2 == 0
    })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

////takeUntil : 觸發後的所有發布都被跳過
//let trigger = PublishSubject<String>()
//
//strikes.take(until: trigger)
//    .subscribe(onNext:{
//        print($0)
//    }).disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//
//trigger.onNext("X")
//
//strikes.onNext("C")
