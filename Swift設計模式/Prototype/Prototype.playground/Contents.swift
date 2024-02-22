import Foundation

// 定義結構型別 ReferenceTypeShop
struct ReferenceTypeShop {
    var name: String // 商店名稱
    var place: String // 商店地點
    
    // 初始化方法
    init(name: String, place: String) {
        self.name = name
        self.place = place
    }
    
    // 打印商店詳細信息
    func printDetails() {
        print("\(name) is at \(place)")
    }
}

// 創建 ReferenceTypeShop 實例 referenceShopC
let referenceShopC = ReferenceTypeShop(name: "Shop C", place: "West")

// 將 referenceShopC 賦值給 referenceShopD，這裡是值的複製
var referenceShopD = referenceShopC
referenceShopD.name = "Shop D" // 修改 referenceShopD 的 name
referenceShopD.place = "East" // 修改 referenceShopD 的 place

// 打印 referenceShopC 的詳細信息
referenceShopC.printDetails() // 預期輸出：Shop C is at West
// 打印 referenceShopD 的詳細信息
referenceShopD.printDetails() // 預期輸出：Shop D is at East
