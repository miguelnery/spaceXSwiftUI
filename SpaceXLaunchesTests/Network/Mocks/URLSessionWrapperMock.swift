import Combine
import Foundation
import XCTest
@testable import SpaceXLaunches

final class URLSessionWrapperMock: URLSessionWrapperProtocol {
    var dataTaskPublisherImpl: ((URL) -> AnyDataTaskPublisher)?
    func dataTaskPublisher(for url: URL) -> AnyDataTaskPublisher {
        guard let impl = dataTaskPublisherImpl else {
            XCTFail("Must provide implemententation before calling this method.")
            return Fail<(data: Data, response: URLResponse), URLError>(error: .init(.unknown))
                .eraseToAnyPublisher()
        }
        return impl(url)
    }
}
