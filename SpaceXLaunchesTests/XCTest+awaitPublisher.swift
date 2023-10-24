import Combine
import XCTest

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 1,
        expectationDescription: String,
        onSinkCompletion: @escaping ((Subscribers.Completion<T.Failure>) -> Void),
        onSinkReceiveValue: @escaping ((T.Output) -> Void)
    ) -> AnyCancellable {
        let expectation = expectation(description: expectationDescription)
        let cancellable = publisher.sink { completion in
            onSinkCompletion(completion)
            expectation.fulfill()
        } receiveValue: { value in
            onSinkReceiveValue(value)
        }
        waitForExpectations(timeout: timeout)
        return cancellable
    }
}
