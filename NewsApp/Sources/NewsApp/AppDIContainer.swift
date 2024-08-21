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
  private let baseUrl: URL
  private(set) lazy var navigationController: UINavigationController = {
    let controller = UINavigationController()
    controller.navigationBar.setupBlurNavBar()
    return controller
  }()

  private(set) lazy var dataTransferService: DataTransferService = {
    let networkingConfiguration = ApiDataNetworkConfig(
      baseURL: baseUrl,
      headers: ["Authorization": newsAPIKey]
    )
    let networkingService = NetworkingService(configuration: networkingConfiguration)

    return DataTransferService(networkService: networkingService)
  }()

  init(
    window: UIWindow,
    currentCoordinator: Coordinator? = nil,
    urlString: String
  ) throws {
    self.window = window
    self.currentCoordinator = currentCoordinator
    if
      urlString.isValidUrl(),
      let url = URL(string: urlString) {
      baseUrl = url
    } else {
      throw NewsAppError.noURL
    }
  }
}
