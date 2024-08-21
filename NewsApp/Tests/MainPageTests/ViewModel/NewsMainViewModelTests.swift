//
//  NewsMainViewModelTests.swift
//
//
//  Created by Egor Yanukovich on 21.08.24.
//

import XCTest
@testable import NewsFeedFeature
@testable import NetworkingService

final class NewsMainViewModelTests: XCTestCase {
  var mockRepository: MockNewsFeedRepository!
  var viewModel: NewsMainViewModel!

  override func setUp() {
    super.setUp()
    mockRepository = MockNewsFeedRepository()
    viewModel = NewsMainViewModel(repository: mockRepository)
  }

  override func tearDown() {
    mockRepository = nil
    viewModel = nil
    super.tearDown()
  }

  func testFetchNewsFeedSuccess() {
    let articles: [ArticleModel] = [.mock, .mock, .mock]
    let response = NewsModel(totalResults: 200, articles: articles)
    mockRepository.result = .success(response)

    let expectation = self.expectation(description: "Fetch News Feed Success")
    viewModel.fetchNewsFeed { result in
      if case .success = result {
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 1, handler: nil)

    XCTAssertEqual(viewModel.articles, articles)
    XCTAssertEqual(viewModel.currentPage, 1)
    XCTAssertEqual(viewModel.totalPages, 2)
  }

  func testFetchNewsFeedFailure() {
    let error = DataTransferError.networkFailure(.noData)
    mockRepository.result = .failure(error)

    let expectation = self.expectation(description: "Fetch News Feed Failure")
    viewModel.fetchNewsFeed { result in
      if case .failure(let returnedError) = result {
        XCTAssertEqual(returnedError, error)
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 1, handler: nil)

    XCTAssertTrue(viewModel.articles.isEmpty)
    XCTAssertEqual(viewModel.currentPage, 1)
  }

  func testFetchMoreNewsSuccess() {
    // Given
    let articles: [ArticleModel] = [.mock, .mock, .mock]
    let response = NewsModel(totalResults: 200, articles: articles)
    mockRepository.result = .success(response)

    let expectation = self.expectation(description: "Fetch More News Success")
    viewModel.fetchNewsFeed { [weak self] result in
      if case .success = result {
        self?.viewModel.fetchMoreNews { result in
          if case .success = result {
            expectation.fulfill()
          }
        }
      }
    }

    waitForExpectations(timeout: 1, handler: nil)

    XCTAssertEqual(viewModel.articles.count, 6)
    XCTAssertEqual(viewModel.currentPage, 2)
  }

  func testFetchMoreNewsNoMorePages() {
    let articles: [ArticleModel] = [.mock, .mock, .mock]
    let response = NewsModel(totalResults: 3, articles: articles)
    mockRepository.result = .success(response)

    let expectation = self.expectation(description: "Fetch More News Success")
    viewModel.fetchNewsFeed { [weak self] result in
      if case .success = result {
        self?.viewModel.fetchMoreNews()
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 1, handler: nil)

    XCTAssertEqual(viewModel.currentPage, 1) // No change
  }

  func testIsFetchMorePossible() {
    let articles: [ArticleModel] = [.mock, .mock, .mock]
    let response = NewsModel(totalResults: 200, articles: articles)
    mockRepository.result = .success(response)

    let expectation = self.expectation(description: "Fetch More News Success")
    viewModel.fetchNewsFeed { result in
      if case .success = result {
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 1, handler: nil)

    let result = viewModel.isFetchMorePossible

    XCTAssertTrue(result)
  }

  func testIsFetchMorePossible_NoMorePages() {
    let articles: [ArticleModel] = [.mock, .mock, .mock]
    let response = NewsModel(totalResults: 3, articles: articles)
    mockRepository.result = .success(response)

    let expectation = self.expectation(description: "Fetch More News Success")
    viewModel.fetchNewsFeed { result in
      if case .success = result {
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 1, handler: nil)
    let result = viewModel.isFetchMorePossible

    XCTAssertFalse(result)
  }
}
