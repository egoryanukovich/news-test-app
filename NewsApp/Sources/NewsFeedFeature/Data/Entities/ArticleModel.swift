//
//  ArticleModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

struct ArticleModel {
  let title: String
  let description: String
  let imageUrl: URL?
  let content: String
  let publishedAt: String
}

extension ArticleModel {
  init(from model: ArticleResponseModel) {
    title = model.title
    description = model.description
    imageUrl = URL(string: model.urlToImage ?? "")
    content = model.content
    publishedAt = model.publishedAt
  }
}
