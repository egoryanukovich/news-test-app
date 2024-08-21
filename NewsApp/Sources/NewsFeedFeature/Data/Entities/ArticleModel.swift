//
//  ArticleModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

struct ArticleModel: ArticleMainScreenModel {
  let title: String
  let description: String
  let imageUrl: URL
  let content: String
  let publishedAt: String
}

extension ArticleModel {
  init(from model: ArticleResponseModel, imageUrl: URL) {
    title = model.title
    description = model.description
    self.imageUrl = imageUrl
    content = model.content
    publishedAt = model.publishedAt
  }
}
