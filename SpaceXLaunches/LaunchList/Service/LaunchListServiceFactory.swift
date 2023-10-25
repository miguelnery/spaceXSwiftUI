import Foundation

enum LaunchListServiceFactory {
    static func make() -> some LaunchListService {
        let fetcher = URLSessionService()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return DefaultLaunchListService(fetcher: fetcher, jsonDecoder: decoder)
    }
}
