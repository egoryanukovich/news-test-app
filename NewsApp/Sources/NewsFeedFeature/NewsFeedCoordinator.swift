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

    navigationController.setViewControllers(
      [controller],
      animated: false
    )
  }
}
