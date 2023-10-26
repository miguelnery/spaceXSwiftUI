import XCTest
@testable import SpaceXLaunches

final class DefaultLaunchListServiceTests: XCTestCase {
    let fetcherMock = EndpointFetcherMock()
    lazy var sut: LaunchListService = DefaultLaunchListService(
        fetcher: fetcherMock,
        jsonDecoder: .init(keyDecodingStrategy: .convertFromSnakeCase)
    )
    
    func test_fetchLaunches_WhenFetcherFail_ShouldFail() async {
        let expectedError = ServiceError.badURL
        fetcherMock.fetchFromEndpointImpl = { _ in .failure(expectedError) }
        let result = await sut.fetchLaunches()
        XCTAssertEqual(result, .failure(expectedError))
    }
    
    func test_fetchLaunches_WhenFetcherSucceeds_WhenDecodeFails_ShouldFailWithDecode() async throws {
        let wrongData = try XCTUnwrap("wrong data".data(using: .utf16))
        fetcherMock.fetchFromEndpointImpl = { _ in .success(wrongData) }
        let result = await sut.fetchLaunches()
        XCTAssertEqual(result, .failure(.decode))
    }
    
    func test_fetchLaunches_WhenFetcherSucceeds_ShouldSucceed() async throws {
        let expectedLaunch = [SpaceXLaunch.stub()]
        let encodedLaunch = try XCTUnwrap(JSONEncoder().encode(expectedLaunch))
        fetcherMock.fetchFromEndpointImpl = { _ in .success(encodedLaunch) }
        let result = await sut.fetchLaunches()
        XCTAssertEqual(result, .success(expectedLaunch))
    }
}
