//
//  NewsMainViewModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation


final class NewsMainViewModel {
  private let repository: NewsFeedRepository
  private(set) var page = 1

  init(repository: NewsFeedRepository) {
    self.repository = repository
  }

  func fetchNewsFeed() {
    repository.fetchNewsFeed(
      for: "Meta OR Apple OR Netflix OR Google OR Amazon",
      language: "en",
      page: page
    ) { [weak self] result in
      switch result {
      case let .success(news):
        self?.page = news.totalResults
        print(news.totalResults)
      case let .failure(error):
        print(error)
      }
    }
  }
}
