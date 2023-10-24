import Combine
import XCTest
@testable import SpaceXLaunches

final class URLSessionServiceTests: XCTestCase {
    let urlSessionWrapperMock = URLSessionWrapperMock()
    lazy var sut = URLSessionService(urlSession: urlSessionWrapperMock)
    var cancellables = Set<AnyCancellable>()
    
    func test_publisherForEndpoint_WhenURLIsInvalid_ShouldPublishBadURL() {
        let expectation = expectation(description: "sut publisherForEndpoint")
        sut
            .publisher(for: EndpointMock.badURL)
            .sink { completion in
                if case .failure(let failure) = completion {
                    XCTAssertEqual(failure, ServiceError.badURL)
                } else { XCTFail("Failure expected") }
                expectation.fulfill()
            } receiveValue: { _ in
                XCTFail("Failure expected")
            }.store(in: &cancellables)
        waitForExpectations(timeout: 1)
    }
    
    func test_publisherForEndpoint_WhenItFails_ShouldPublishURLError() {
        let expectation = expectation(description: "sut publisherForEndpoint")
        let expectedError = URLError(.badServerResponse)
        urlSessionWrapperMock.dataTaskPublisherImpl = { _ in
            Fail<_, URLError>(error: expectedError)
                .eraseToAnyPublisher()
        }
        sut
            .publisher(for: EndpointMock.validURL)
            .sink { completion in
                if case .failure(let failure) = completion {
                    XCTAssertEqual(failure, .urlError(expectedError))
                } else { XCTFail("Failure expected") }
                expectation.fulfill()
            } receiveValue: { _ in
                XCTFail("Failure expected")
            }.store(in: &cancellables)
        waitForExpectations(timeout: 1)
    }
    
    func test_publisherForEndpoint_WhenItSucceeds_ShouldPublishData() throws {
        let expectation = expectation(description: "sut publisherForEndpoint")
        let expectedData = try XCTUnwrap("someModel".data(using: .utf16))
        urlSessionWrapperMock.dataTaskPublisherImpl = { _ in
            Just((expectedData, .init()))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
        sut
            .publisher(for: EndpointMock.validURL)
            .sink { completion in
                if case .failure(_) = completion {
                    XCTFail("Value expected")
                }
                expectation.fulfill()
            } receiveValue: { value in
                XCTAssertEqual(value, expectedData)
            }.store(in: &cancellables)
        waitForExpectations(timeout: 1)
    }
}
