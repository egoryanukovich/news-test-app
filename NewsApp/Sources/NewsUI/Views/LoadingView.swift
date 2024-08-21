//
//  LoadingView.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import UIKit
import SnapKit

public final class LoadingView: BaseView {
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    view.color = .white

    return view
  }()

  public override init() {
    super.init()
    backgroundColor = .clear
    configureLayout()
    configureView()
  }
}

private extension LoadingView {
  func configureView() {
    activityIndicator.startAnimating()
  }

  func configureLayout() {
    addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.size.equalTo(
        CGSize(
          width: 50.0,
          height: 50.0
        )
      )
    }
  }
}
