//
//  NewsFeedResponseModel.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

struct NewsFeedResponseModel: Decodable {
  let status: String
  let totalResults: Int
  let articles: [ArticleResponseModel]
}

struct ArticleResponseModel: Decodable {
  let title: String
  let description: String
  let urlToImage: String?
  let content: String
  let publishedAt: String
//  let source: ArticleSourceResponseModel
}

struct ArticleSourceResponseModel: Decodable {
  let identifier: String
  let name: String

  enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case name
  }
}
