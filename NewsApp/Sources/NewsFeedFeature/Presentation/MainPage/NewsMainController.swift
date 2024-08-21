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
  private let viewModel: NewsMainViewModel

  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.contentInset.top = 5.0
    table.backgroundColor = .clear
    table.separatorStyle = .none
    table.dataSource = self
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

  private var news: NewsModel?
  override func singleDidAppear() {
    super.singleDidAppear()
    showLoadingView()
    viewModel.fetchNewsFeed { [weak self] result in
      DispatchQueue.main.async {
        self?.hideLoadingView()
        switch result {
        case let .success(news):
          self?.news = news
          self?.tableView.reloadData()
        case let .failure(error):
          self?.showError(error)
        }
      }
    }
  }
}

private extension NewsMainController {
  func configureView() {
    view.backgroundColor = .black
    title = "News"
  }

  func configureLayout() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  // TODO: show error
  func showError(_ error: DataTransferError) {
    print("EROROR")
  }
}

extension NewsMainController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    news?.articles.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell: NewsFeedCell = tableView.dequeueCell(for: indexPath),
      let model = news?.articles[safe: indexPath.row]
    else { return UITableViewCell() }
    cell.apply(model)
    return cell
  }
}
