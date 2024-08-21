//
//  NewsDetailsView.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import UIKit
import NewsUI

final class NewsDetailsView: BaseView {
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit

    return view
  }()

  private lazy var titleLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 20.0, weight: .semibold)
    view.textColor = .white
    view.numberOfLines = 0
    return view
  }()

  private lazy var descriptionLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 16.0)
    view.textColor = .white
    view.numberOfLines = 0

    return view
  }()

  override init() {
    super.init()
    configureLayout()
  }

  func apply(
    _ title: String,
    imageUrl: URL?,
    description: String
  ) {
    titleLabel.text = title
    imageView.sd_setImage(with: imageUrl)
    descriptionLabel.text = description
    // to test scroll
//    descriptionLabel.text = """
// \n\n\n\n\n\n\n\(description)
// \n\n\n\n\n\n\n\(description)
// \n\n\n\n\n\n\n\(description)
// """
  }
}

private extension NewsDetailsView {
  func configureLayout() {
    addSubviews(
      titleLabel,
      imageView,
      descriptionLabel
    )

    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(8.0)
      make.directionalHorizontalEdges.equalToSuperview().inset(16.0)
    }

    imageView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
      make.directionalHorizontalEdges.equalToSuperview().inset(16.0)
      make.height.equalTo(300.0)
    }


    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(4.0)
      make.directionalHorizontalEdges.equalToSuperview().inset(16.0)
      make.bottom.equalToSuperview()
    }
  }
}
