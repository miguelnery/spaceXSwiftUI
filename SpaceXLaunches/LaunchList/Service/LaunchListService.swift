import Foundation

protocol LaunchListService {
    func fetchLaunches() async -> Result<[SpaceXLaunch], ServiceError>
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

extension DefaultLaunchListService: LaunchListService {
    func fetchLaunches() async -> Result<[SpaceXLaunch], ServiceError> {
        switch await fetcher.fetch(from: SpaceXEndpoint.launches) {
        case .success(let data):
            return decode(data: data)
        case .failure(let error):
            return .failure(error)
        }
    }
}

// MARK: - Helpers
extension DefaultLaunchListService {
    private func decode(data: Data) -> Result<[SpaceXLaunch], ServiceError> {
        if let launches = try? jsonDecoder.decode([SpaceXLaunch].self, from: data) {
            return .success(launches)
        } else {
            return .failure(.decode)
        }
    }
}
