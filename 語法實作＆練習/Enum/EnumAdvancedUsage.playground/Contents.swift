import Foundation

////1.
//enum Movement{
//    case Left
//    case Right
//    case Top
//    case Bottom
//}
//
//可以使用 case 獲取到 Movement 的枚舉值，按照特定情況執行操作:
//let aMovement = Movement.Right
//
//switch aMovement {
//case .Left:
//    print("Left")
//case .Right:
//    print("Right")
//case .Top:
//    print("Top")
//case .Bottom:
//    print("Bottom")
//}
//案例中無須明確指出enum的實際名稱(即case Move.Left:print("Left"))。因爲類型檢查器能夠自動爲此進行類型推算。這對於那些UIKit以及AppKit中錯綜複雜的枚舉是非常有用的。


////2.
////爲enum中每個case分配一個值
//
//// 映射到整數
//enum Movement: Int {
//    case Left = 0
//    case Right = 1
//    case Top = 2
//    case Bottom = 3
//}
//
//// 同樣與字符串對應
//enum House: String {
//    case Baratheon = "Ours is the Fury"
//    case Greyjoy = "We Do Not Sow"
//    case Martell = "Unbowed, Unbent, Unbroken"
//    case Stark = "Winter is Coming"
//    case Tully = "Family, Duty, Honor"
//    case Tyrell = "Growing Strong"
//}
//
//// 或者float double都可以(同時注意枚舉中的花式unicode)
//enum Constants: Double {
//    case π = 3.14159
//    case e = 2.71828
//    case φ = 1.61803398874
//    case λ = 1.30357
//}

////對於String和Int類型來說，甚至可以忽略爲枚舉中的case賦值，Swift編譯器也能正常工作。
//// Mercury = 1, Venus = 2, ... Neptune = 8
//enum Planet: Int {
//    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
//}
//
//// North = "North", ... West = "West"
//enum CompassPoint: String {
//    case North, South, East, West
//}

////想要讀取枚舉的值，可以通過rawValue屬性來實現
//let bestHouse = House.Stark
//print(bestHouse.rawValue)

////通過一個已有的raw value來創建一個enum case。
////rawValue構造器是一個可失敗構造器(failable initializer)。構造方法返回值爲可選類型值,因爲有時候傳入的值可能與任意一個case都不匹配。比如Movement(rawValue:42)。
//let rightMovement = Movement(rawValue: 1)

////3.
////嵌套枚舉(Nesting Enums)
////有特定子類型的需求，可以對enum進行嵌套。這樣就允許爲實際的enum中包含其他明確信息的enum。
//enum Character {
//  enum Weapon {
//    case Bow
//    case Sword
//    case Lance
//    case Dagger
//  }
//  enum Helmet {
//    case Wooden
//    case Iron
//    case Diamond
//  }
//  case Thief
//  case Warrior
//  case Knight
//}
//
//let character = Character.Thief
//let weapon = Character.Weapon.Bow
//let helmet = Character.Helmet.Iron

////4.
////包含枚舉(Containing Enums)
////也能夠在structs或classes中內嵌枚舉。
//struct Character {
//   enum CharacterType {
//    case Thief
//    case Warrior
//    case Knight
//  }
//  enum Weapon {
//    case Bow
//    case Sword
//    case Lance
//    case Dagger
//  }
//  let type: CharacterType
//  let weapon: Weapon
//}
//
//let warrior = Character(type: .Warrior, weapon: .Sword)

////5.
////關聯值(Associated Value)
////關聯值是將額外信息附加到 enum case 中的一種極好的方式。EX: 交易引擎存在買和賣兩種不同的交易類型。除此之外每手交易還要制定明確的股票名稱和交易數量:
//enum Trade1 {
//    case Buy
//    case Sell
//}
//
//func trade1(tradeType: String, stock: String,amount: Int){}
////股票的價值和數量顯然從屬於交易，讓他們作爲獨立的參數顯得模棱兩可。
////
////解決方案
//enum Trade2 {
//    case Buy(stock: String,amount: Int)
//    case Sell(stock: String, amount: Int)
//}
//
//func trade2(type: Trade2) {
//    print(type)
//}
//
//let trade = Trade2.Buy(stock: "Apple", amount: 500)

////模式匹配可取得值
//if case let Trade2.Buy(stock, amount) = trade {
//    print("buy \(amount) of \(stock)")
//}
//
////Switch取值
//switch trade {
//case let Trade2.Buy(stock, amount):
//    print("Buy \(amount) of \(stock)")
//
//case let Trade2.Sell(stock, amount):
//    print("Sell \(amount) of \(stock)")
//}

////(元組參數)Tuple as Arguments
////Swift內部相關信息其實是一個元組,所以可以像下面這樣做:
//
//let tp = (stock: "TSLA", amount: 100)
//let trade2 = Trade2.Sell(stock: tp.stock, amount: tp.amount)
//
//if case let Trade2.Sell(stock, amount) = trade {
//    print("buy \(amount) of \(stock)")
//}


