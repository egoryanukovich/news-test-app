//
//  NewsFeedCoordinator.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsCore
import NetworkingService

public final class NewsFeedCoordinator: Coordinator {
  public var finishAction: (() -> Void)?
  private let navigationController: UINavigationController
  private let dataTransferService: DataTransferService
  private lazy var feedRepository: NewsFeedRepository = {
    let repository = DefaultNewsFeedRepository(
      dataSource: DefaultNewsFeedRemoteDataSource(
        dataTransferService: dataTransferService
      )
    )

    return repository
  }()

  public init(
    navigationController: UINavigationController,
    dataTransferService: DataTransferService
  ) {
    self.navigationController = navigationController
    self.dataTransferService = dataTransferService
  }

  public func start() {
    buildMainScreen()
  }
}

@MainActor
private extension NewsFeedCoordinator {
  func buildMainScreen() {
    let viewModel = NewsMainViewModel(
      repository: feedRepository
    )
    let controller = NewsMainController(viewModel: viewModel)
    controller.showDetails = { [weak self] article in
      self?.showDetails(for: article)
    }
    navigationController.setViewControllers(
      [controller],
      animated: false
    )
  }

  func showDetails(for article: ArticleModel) {
    let controller = NewsDetailsController(articleModel: article)
    navigationController.pushViewController(
      controller,
      animated: true
    )
  }
}
