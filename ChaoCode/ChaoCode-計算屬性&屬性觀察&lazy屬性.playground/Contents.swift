import Foundation


//計算屬性
//必須用var宣告
//至少能用get
struct Square1 {
    var sideLength: Double
    var area: Double {
        set {
            print(">>>> 正在修改單邊長")
            sideLength = sqrt(newValue)
        }
        get {
            print(">>>> 正在計算面積")
            return sideLength*sideLength
        }
    }
}

var square1 = Square1(sideLength: 10)
print(square1.area)
print(square1.area)
print(square1.area)
square1.area = 64
print(square1)
"-------------------------------------------------------"
// 屬性觀察
struct Square2 {
    var sideLength: Double {
        willSet {
            print(">>>> 即將修改值為\(newValue)")
        }
        didSet {
            area = setArea()
            print(">>>> 已將\(oldValue)修改為\(sideLength)")
        }
    }
    lazy private(set) var area: Double = setArea()
    
    private func setArea() -> Double {
        print("計算面積")
        return sideLength*sideLength
    }
}

var square2 = Square2(sideLength: 10)
print(square2)
print(square2.area)
print(square2)
