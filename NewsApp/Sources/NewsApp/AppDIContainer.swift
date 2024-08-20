//
//  AppDIContainer.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsCore

final class AppDIContainer {
  let window: UIWindow
  var currentCoordinator: Coordinator?
  private(set) lazy var navigationController = UINavigationController()

  init(
    window: UIWindow,
    currentCoordinator: Coordinator? = nil
  ) {
    self.window = window
    self.currentCoordinator = currentCoordinator
  }
}
