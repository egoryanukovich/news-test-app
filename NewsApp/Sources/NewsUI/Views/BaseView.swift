//
//  BaseView.swift
//  
//
//  Created by Egor Yanukovich on 19.08.24.
//

import UIKit

open class BaseView: UIView {
  // MARK: - Init
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }

  public init() {
    super.init(frame: .zero)
  }

  @available(*, unavailable,
    message: "Loading this view from a nib is unsupported"
  )
  public required init?(coder: NSCoder) {
    fatalError("Loading this view from a nib is unsupported")
  }
}
