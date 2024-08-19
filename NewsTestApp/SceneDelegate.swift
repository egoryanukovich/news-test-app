//
//  SceneDelegate.swift
//  NewsTestApp
//
//  Created by Egor Yanukovich on 19.08.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = windowScene.keyWindow
  }
}
