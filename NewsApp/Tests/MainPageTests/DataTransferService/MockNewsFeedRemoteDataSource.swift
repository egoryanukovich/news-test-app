//
//  MockNewsFeedRemoteDataSource.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

@testable import NewsFeedFeature
@testable import NetworkingService

class MockNewsFeedRemoteDataSource: NewsFeedRemoteDataSource {
  var fetchNewsFeedCalled = false
  var fetchResult: Result<NewsFeedResponseModel, DataTransferError>?
  
  func fetchNewsFeed(
    for topic: String,
    language: String,
    page: Int,
    resultHandler: @escaping (Result<NewsFeedResponseModel, DataTransferError>) -> Void
  ) {
    fetchNewsFeedCalled = true
    if let result = fetchResult {
      resultHandler(result)
    }
  }
}
