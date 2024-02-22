// propertyWrapper 寫法
// 建立一個類型，並標示 @propertyWrapper
// 必須有一個名為 wrapppedValue、至少可以get的屬性
// 可以加上 projectedValue 投射任何屬性或本身

@propertyWrapper
struct ChangeLog<T> {
    var wrappedValue: T {
        didSet {
            print("\(describeString)的值被改變為\(wrappedValue)")
        }
    }
    
    private(set) var describeString: String
}

struct accounts {
    @ChangeLog(describeString: "用途") var use:String = ""
    @ChangeLog(describeString: "花費") var cost: Int = 0
}

var spend = accounts(use: "全聯採買", cost: 2000)
print(spend.use,spend.cost)
spend.use = "全聯採買 + 午餐"
spend.cost = 2100


//-----------------------------------------------------------
@propertyWrapper
struct Validation {
    private var text: String
    private var defaultValue: String
    var isValid:Bool { !text.isEmpty }
    var wrappedValue: String {
        get {
            text.isEmpty ? defaultValue :text
        }
        set {
            text = newValue
        }
    }
    // 投射本身出去
    var projectedValue: Self { self }
    
    init(wrappedValue: String, defaultValue: String) {
        text = wrappedValue
        self.defaultValue = defaultValue
    }
}

struct User {
    @Validation(defaultValue: "未命名的使用者") var name: String = ""
    
    func greeting(){
        print("你好", name)
        // 投射出去的值“$”
        if($name.isValid) {
            print("獲得折扣碼")
        } else {
            print("請設定姓名以獲得折扣碼")
        }
    }
}

var user = User()
print(user.name)
user.greeting()
user.name = "Camby"
print(user.name)
user.greeting()

