//
//  MockNewsFeedRepository.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

@testable import NewsFeedFeature
@testable import NetworkingService

final class MockNewsFeedRepository: NewsFeedRepository {
  var result: Result<NewsModel, DataTransferError>?
  var fetchNewsFeedCalled = false


  func fetchNewsFeed(
    for topic: String,
    language: String,
    page: Int,
    resultHandler: @escaping (Result<NewsModel, DataTransferError>) -> Void
  ) {
    fetchNewsFeedCalled = true
    if let result = result {
      resultHandler(result)
    }
  }
}
