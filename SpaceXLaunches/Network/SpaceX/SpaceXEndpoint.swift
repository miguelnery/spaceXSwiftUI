import Foundation

enum SpaceXEndpoint {
    case company
    case launches
    case rockets
    
    private var path: String {
        switch self {
        case .company: return "/company"
        case .launches: return "/launches"
        case .rockets: return "/rockets"
        }
    }
    
    private var basePath: String { "https://api.spacexdata.com/v4" }
    
    private func makeURL() -> URL? { URL(string: basePath + path) }
}

extension SpaceXEndpoint: Endpoint {
    var urlRequest: URLRequest? {
        guard let url = makeURL() else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}
