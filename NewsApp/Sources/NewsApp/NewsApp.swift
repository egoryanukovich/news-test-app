import UIKit
import NewsCore
import LaunchFeature

@MainActor
final public class Module {
  private let diContainer: AppDIContainer

  public init(window: UIWindow) {
    diContainer = AppDIContainer(window: window)
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
    }
    coordinator.start()
    diContainer.currentCoordinator = coordinator
  }
}
