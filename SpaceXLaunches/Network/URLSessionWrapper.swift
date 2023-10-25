import Combine
import Foundation

protocol URLSessionWrapper {
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
final class DefaultURLSessionWrapper {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension DefaultURLSessionWrapper: URLSessionWrapper {
    func data(from url: URL, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        try await urlSession.data(from: url)
    }
}
