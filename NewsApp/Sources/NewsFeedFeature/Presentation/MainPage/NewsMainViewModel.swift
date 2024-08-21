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
  private var isFetchMorePossible: Bool {
    currentPage < totalPages
  }

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
        self?.handleFetchResult(result, resultHandler: resultHandler)
      }
    }
  }

  func fetchMoreNews(
    resultHandler: @escaping (Result<Void, DataTransferError>) -> Void = { _ in }
  ) {
    guard isFetchMorePossible else { return }
    currentPage += 1
    fetchNewsFeed(resultHandler: resultHandler)
  }

  private func handleFetchResult(
    _ result: Result<NewsModel, DataTransferError>,
    resultHandler: @escaping (Result<Void, DataTransferError>) -> Void
  ) {
    switch result {
    case let .success(news):
      updateArticles(with: news.articles)
      calculateTotalPages(totalItems: news.totalResults)
      resultHandler(.success(()))
    case let .failure(error):
      resultHandler(.failure(error))
    }
  }

  private func updateArticles(with newArticles: [ArticleModel]) {
    if articles.isEmpty {
      articles = newArticles
    } else {
      articles.append(contentsOf: newArticles)
    }
  }

  private func calculateTotalPages(
    totalItems: Int,
    itemsPerPage: Int = 100
  ) {
    totalPages = (totalItems - articles.count + itemsPerPage - 1) / itemsPerPage
  }
}
