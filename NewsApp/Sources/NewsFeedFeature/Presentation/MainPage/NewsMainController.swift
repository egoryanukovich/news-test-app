//
//  NewsMainController.swift
//
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsUI
import NetworkingService

enum Section {
  case main
}

final class NewsMainController: BaseController {
  var showDetails: ((ArticleModel) -> Void)?

  private typealias DataSource = UITableViewDiffableDataSource<Section, ArticleModel.ID>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ArticleModel.ID>

  private lazy var dataSource = configureDataSource()
  private let viewModel: NewsMainViewModel

  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.contentInset.top = 5.0
    table.backgroundColor = .clear
    table.separatorStyle = .none
    table.allowsSelection = true
    table.delegate = self
    table.register(
      NewsFeedCell.self,
      forCellReuseIdentifier: NewsFeedCell.identifier
    )

    return table
  }()

  init(viewModel: NewsMainViewModel) {
    self.viewModel = viewModel
    super.init()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    configureLayout()
  }

  override func singleDidAppear() {
    super.singleDidAppear()
    fetchNews()
  }
}

private extension NewsMainController {
  func configureView() {
    title = "News"
    tableView.dataSource = dataSource
  }

  func configureLayout() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func configureDataSource() -> DataSource {
    let dataSource = DataSource(
      tableView: tableView
    ) { [weak self] tableView, indexPath, itemIdentifier in
      self?.cell(
        for: tableView,
        indexPath: indexPath,
        item: itemIdentifier
      )
    }
    dataSource.defaultRowAnimation = .fade

    return dataSource
  }

  func cell(
    for tableView: UITableView,
    indexPath: IndexPath,
    item: ArticleModel.ID
  ) -> UITableViewCell {
    guard
      let cell: NewsFeedCell = tableView.dequeueCell(for: indexPath),
      let model = self.viewModel.articles.first(
        where: { $0.id == item
        }
      )
    else {
      return UITableViewCell()
    }
    cell.apply(model)
    return cell
  }

  func fetchNews() {
    showLoadingView()
    viewModel.fetchNewsFeed { [weak self] result in
      self?.handleFetchResult(result)
    }
  }

  func fetchMoreNews() {
    showLoadingView()
    viewModel.fetchMoreNews { [weak self] result in
      self?.handleUpdateResult(result)
    }
  }

  func handleFetchResult(_ result: Result<Void, DataTransferError>) {
    DispatchQueue.main.async {
      self.hideLoadingView()
      switch result {
      case .success:
        self.configureSnapshot()
      case .failure(let error):
        self.showError(error)
      }
    }
  }

  func handleUpdateResult(_ result: Result<[ArticleModel], DataTransferError>) {
    DispatchQueue.main.async {
      self.hideLoadingView()
      switch result {
      case let .success(articles):
        self.updateSnapshot(with: articles)
      case .failure(let error):
        self.showError(error)
      }
    }
  }

  func showError(_ error: DataTransferError) {
    let alertMessage: String
    switch error {
    case .parsing:
      alertMessage = "Something went wrong! Please, try again later."
    case .networkFailure, .resolvedNetworkFailure:
      alertMessage = "Something went wrong! Please, check your internet connection."
    case .api(let model):
      alertMessage = model.message // not correct to print this message to user. Just for test
    }
    showAlert(alertText: "Error", alertMessage: alertMessage)
  }

  func configureSnapshot() {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.articles.map { $0.id }, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  func updateSnapshot(with articles: [ArticleModel]) {
    var snapshot = dataSource.snapshot()
    snapshot.appendItems(
      articles.map { $0.id },
      toSection: .main
    )
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

extension NewsMainController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let article = viewModel.articles[safe: indexPath.row] else { return }
    showDetails?(article)
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.articles.count - 2 {
      fetchMoreNews()
    }
  }
}
