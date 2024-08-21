//
//  NewsModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public struct NewsModel {
  let totalResults: Int
  let articles: [ArticleModel]
}

extension NewsModel {
  init(from model: NewsFeedResponseModel) {
    totalResults = model.totalResults
    articles = model.articles
      .filter { $0.urlToImage != nil }
      .map { ArticleModel(from: $0) }
  }
}
