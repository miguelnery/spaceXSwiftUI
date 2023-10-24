import Combine
import Foundation

protocol URLSessionWrapperProtocol {
    typealias AnyDataTaskPublisher = AnyPublisher<(data: Data, response: URLResponse), URLError>
    
    func dataTaskPublisher(for url: URL) -> AnyDataTaskPublisher
}

final class URLSessionWrapper {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension URLSessionWrapper: URLSessionWrapperProtocol {
    func dataTaskPublisher(for url: URL) -> AnyDataTaskPublisher {
        urlSession
            .dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }
}
