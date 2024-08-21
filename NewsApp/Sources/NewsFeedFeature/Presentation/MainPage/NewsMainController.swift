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
  typealias DataSource = UITableViewDiffableDataSource<Section, ArticleModel.ID>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ArticleModel.ID>

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

  func configureDataSource() -> DataSource {
    let datasource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
      guard
        let cell: NewsFeedCell = tableView.dequeueCell(for: indexPath),
        let model = self.viewModel.articles[safe: indexPath.row]
      else { return UITableViewCell() }
      cell.apply(model)
      return cell
    }

    datasource.defaultRowAnimation = .fade
    return datasource
  }

  func fetchNews() {
    showLoadingView()
    viewModel.fetchNewsFeed { [weak self] result in
      DispatchQueue.main.async {
        self?.hideLoadingView()
        switch result {
        case .success:
          self?.updateSnapshot()
        case let .failure(error):
          self?.showError(error)
        }
      }
    }
  }

  func fetchMoreNews() {
    showLoadingView()
    viewModel.fetchMoreNews { [weak self] result in
      DispatchQueue.main.async {
        self?.hideLoadingView()
        switch result {
        case .success:
          self?.updateSnapshot()
        case let .failure(error):
          self?.showError(error)
        }
      }
    }
  }

  func showError(_ error: DataTransferError) {
    switch error {
    case .parsing:
      showAlert(
        alertText: "Something went wrong!",
        alertMessage: "Please, try again later"
      )
    case .networkFailure, .resolvedNetworkFailure:
      showAlert(
        alertText: "Something went wrong!",
        alertMessage: "Please, check your internet connection"
      )
    case let .api(model):
      showAlert(
        alertText: "Something went wrong!",
        alertMessage: model.message // not correct to print this message to user. Just for test
      )
    }
  }

  func updateSnapshot() {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.articles.map { $0.id }, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

extension NewsMainController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    guard
      let article = viewModel.articles[safe: indexPath.row]
    else { return }
    showDetails?(article)
  }

  func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    if indexPath.row == viewModel.articles.count - 2 {
      fetchMoreNews()
    }
  }
}
