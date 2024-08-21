//
//  UINavigationBarExt.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit

public extension UINavigationBar {
  func setupBlurNavBar() {
    tintColor = .white
    titleTextAttributes = [
      .foregroundColor: UIColor.white,
      .font: UIFont.systemFont(ofSize: 20.0, weight: .bold)
    ]
  }
}
