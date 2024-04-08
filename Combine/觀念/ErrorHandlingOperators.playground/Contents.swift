import Combine

enum SampleError: Error {
    case operationFailed
}
/*
let numberPublisher = [1, 2, 3, 4, 5, 6].publisher

let transformedPublished = numberPublisher
    .tryMap{ value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        
        return value
    }.catch { error in
        print(error)
        return Just(0)
    }

transformedPublished.sink { value in
    print(value)
}
*/

// replaceError with single value
/*
let numberPublisher = [1, 2, 3, 4, 5, 6].publisher

let transformedPublished = numberPublisher
    .tryMap{ value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        
        return value * 2
    }.replaceError(with: -1)

let cancellable = transformedPublished.sink { value in
    print(value)
}
*/

// replaceError with another publisher
/*
let numberPublisher = [1, 2, 3, 4, 5, 6].publisher
let fallbackPublisher = Just(-1)
let transformedPublished = numberPublisher
    .tryMap{ value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        
        return Just(value)
    }.replaceError(with: fallbackPublisher)

let cancellable = transformedPublished.sink { publisher in
    let _ = publisher.sink { value in
        print(value)
    }
}
*/

// retry

let publisher = PassthroughSubject<Int, Error>()

let retriedPublisher = publisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return value
    }.retry(2)

retriedPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("completed")
    case .failure(let error):
        print(error)
    }
}, receiveValue: { value in
    print(value)
})
                      
publisher.send(1)
publisher.send(3) // failed
publisher.send(4)
publisher.send(3) // failed
publisher.send(3) // failed
// 已超過retry數量 不再執行
publisher.send(5)
publisher.send(6)
