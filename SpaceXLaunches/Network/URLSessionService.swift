import Combine
import Foundation

final class URLSessionService<SessionWrapper: URLSessionWrapperProtocol> {
    private let urlSession: SessionWrapper
    
    init(urlSession: SessionWrapper) {
        self.urlSession = urlSession
    }
}

extension URLSessionService: EndpointFectcher {
    func publisher(for endpoint: Endpoint) -> AnyPublisher<Data, ServiceError> {
        guard let url = endpoint.urlRequest?.url else {
            return Fail<_, ServiceError>(error: .badURL)
                .eraseToAnyPublisher()
        }
        return urlSession
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError { ServiceError.urlError($0) }
            .eraseToAnyPublisher()
    }
}

enum ServiceError: Error, Equatable {
    case badURL
    case urlError(URLError)
}
