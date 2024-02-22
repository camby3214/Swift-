import UIKit
import Combine


//// collect: 轉換成 Array 輸出，括號內為設定幾個元素一組
//["A","B","C","D","E"].publisher.sink {
//    print($0)
//}
//
//["A","B","C","D","E"].publisher.collect(3).sink {
//    print($0)
//}

//// map: 將收到的元素進行處理後再輸出
//let formatter = NumberFormatter()
//formatter.numberStyle = .spellOut
//
//let numberArray = [12, 34, 56]
//numberArray.publisher.map {
//    formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
//
//}.sink {
//    print($0)
//}

////map Key Path: 方便存取資料
//struct Point {
//    let x: Int
//    let y: Int
//}
//
//let publisher = PassthroughSubject<Point, Never>()
//
//publisher.map(\.x, \.y)
//    .sink { x, y in
//        print("x: \(x), y: \(y)")
//    }
//publisher.send(Point(x: 1, y: 2))


////flapMap: 將元素解包
//
//struct School {
//    let name: String
//    let noOfStudents: CurrentValueSubject<Int, Never>
//
//    init(name: String, noOfStudents: Int) {
//        self.name = name
//        self.noOfStudents = CurrentValueSubject(noOfStudents)
//    }
//}
//
//let citySchool = School(name: "Fountain Head School", noOfStudents: 100)
//
//// school第一次觸發
//let school = CurrentValueSubject<School,Never>(citySchool)
//
//school
//    .flatMap {
//        $0.noOfStudents
//    }
//    .sink {
//        print($0)
//}
//
//let townSchool = School(name: "Town Head School", noOfStudents: 45)
//
//
//// school第二次觸發
//school.value = townSchool
//
//// 若沒有 flatMap 下列兩個都不會觸發
//citySchool.noOfStudents.value += 1
//townSchool.noOfStudents.value += 10

////replaceNil: 將nil的值用其他東西替代
//let array = ["A","B",nil,"C",nil]
//
//array.publisher.replaceNil(with: "*")
//    .map { $0! }
//    .sink {
//        print($0)
//    }

////replaceEmpty: 將空的值用其他東西替代
//
//let empty = Empty<Int, Never>()
//
//empty.replaceEmpty(with: 1)
//    .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
//
//

////scan:掃描所有值，包括前一個值
//
//let publisher = (1...10).publisher
//
//publisher.scan([]) { number, value -> [Int] in
//    print(number)
//    print(value)
//    return number + [value]
//}.sink {
//    print($0)
//}
