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
  private var newsAppModule: NewsApp.Module?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    guard let window else { return }
    do {
      newsAppModule = try NewsApp.Module(
        window: window,
        urlString: "invalid_url_string"
      )
      newsAppModule?.launchApp()
    } catch {
      print("Check url correctness")
    }
  }
}
