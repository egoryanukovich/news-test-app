//
//  ArticleModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public struct ArticleModel: ArticleMainScreenModel, Hashable, Identifiable {
  public let id: UUID
  let title: String
  let description: String
  let imageUrl: URL?
  let content: String
  let publishedAt: String

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension ArticleModel {
  init(from model: ArticleResponseModel) {
    id = UUID()
    title = model.title
    description = model.description
    self.imageUrl = URL(string: model.urlToImage ?? "")
    content = model.content
    publishedAt = model.publishedAt
  }
}

extension ArticleModel {
  static var mock: ArticleModel {
    ArticleModel(
      id: UUID(),
      title: "mock title",
      description: "mock descr",
      imageUrl: nil,
      content: "mock content",
      publishedAt: "some date. Currently unused"
    )
  }
}
