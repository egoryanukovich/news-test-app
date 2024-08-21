//
//  ArticleModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

struct ArticleModel: ArticleMainScreenModel, Hashable, Identifiable {
  let id: UUID
  let title: String
  let description: String
  let imageUrl: URL
  let content: String
  let publishedAt: String

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension ArticleModel {
  init(from model: ArticleResponseModel, imageUrl: URL) {
    id = UUID()
    title = model.title
    description = model.description
    self.imageUrl = imageUrl
    content = model.content
    publishedAt = model.publishedAt
  }
}
