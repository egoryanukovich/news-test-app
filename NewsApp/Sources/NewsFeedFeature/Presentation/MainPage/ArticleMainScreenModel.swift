//
//  ArticleMainScreenModel.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import Foundation

protocol ArticleMainScreenModel {
  var title: String { get }
  var description: String { get }
  var imageUrl: URL { get }
}

extension ArticleMainScreenModel {
  var descriptionWithoutNewLines: String {
    description.filter { !$0.isNewline }
  }
}
