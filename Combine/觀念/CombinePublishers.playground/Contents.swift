import UIKit
import Combine


/*
let publisher = Just("Hello")

let cancellable = publisher.sink { value in
    print(value)
}
// cancellable is not required
cancellable.cancel()
*/

let numbersPublisher = [1,2,3,4,5,6].publisher
let doublePublisher = numbersPublisher.map { $0 * 2 }
let cancellable = doublePublisher.sink { value in
        print(value)
}
