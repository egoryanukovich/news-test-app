//
//  NewsDataSource.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import UIKit

public enum Section {
  case main
}

public typealias DataSource = UITableViewDiffableDataSource<Section, ArticleModel.ID>

public final class NewsDataSource: DataSource {
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ArticleModel.ID>

  func configureSnapshot(with articles: [ArticleModel]) {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(articles.map { $0.id }, toSection: .main)
    self.apply(snapshot, animatingDifferences: true)
  }

  func updateSnapshot(with articles: [ArticleModel]) {
    var snapshot = self.snapshot()
    snapshot.appendItems(articles.map { $0.id }, toSection: .main)
    self.apply(snapshot, animatingDifferences: true)
  }
}
