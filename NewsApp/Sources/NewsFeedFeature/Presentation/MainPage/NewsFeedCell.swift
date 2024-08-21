//
//  NewsFeedCell.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import UIKit
import NewsUI
import SDWebImage

final class NewsFeedCell: UITableViewCell {
  private lazy var newsImageView: UIImageView = {
    let view = UIImageView()

    return view
  }()

  private lazy var titleLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 16.0, weight: .semibold)
    view.textColor = .white
    view.numberOfLines = 2

    return view
  }()

  private lazy var descriptionLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 14.0)
    view.textColor = .white.withAlphaComponent(0.7)
    view.numberOfLines = 2

    return view
  }()
  private lazy var separatorLine: BaseView = {
    let view = BaseView()
    view.backgroundColor = .gray

    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureLayout()
    backgroundColor = .clear
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func apply(_ model: ArticleMainScreenModel) {
    titleLabel.text = model.title
    descriptionLabel.text = model.descriptionWithoutNewLines
    newsImageView.sd_setImage(with: model.imageUrl)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    descriptionLabel.text = nil
    newsImageView.sd_cancelCurrentImageLoad()
    newsImageView.image = nil
  }
}

private extension NewsFeedCell {
  func configureLayout() {
    contentView.addSubviews(
      newsImageView,
      titleLabel,
      descriptionLabel,
      separatorLine
    )

    newsImageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(8.0)
      make.directionalHorizontalEdges.equalToSuperview().inset(16.0)
      make.height.equalTo(120.0)
    }

    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(newsImageView.snp.bottom).offset(4.0)
      make.directionalHorizontalEdges.equalToSuperview().inset(16.0)
    }

    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
      make.directionalHorizontalEdges.equalToSuperview().inset(16.0)
    }
    separatorLine.snp.makeConstraints { make in
      make.top.equalTo(descriptionLabel.snp.bottom).offset(8.0)
      make.height.equalTo(1.0 / UIScreen.main.scale)
      make.directionalHorizontalEdges.equalToSuperview().inset(16.0)
      make.bottom.equalToSuperview()
    }
  }
}
