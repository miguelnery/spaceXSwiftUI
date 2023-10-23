import Combine
import Foundation

protocol Endpoint {
    var urlRequest: URLRequest? { get }
}

protocol EndpointFectcher {
    func publisher(for endpoint: Endpoint) -> AnyPublisher<Data, ServiceError>
}
