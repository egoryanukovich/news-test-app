//
//  DefaultNewsFeedRemoteDataSourceTests.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import XCTest
@testable import NewsFeedFeature
@testable import NetworkingService

final class DefaultNewsFeedRemoteDataSourceTests: XCTestCase {
  var dataSource: DefaultNewsFeedRemoteDataSource!
  var mockDataTransferService: MockDataTransferService!

  override func setUp() {
    super.setUp()
    mockDataTransferService = MockDataTransferService()
    dataSource = DefaultNewsFeedRemoteDataSource(dataTransferService: mockDataTransferService)
  }

  override func tearDown() {
    mockDataTransferService = nil
    dataSource = nil
    super.tearDown()
  }

  func testFetchNewsFeedSuccess() {
    let expectedResponse = NewsFeedResponseModel.mock
    mockDataTransferService.requestResult = .success(expectedResponse)

    let expectation = self.expectation(description: "Completion handler should be called")

    dataSource.fetchNewsFeed(for: "TestTopic", language: "en", page: 1) { result in
      switch result {
      case .success(let responseModel):
        XCTAssertNotNil(responseModel)
        expectation.fulfill()
      case .failure:
        XCTFail("Expected success but got failure")
      }
    }

    waitForExpectations(timeout: 1.0, handler: nil)
    XCTAssertTrue(mockDataTransferService.requestCalled)
  }

  func testFetchNewsFeedFailure() {
    mockDataTransferService.requestResult = .failure(.networkFailure(.notConnected))

    let expectation = self.expectation(description: "Completion handler should be called")

    dataSource.fetchNewsFeed(for: "TestTopic", language: "en", page: 1) { result in
      switch result {
      case .success:
        XCTFail("Expected failure but got success")
      case .failure(let error):
        XCTAssertEqual(error, .networkFailure(.notConnected))
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 1.0, handler: nil)
    XCTAssertTrue(mockDataTransferService.requestCalled)
  }
}
