//
//  NewsFeedRemoteDataSource.swift
//
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation
import NetworkingService

protocol NewsFeedRemoteDataSource {
  func fetchNewsFeed(
    for topic: String,
    language: String,
    page: Int,
    resultHandler: @escaping (Result<NewsFeedResponseModel, DataTransferError>) -> Void
  )
}

final class DefaultNewsFeedRemoteDataSource: NewsFeedRemoteDataSource {
  private let dataTransferService: DataTransferServiceInterface

  init(dataTransferService: DataTransferServiceInterface) {
    self.dataTransferService = dataTransferService
  }

  func fetchNewsFeed(
    for topic: String,
    language: String,
    page: Int,
    resultHandler: @escaping (
      Result<NewsFeedResponseModel, DataTransferError>
    ) -> Void
  ) {
    let endpoint = Endpoint<NewsFeedResponseModel>(
      path: "everything",
      method: .get,
      queryParameters: [
        "q": topic,
        "language": language,
        "page": page
      ])

    dataTransferService.request(with: endpoint) { result in
      resultHandler(result)
    }
  }
}
