
import Foundation

/*
 抽像工廠模式注重在產品的抽象關係
 用一個工廠介面來產生一系列相關的物件，但實際建立哪些物件由實作工廠的子類別來實現
*/

// 抽象產品
protocol MedicineProduct {
    func getProduct(p_stName: String, p_stFormula: String) -> String
}

// 產品 1mg*10s裝
class OneMgTenProduct : MedicineProduct {
    func getProduct(p_stName: String, p_stFormula: String) -> String {
        return "\(p_stName) 1mg*10s, Formula: \(p_stFormula)"
    }
}

// 產品 1mg*20s裝
class OneMgTwentyProduct : MedicineProduct {
    func getProduct(p_stName: String, p_stFormula: String) -> String {
        return "\(p_stName) 1mg*20s, Formula: \(p_stFormula)"
    }
}

// 抽象工廠
protocol AbstractMedicineFactory {
    func createProduct() -> MedicineProduct
}

// 工廠 1mg*10s裝
class OneMgTenFactory : AbstractMedicineFactory {
    static let sharedInstance: OneMgTenFactory = OneMgTenFactory()
    func createProduct() -> MedicineProduct {
        return OneMgTenProduct()
    }
}

// 工廠 1mg*20s裝
class OneMgTwentyFactory : AbstractMedicineFactory {
    static let sharedInstance: OneMgTwentyFactory = OneMgTwentyFactory()
    func createProduct() -> MedicineProduct {
        return OneMgTwentyProduct()
    }
}

let tenMgProduct: MedicineProduct = OneMgTenFactory.sharedInstance.createProduct()
let twentyMgProduct: MedicineProduct = OneMgTwentyFactory.sharedInstance.createProduct()

// 生產 1mg*10s裝 藥物
print(tenMgProduct.getProduct(p_stName: "Aspirin", p_stFormula: "C9H8O4"))
print(tenMgProduct.getProduct(p_stName: "Paracetamol", p_stFormula: "C8H9NO2"))

// 生產 1mg*20s裝 藥物
print(twentyMgProduct.getProduct(p_stName: "Aspirin", p_stFormula: "C9H8O4"))
print(twentyMgProduct.getProduct(p_stName: "Paracetamol", p_stFormula: "C8H9NO2"))

// 假如想增加1mg*30s裝 生產線、只需增加工廠和產品
