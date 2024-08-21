//
//  DefaultNewsFeedRepositoryTests.swift
//
//
//  Created by Egor Yanukovich on 21.08.24.
//

import XCTest
@testable import NewsFeedFeature
@testable import NetworkingService

final class DefaultNewsFeedRepositoryTests: XCTestCase {
  var repository: DefaultNewsFeedRepository!
  var mockRemoteDataSource: MockNewsFeedRemoteDataSource!

  override func setUp() {
    super.setUp()
    mockRemoteDataSource = MockNewsFeedRemoteDataSource()
    repository = DefaultNewsFeedRepository(dataSource: mockRemoteDataSource)
  }

  override func tearDown() {
    mockRemoteDataSource = nil
    repository = nil
    super.tearDown()
  }

  func testFetchNewsFeedSuccess() {
    let expectedModel = NewsFeedResponseModel.mock
    mockRemoteDataSource.fetchResult = .success(expectedModel)

    let expectation = self.expectation(description: "Completion handler should be called")

    repository.fetchNewsFeed(for: "TestTopic", language: "en", page: 1) { result in
      switch result {
      case .success(let newsModel):
        XCTAssertNotNil(newsModel)
        expectation.fulfill()
      case .failure:
        XCTFail("Expected success but got failure")
      }
    }

    waitForExpectations(timeout: 1.0, handler: nil)
    XCTAssertTrue(mockRemoteDataSource.fetchNewsFeedCalled)
  }

  func testFetchNewsFeedFailure() {
    mockRemoteDataSource.fetchResult = .failure(.networkFailure(.notConnected))

    let expectation = self.expectation(description: "Completion handler should be called")

    repository.fetchNewsFeed(for: "TestTopic", language: "en", page: 1) { result in
      switch result {
      case .success:
        XCTFail("Expected failure but got success")
      case .failure(let error):
        XCTAssertEqual(error, .networkFailure(.notConnected))
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 1.0, handler: nil)
    XCTAssertTrue(mockRemoteDataSource.fetchNewsFeedCalled)
  }
}
