//
//  NewsMainController.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import UIKit
import NewsUI

final class NewsMainController: BaseController {
  private let viewModel: NewsMainViewModel

  init(viewModel: NewsMainViewModel) {
    self.viewModel = viewModel
    super.init()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }

  override func singleDidAppear() {
    super.singleDidAppear()
    viewModel.fetchNewsFeed()
  }
}

private extension NewsMainController {
  func configureView() {
    view.backgroundColor = .black
    title = "News"
  }
}