////6.
////方法和屬性(Methods and properties)
////在enum中定義方法
//enum Wearable {
//    enum Weight: Int {
//        case Light = 1
//    }
//    enum Armor: Int {
//        case Light = 2
//    }
//
//    case Helmet(weight: Weight,armor: Armor)
//
//    func attributes() -> (weight: Int, armor: Int) {
//        switch self {
//        case .Helmet(let w,let a):
//            return (w.rawValue * 2, a.rawValue * 4)
//        }
//    }
//
//}
//
//let woodenHelmetProps = Wearable.Helmet(weight: .Light, armor: .Light).attributes()
//print(woodenHelmetProps)

//枚舉中的方法爲每一個 enum case 都可以使用。倘若想要在特定情況執行特定代碼的話，需要分支處理或採用switch語句來明確正確的代碼路徑。
//enum Device {
//    case iPad, iPhone, AppleTV, AppleWatch
//
//    func introduced() -> String {
//       switch self {
//       case .AppleTV: return "\(self) was introduced 2006"
//       case .iPhone: return "\(self) was introduced 2007"
//       case .iPad: return "\(self) was introduced 2010"
//       case .AppleWatch: return "\(self) was introduced 2014"
//       }
//    }
//
//}
//print (Device.iPhone.introduced())

////屬性(Properties)
////增加一個存儲屬性到枚舉中不被允許，但能夠創建計算屬性。
//enum Device {
//  case iPad, iPhone
//
//    var year: Int {
//        switch self {
//        case .iPhone: return 2007
//        case .iPad: return 2010
//        }
//    }
//
//}

////靜態方法(Static Methods)
////也能夠爲枚舉創建一些靜態方法(staticmethods)。在這個範例中,我們需要考慮用戶有時將蘋果設備叫錯的情況(比如AppleWatch叫成iWatch)，需要返回一個合適的名稱。
//enum Device {
//    case AppleWatch
//    static func fromSlang(term: String) -> Device? {
//      if term == "iWatch" {
//      return .AppleWatch
//      }
//      return nil
//    }
//}
//print (Device.fromSlang(term: "iWatch") ?? "")
//
////可變方法(Mutating Methods)
////方法可以聲明爲mutating。這樣就允許改變隱藏參數self的case值了。
//enum TriStateSwitch {
//    case Off, Low, High
//
//    mutating func next() {
//        switch self {
//        case .Off:
//            self = .Low
//        case .Low:
//            self = .High
//        case .High:
//            self = .Off
//        }
//    }
//
//}
//var ovenLight = TriStateSwitch.Low
//ovenLight.next()
//// ovenLight 現在等於.On
//ovenLight.next()
//// ovenLight 現在等於.Off

////協議(Protocols)
////Swift允許在枚舉中使用協議(Protocols)和協議擴展(Protocol Extension)。
//protocol CustomStringConvertible {
//  var description: String { get }
//}
//
//enum Trade: CustomStringConvertible {
//   case Buy, Sell
//   var description: String {
//       switch self {
//       case .Buy: return "We're buying something"
//       case .Sell: return "We're selling something"
//       }
//   }
//}
//
//let action = Trade.Buy
//print("this action is \(action.description)")

//一些協議的實現可能需要根據內部狀態來相應處理要求。例如定義一個管理銀行帳號的協議。

//帳戶
protocol AccountCompatible{
    //剩餘資金
    var remainingFunds: Int { get }
    //增加資金
    mutating func addFunds(amount: Int) throws
    //減少資金
    mutating func removeFunds(amount: Int) throws
}

enum Account {
    case Empty
    case Funds(remaining: Int)
    
    enum ErrorType: Error {
        case Overdraft(amount: Int)
    }
}
//爲了保持代碼清爽，可以在enum的協議擴展(protocl extension)中定義必須的協議函數:
extension Account: AccountCompatible {
    
    var remainingFunds: Int {
        switch self {
        case .Empty: return 0
        case .Funds(let remaining): return remaining
        }
    }
    
    mutating func addFunds(amount: Int) throws {
        var newAmount = amount
        
        //將 amount 加上 remaining 等於執行結果的值
        if case let .Funds(remaining) = self {
            newAmount += remaining
        }
        
        //值若小於 0 則只顯示 0
        if newAmount < 0 {
            throw ErrorType.Overdraft(amount: -newAmount)
        } else {
            self = .Funds(remaining: newAmount)
        }
      }

      mutating func removeFunds(amount: Int) throws {
          try self.addFunds(amount: amount * -1)
      }

}

var account = Account.Funds(remaining: 20)
try account.addFunds(amount: 10)
print("add: ")
print(account.remainingFunds)
try account.removeFunds(amount: 15)
print("remove 1: ")
print(account.remainingFunds)
try account.removeFunds(amount: 45)
print("remove 2: ")
print(account.remainingFunds)
