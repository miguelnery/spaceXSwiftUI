import Foundation

protocol LaunchListService {
    func fetchLaunches() async -> Result<[SpaceXLaunch], ServiceError>
    func fetchRockets() async -> Result<[SpaceXRocket], ServiceError>
}

final class DefaultLaunchListService<Fetcher: EndpointFectcher> {
    private let fetcher: Fetcher
    private let jsonDecoder: JSONDecoder
    
    init(fetcher: Fetcher,
         jsonDecoder: JSONDecoder) {
        self.fetcher = fetcher
        self.jsonDecoder = jsonDecoder
    }
}

// MARK: - LaunchListService
extension DefaultLaunchListService: LaunchListService {
    func fetchLaunches() async -> Result<[SpaceXLaunch], ServiceError> {
        return await fetch(from: .launches)
    }
    
    func fetchRockets() async -> Result<[SpaceXRocket], ServiceError> {
        return await fetch(from: .rockets)
    }
}

// MARK: - Helpers
extension DefaultLaunchListService {
    private func fetch<T: Decodable>(from endpoint: SpaceXEndpoint) async -> Result<T, ServiceError> {
        switch await fetcher.fetch(from: endpoint) {
        case .success(let data):
            return decode(data: data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T, ServiceError> {
        if let decoded = try? jsonDecoder.decode(T.self, from: data) {
            return .success(decoded)
        } else {
            return .failure(.decode)
        }
    }
}
