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
  private var totalPages = 1
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
          if self?.articles.isEmpty == true {
            self?.articles = news.articles
          } else {
            self?.articles.append(contentsOf: news.articles)
          }
          self?.calculateTotalPages(totalItems: news.totalResults)
          resultHandler(.success(()))
        case let .failure(error):
          resultHandler(.failure(error))
        }
      }
    }
  }

  func fetchMoreNews(
    resultHandler: @escaping (Result<Void, DataTransferError>) -> Void = { _ in }
  ) {
    guard checkIfFetchMorePossible() else { return }
    currentPage += 1
    fetchNewsFeed { result in
      resultHandler(result)
    }
  }

  @discardableResult
  private func checkIfFetchMorePossible() -> Bool {
    currentPage + 1 <= totalPages
  }

  private func calculateTotalPages(
    totalItems: Int,
    itemsPerPage: Int = 100
  ) {
    totalPages = (totalItems - articles.count + itemsPerPage - 1) / itemsPerPage
  }
}
