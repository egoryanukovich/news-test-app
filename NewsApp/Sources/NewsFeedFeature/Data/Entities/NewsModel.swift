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
    var resultArticles: [ArticleModel] = []
    model.articles.forEach { article in
      if let imageURL = URL(string: article.urlToImage ?? "") {
        resultArticles.append(ArticleModel(from: article, imageUrl: imageURL))
      }
    }
    articles = resultArticles
  }
}
