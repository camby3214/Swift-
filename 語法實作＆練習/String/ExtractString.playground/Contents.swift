import UIKit

var url = "http://camby.com.tw?a=1&b=2&c=3"

if let array = url.components(separatedBy: "?").last {
    var array1 = array.components(separatedBy: "&")
    var result = [String: String]()
    
    for element in array1 {
        let arr = element.components(separatedBy: "=")
        
        if let a = arr.first {
            result[a] = arr.last
        }
        
        
    }
    print(result["a"] ?? "")
    
}


