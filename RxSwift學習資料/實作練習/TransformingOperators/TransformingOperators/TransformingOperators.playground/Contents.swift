import UIKit
import RxSwift
import RxCocoa
import RxRelay
import PlaygroundSupport


let disposeBag = DisposeBag()

////toArray : 將元素轉為陣列
//Observable.of(1,2,3,4,5,6)
//    .toArray()
//    .subscribe({
//        print($0)
//    }).disposed(by: disposeBag)


////map:依條件發布新的元素
//Observable.of(1,2,3,4,5)
//    .map{ return $0 * 2}
//    .subscribe(onNext :{
//        print($0)
//    }).disposed(by: disposeBag)


//flatmap : 將 Observable 裡的值轉換為觀察對象，修改值也會發布觀察
//struct Student {
//    var score: BehaviorRelay<Int>
//}
//
//let john = Student(score: BehaviorRelay(value: 75))
//let mary = Student(score: BehaviorRelay(value: 90))
//
//let student = PublishSubject<Student>()
//
//student.asObservable()
//    .flatMap{ $0.score.asObservable() }
//    .subscribe(onNext:{
//        print($0)
//    }).disposed(by: disposeBag)
//
//student.onNext(john)
//
//
//john.score.accept(100)
//student.onNext(mary)
//mary.score.accept(43)
//john.score.accept(50)


//flatmapLatest : 同 flatmap ，但只觀察最後一個觀察對象，若修改前一個觀察對象的值，不會發佈觀察。
struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 90))

let student = PublishSubject<Student>()

student.asObservable()
    .flatMapLatest{ $0.score.asObservable() }
    .subscribe(onNext:{
        print($0)
    }).disposed(by: disposeBag)

student.onNext(john)


john.score.accept(100)
student.onNext(mary)
mary.score.accept(43)
john.score.accept(50)
