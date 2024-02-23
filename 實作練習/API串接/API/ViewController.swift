//
//  ViewController.swift
//  API
//
//  Created by 李韋辰 on 2022/3/17.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData(city: "Taipei")
    }
    func getWeatherData(city:String) {
        //網址
        let address = "https://api.openweathermap.org/data/2.5/weather?"
        
            //設定參數
            if let url = URL(string: address + "q=\(city)" + "&appid=" + APIKeys.apikey) {
                // GET
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    // 假如錯誤存在，則印出錯誤訊息（ 例如：網路斷線等等... ）
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                      // 取得 response 和 data
                    } else if let response = response as? HTTPURLResponse,let data = data {
                        // 將 response 轉成 HTTPURLResponse 可以查看 statusCode 檢查錯誤（ ex: 404 可能是網址錯誤等等... ）
                        print("Status code: \(response.statusCode)")
                        // 創建 JSONDecoder 實例來解析我們的 json 檔
                        let decoder = JSONDecoder()
                        // decode 從 json 解碼，返回一個指定類型的值，這個類型必須符合 Decodable 協議
                        if let weatherData = try? decoder.decode(CurrentWeatherData.self, from: data) {
                            print("============== Weather data ==============")
                            print("城市名稱: \(weatherData.name)")
                            print("經緯度: (\(weatherData.coord.lon),\(weatherData.coord.lat))")
                            print("溫度: \(String(format: "%.0f", weatherData.main.temp - 273))°C")
                            print("描述: \(weatherData.weather[0].description)")
                            print("============== Weather data ==============")
                            
                        }
                    }
                    }.resume()
            } else {
                print("Invalid URL.")
            }
    }


}

