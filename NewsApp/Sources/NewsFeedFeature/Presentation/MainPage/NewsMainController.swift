//
//  NewsMainController.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsUI

final class NewsMainController: BaseController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
}

private extension NewsMainController {
  func configureView() {
    view.backgroundColor = .black
    title = "News"
  }
}
