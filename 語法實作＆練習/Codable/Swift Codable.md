## Swift Codable

---

### define

解析 JSON 資料，內建類別為 `NSJSONSerialization`，可以讓輕易地將 JSON 格式的資料轉換為物件（Object）。



### 建立 JSON 資料模型

範例 JSON API ：https://api.kivaws.org/v1/loans/newest.json

先建立一個貸款模型的類別。不需要載入 JSON，建立一個單獨的類別（或者是結構）來儲存資料模型，`Loan` 類別代表了在 KivaLoan App中的貸款資訊，並用來儲存由 Kiva.org 所回傳的貸款資訊。將需要的回傳資料建模即可，不需要將所有回傳資料建模。

```swift
struct Loan: Hashable {

    var name: String = ""
    var country: String = ""
    var use: String = ""
    var amount: Int = 0

}
```



### 使用 Kiva API 取得貸款資料

```swift
private let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
private var loans = [Loan]()

func getLatestLoans() {
    guard let loanUrl = URL(string: kivaLoanURL) else {
        return
    }

    let request = URLRequest(url: loanUrl)
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

        if let error = error {
            print(error)
            return
        }

        // 解析 JSON 資料
        if let data = data {
            self.loans = self.parseJsonData(data: data)
        }
    })

    task.resume()
}
```

### 使用JSONSerialization轉換JSON資料

```swift
func parseJsonData(data: Data) -> [Loan] {

    var loans = [Loan]()

    do {
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary

        // 解析 JSON 資料
        let jsonLoans = jsonResult?["loans"] as! [AnyObject]
        for jsonLoan in jsonLoans {
            var loan = Loan()
            loan.name = jsonLoan["name"] as! String
            loan.amount = jsonLoan["loan_amount"] as! Int
            loan.use = jsonLoan["use"] as! String
            let location = jsonLoan["location"] as! [String:AnyObject]
            loan.country = location["country"] as! String
            loans.append(loan)
        }

    } catch {
        print(error)
    }

    return loans
}
```



### 即可在 loans 中取得回傳的值

```swift
//--------------print(self.loans[0])
Loan(name: "Jackson", 
country: "Kenya", 
use: "to access high-quality farm inputs for 0.5 acres of maize, in addition to advice and insurance, optimizing for increased productivity and profit.", 
amount: 125)
//--------------print(self.loans[0].name)
Jackson
//--------------print(self.loans[0].country)
Kenya
```

