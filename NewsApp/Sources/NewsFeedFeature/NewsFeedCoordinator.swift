//
//  NewsFeedCoordinator.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsCore

public final class NewsFeedCoordinator: Coordinator {
  public var finishAction: (() -> Void)?
  private let navigationController: UINavigationController

  public init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }

  public func start() {
    buildMainScreen()
  }
}

@MainActor
private extension NewsFeedCoordinator {
  func buildMainScreen() {
    let controller = NewsMainController()

    navigationController.setViewControllers(
      [controller],
      animated: false
    )
  }
}
