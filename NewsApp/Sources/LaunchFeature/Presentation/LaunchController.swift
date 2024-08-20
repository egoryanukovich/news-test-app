//
//  LaunchController.swift
//  
//
//  Created by Egor Yanukovich on 19.08.24.
//

import UIKit
import SnapKit
import NewsUI

final class LaunchController: BaseController {
  var launchFinished: (() -> Void)?

  private lazy var nameLabel: UILabel = {
    let view = UILabel()
    view.textColor = .black
    view.font = .systemFont(
      ofSize: 46.0
    )
    view.textAlignment = .center
    view.text = "News App"

    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    configureLayout()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    launchFinishedAnimation()
  }
}

private extension LaunchController {
  func configureView() {
    view.backgroundColor = .white
  }

  func configureLayout() {
    view.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.leading.greaterThanOrEqualToSuperview().offset(16.0)
      make.top.greaterThanOrEqualToSuperview()
    }
  }

  func launchFinishedAnimation() {
    let animationDuration = 0.5
    UIView.animate(
      withDuration: animationDuration,
      delay: .zero,
      options: .curveEaseInOut
    ) {
      self.view.backgroundColor = .black
    } completion: { isFinished in
      guard isFinished else { return }
      self.launchFinished?()
    }

    UIView.transition(
      with: nameLabel,
      duration: animationDuration,
      options: [.transitionCrossDissolve, .curveEaseInOut]
    ) {
      self.nameLabel.textColor = .white
    }
  }
}
