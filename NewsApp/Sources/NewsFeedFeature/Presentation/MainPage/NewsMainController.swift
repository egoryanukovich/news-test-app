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


  init(viewModel: NewsMainViewModel) {
    self.viewModel = viewModel
    super.init()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }

  override func singleDidAppear() {
    super.singleDidAppear()
    showLoadingView()
    viewModel.fetchNewsFeed { [weak self] result in
      DispatchQueue.main.async {
        self?.hideLoadingView()
        switch result {
        case let .success(news):
          print(news.totalResults == news.articles.count)
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

  // TODO: show error
  func showError(_ error: DataTransferError) {
    print("EROROR")
  }
}
