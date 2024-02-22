struct Human: Equatable{
    
    static var population = 0
    
    var name: String
    // 禁止外部設定（可存取）
    private(set) var age = 0
    var height = 100
    
    
    init(name: String) {
        self.name = name
        Self.population += 1
    }
    
    init(name: String, age: Int, height: Int) {
        self.name = name
        self.age = age
        self.height = height
        Self.population += 1
        
    }
    
    // 修改內部參數需使用 mutating
    mutating func birthday() {
        age += 1
        if (age<20) {
            height += (0...5).randomElement()!
        }
    }
    mutating func reset() {
        self = Human(name:name)
    }
    // 使用“==”時 只比較name
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}

var person = Human(name: "Camby")
var person2 = Human(name: "Camby", age: 10, height: 50)
var person3 = Human(name: "Linda")
print(person == person2)
print(person == person3)

print(Human.population)

print(person)
person.birthday()
print(person)
person.reset()
print(person)

print(Human.population)



struct PrinterManger {
    // 此struct不需建立 防止建立無意義類型
    private init() {}
    
    static func alert(_ message: String) {
        print("警告 \(message)")
    }
    static func notification(_ message: String) {
        print("提示 \(message)")
    }
    static func success(_ message: String) {
        print("成功 \(message)")
    }
}

PrinterManger.notification("地震!!")
