//
//  NewsFeedRepository.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation
import NetworkingService

public protocol NewsFeedRepository {
  func fetchNewsFeed(
    for topic: String,
    language: String,
    page: Int,
    resultHandler: @escaping (Result<NewsModel, DataTransferError>) -> Void
  )
}

final class DefaultNewsFeedRepository {
  private let dataSource: NewsFeedRemoteDataSource

  init(dataSource: NewsFeedRemoteDataSource) {
    self.dataSource = dataSource
  }
}

extension DefaultNewsFeedRepository: NewsFeedRepository {
  func fetchNewsFeed(
    for topic: String,
    language: String,
    page: Int,
    resultHandler: @escaping (Result<NewsModel, DataTransferError>) -> Void
  ) {
    dataSource.fetchNewsFeed(for: topic, language: language, page: page) { result in
      switch result {
      case let .success(responseModel):
        resultHandler(.success(NewsModel(from: responseModel)))
      case let .failure(error):
        resultHandler(.failure(error))
      }
    }
  }
}
