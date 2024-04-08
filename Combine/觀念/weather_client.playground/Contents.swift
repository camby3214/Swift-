import Combine
import UIKit

class WeatherClient {
    let updates = PassthroughSubject<Int, Never>()
    
    func fetchWeather() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){ [weak self] in
            self?.updates.send(Int.random(in: 32...100))
        }
    }
}

let client = WeatherClient()

let cancellable = client.updates.sink { value in
    print(value)
}

client.fetchWeather()
