import Foundation
@testable import SpaceXLaunches

enum EndpointMock: Endpoint {
    case badURL
    case validURL
    
    var urlRequest: URLRequest? {
        switch self {
        case .badURL: return nil
        case .validURL: return URLRequest(url: URL(fileURLWithPath: "validURL"))
        }
    }
}
