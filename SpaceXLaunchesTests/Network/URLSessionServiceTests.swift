import Combine
import XCTest
@testable import SpaceXLaunches

final class URLSessionServiceTests: XCTestCase {
    let urlSessionWrapperMock = URLSessionWrapperMock()
    lazy var sut = URLSessionService(urlSession: urlSessionWrapperMock)
    var cancellables = Set<AnyCancellable>()
    
    func test_publisherForEndpoint_WhenURLIsInvalid_ShouldPublishBadURL() {
        awaitPublisher(
            sut.publisher(for: EndpointMock.badURL),
            expectationDescription: "sut publisherForEndpoint") { completion in
                if case .failure(let failure) = completion {
                    XCTAssertEqual(failure, ServiceError.badURL)
                } else { XCTFail("Failure expected") }
            } onSinkReceiveValue: { value in
                XCTFail("Failure expected")
            }.store(in: &cancellables)
    }
    
    func test_publisherForEndpoint_WhenItFails_ShouldPublishURLError() {
        let expectedError = URLError(.badServerResponse)
        urlSessionWrapperMock.dataTaskPublisherImpl = { _ in
            Fail<_, URLError>(error: expectedError)
                .eraseToAnyPublisher()
        }
        awaitPublisher(
            sut.publisher(for: EndpointMock.validURL),
            expectationDescription: "sut publisherForEndpoint") { completion in
                if case .failure(let failure) = completion {
                    XCTAssertEqual(failure, .urlError(expectedError))
                } else { XCTFail("Failure expected") }
            } onSinkReceiveValue: { value in
                XCTFail("Failure expected")
            }.store(in: &cancellables)
    }
    
    func test_publisherForEndpoint_WhenItSucceeds_ShouldPublishData() throws {
        let expectedData = try XCTUnwrap("someModel".data(using: .utf16))
        urlSessionWrapperMock.dataTaskPublisherImpl = { _ in
            Just((expectedData, .init()))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
        awaitPublisher(
            sut.publisher(for: EndpointMock.validURL),
            expectationDescription: "sut publisherForEndpoint") { completion in
                if case .failure(_) = completion {
                    XCTFail("Value expected")
                }
            } onSinkReceiveValue: { value in
                XCTAssertEqual(value, expectedData)
            }.store(in: &cancellables)
    }
}

