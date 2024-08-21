import UIKit
import LaunchFeature
import NewsFeedFeature

@MainActor
final public class Module {
  private let diContainer: AppDIContainer

  public init(window: UIWindow, urlString: String) throws {
    diContainer = try AppDIContainer(window: window, urlString: urlString)
    configureWindow()
  }

  public func launchApp() {
    showLaunchScreen()
  }
}

@MainActor
private extension Module {
  func configureWindow() {
    diContainer.window.rootViewController = diContainer.navigationController
    diContainer.window.makeKeyAndVisible()
  }

  func showLaunchScreen() {
    let coordinator = LaunchCoordinator(
      navigationController: diContainer.navigationController
    )
    coordinator.finishAction = { [weak self] in
      self?.diContainer.currentCoordinator = nil
      self?.showNewsFeed()
    }
    coordinator.start()
    diContainer.currentCoordinator = coordinator
  }

  func showNewsFeed() {
    let coordinator = NewsFeedCoordinator(
      navigationController: diContainer.navigationController,
      dataTransferService: diContainer.dataTransferService
    )
    coordinator.finishAction = { [weak self] in
      self?.diContainer.currentCoordinator = nil
    }
    coordinator.start()
    diContainer.currentCoordinator = coordinator
  }
}
