//
//  NewsMainController.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsUI
import NetworkingService

final class NewsMainController: BaseController {
  var showDetails: ((ArticleModel) -> Void)?

  private let viewModel: NewsMainViewModel

  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.contentInset.top = 5.0
    table.backgroundColor = .clear
    table.separatorStyle = .none
    table.allowsSelection = true
    table.dataSource = self
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
  }

  func configureLayout() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  func fetchNews() {
    showLoadingView()
    viewModel.fetchNewsFeed { [weak self] result in
      DispatchQueue.main.async {
        self?.hideLoadingView()
        switch result {
        case .success:
          self?.tableView.reloadData()
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
          self?.tableView.reloadData()
        case let .failure(error):
          self?.showError(error)
        }
      }
    }
  }

  // TODO: show error
  func showError(_ error: DataTransferError) {
    print("EROROR")
  }
}

extension NewsMainController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.articles.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell: NewsFeedCell = tableView.dequeueCell(for: indexPath),
      let model = viewModel.articles[safe: indexPath.row]
    else { return UITableViewCell() }
    cell.apply(model)
    return cell
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
