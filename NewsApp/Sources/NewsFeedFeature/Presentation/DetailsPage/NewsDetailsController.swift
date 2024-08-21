//
//  NewsDetailsController.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import UIKit
import NewsUI

final class NewsDetailsController: BaseController {
  private let articleModel: ArticleModel

  private lazy var scrollView = UIScrollView()

  private lazy var contentView = NewsDetailsView()

  init(articleModel: ArticleModel) {
    self.articleModel = articleModel
    super.init()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    configureLayout()
  }
}

private extension NewsDetailsController {
  func configureView() {
    contentView.apply(
      articleModel.title,
      imageUrl: articleModel.imageUrl,
      description: articleModel.description
    )
  }

  func configureLayout() {
    scrollView.addSubview(contentView)
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }

    contentView.snp.makeConstraints { make in
      make.top.directionalHorizontalEdges.equalToSuperview()
      make.bottom.lessThanOrEqualToSuperview()
      make.width.equalToSuperview()
    }
  }
}
