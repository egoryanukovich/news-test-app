//
//  AppDIContainer.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsCore
import NewsUI
import NetworkingService

final class AppDIContainer {
  let window: UIWindow
  var currentCoordinator: Coordinator?
  let newsAPIKey = "e7736929385449b69620d8fb9762f1e0"
  private(set) lazy var navigationController: UINavigationController = {
    let controller = UINavigationController()
    controller.navigationBar.setupTransparentNavBar()
    return controller
  }()

  private(set) lazy var dataTransferService: DataTransferService = {
    let networkingConfiguration = ApiDataNetworkConfig(
      baseURL: URL(
        string: "https://newsapi.org/v2/"
      )!,
      headers: ["Authorization": newsAPIKey]
    )
    let networkingService = NetworkingService(configuration: networkingConfiguration)

    return DataTransferService(networkService: networkingService)
  }()

  init(
    window: UIWindow,
    currentCoordinator: Coordinator? = nil
  ) {
    self.window = window
    self.currentCoordinator = currentCoordinator
  }
}
