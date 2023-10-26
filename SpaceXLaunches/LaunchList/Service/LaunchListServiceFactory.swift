import Foundation

enum LaunchListServiceFactory {
    static func make() -> some LaunchListService {
        DefaultLaunchListService(
            fetcher: URLSessionService(),
            jsonDecoder: .init(keyDecodingStrategy: .convertFromSnakeCase)
        )
    }
}
