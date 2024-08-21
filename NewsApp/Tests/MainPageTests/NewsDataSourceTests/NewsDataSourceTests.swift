//
//  NewsDataSourceTests.swift
//
//
//  Created by Egor Yanukovich on 21.08.24.
//

import XCTest
@testable import NewsFeedFeature

final class NewsDataSourceTests: XCTestCase {
  var tableView: UITableView!
  var dataSource: NewsDataSource!

  override func setUp() {
    super.setUp()
    tableView = UITableView()
    dataSource = NewsDataSource(tableView: tableView) { _, _, _ in
      return UITableViewCell()
    }
  }

  override func tearDown() {
    tableView = nil
    dataSource = nil
    super.tearDown()
  }

  func testConfigureSnapshot() {
    let articles = [
      ArticleModel.mock,
      ArticleModel.mock
    ]

    dataSource.configureSnapshot(with: articles)

    let snapshot = dataSource.snapshot()
    XCTAssertEqual(snapshot.numberOfItems, articles.count, "Snapshot should have the correct number of items")
    XCTAssertEqual(snapshot.itemIdentifiers, articles.map { $0.id }, "Snapshot should contain correct item identifiers")
    XCTAssertEqual(snapshot.numberOfSections, 1, "Snapshot should contain one section")
    XCTAssertEqual(snapshot.sectionIdentifiers, [.main], "Snapshot should contain the main section")
  }

  func testUpdateSnapshot() {
    let initialArticles = [
      ArticleModel.mock
    ]
    dataSource.configureSnapshot(with: initialArticles)

    let newArticles = [
      ArticleModel.mock,
      ArticleModel.mock
    ]

    dataSource.updateSnapshot(with: newArticles)

    let snapshot = dataSource.snapshot()
    XCTAssertEqual(snapshot.numberOfItems, initialArticles.count + newArticles.count, "Snapshot should have the correct number of items after update")
    XCTAssertTrue(snapshot.itemIdentifiers.contains(newArticles[0].id), "Snapshot should contain new item identifiers")
  }

  func testInitialSnapshotState() {
    let snapshot = dataSource.snapshot()

    XCTAssertEqual(snapshot.numberOfItems, 0, "Snapshot should initially have no items")
    XCTAssertEqual(snapshot.numberOfSections, 0, "Snapshot should initially have no sections")
  }
}
