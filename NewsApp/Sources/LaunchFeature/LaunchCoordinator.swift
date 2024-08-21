//
//  LaunchCoordinator.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsCore

public final class LaunchCoordinator: Coordinator {
  public var finishAction: (() -> Void)?
  private let navigationController: UINavigationController

  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }


  public func start() {
    let launchController = LaunchController()
    launchController.launchFinished = { [weak self] in
      self?.finishAction?()
    }

    navigationController.setViewControllers(
      [launchController],
      animated: true
    )
  }
}
