//
//  NewsModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

struct NewsModel {
  let totalResults: Int
  let articles: [ArticleModel]
}

extension NewsModel {
  init(from model: NewsFeedResponseModel) {
    totalResults = model.totalResults
    articles = model.articles.map { ArticleModel(from: $0) }
  }
}
