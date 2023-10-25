import Combine
import Foundation

protocol Endpoint {
    var urlRequest: URLRequest? { get }
}

protocol EndpointFectcher {
//    func publisher(for endpoint: Endpoint) -> AnyPublisher<Data, ServiceError>
    func fetch(from endpoint: Endpoint) async -> Result<Data, ServiceError>
}
