//
//  NewsMainViewModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation
import NetworkingService

final class NewsMainViewModel {
  private let repository: NewsFeedRepository
  private(set) var currentPage = 1
  private(set) var articles: [ArticleModel] = []

  init(repository: NewsFeedRepository) {
    self.repository = repository
  }

  func fetchNewsFeed(
    resultHandler: @escaping (Result<Void, DataTransferError>) -> Void = { _ in }
  ) {
    repository.fetchNewsFeed(
      for: "Meta OR Apple OR Netflix OR Google OR Amazon",
      language: "en",
      page: currentPage
    ) { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case let .success(news):
          self?.articles = news.articles
          resultHandler(.success(()))
        case let .failure(error):
          resultHandler(.failure(error))
        }
      }
    }
  }
}
