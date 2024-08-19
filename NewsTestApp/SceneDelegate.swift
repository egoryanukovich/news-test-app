//
//  SceneDelegate.swift
//  NewsTestApp
//
//  Created by Egor Yanukovich on 19.08.24.
//

import UIKit
import NewsApp

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    guard let window else { return }
    let viewController = ViewController()
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
}
