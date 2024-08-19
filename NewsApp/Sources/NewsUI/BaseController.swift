//
//  BaseController.swift
//  
//
//  Created by Egor Yanukovich on 19.08.24.
//

import UIKit

open class BaseController: UIViewController {
  // MARK: - Init
  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(
    *,
    unavailable,
    message: "Loading this view controller from a nib is unsupported"
  )
  public override init(
    nibName nibNameOrNil: String?,
    bundle nibBundleOrNil: Bundle?
  ) {
    super.init(
      nibName: nibNameOrNil,
      bundle: nibBundleOrNil
    )
  }

  @available(
    *,
    unavailable,
    message: "Loading this view controller from a nib is unsupported"
  )
  public required init?(
    coder: NSCoder
  ) {
    fatalError(
      "Loading this view controller from a nib is unsupported"
    )
  }
}
