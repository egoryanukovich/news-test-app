//
//  BaseController.swift
//  
//
//  Created by Egor Yanukovich on 19.08.24.
//

import UIKit

open class BaseController: UIViewController {
  private var willAppearOnce = false
  private var didAppearOnce = false

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

  open override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  // MARK: - Lifecycle
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if !willAppearOnce {
      singleWillAppear()
      willAppearOnce = true
    }
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if !didAppearOnce {
      singleDidAppear()
      didAppearOnce = true
    }
  }

  open func singleWillAppear() {}
  open func singleDidAppear() {}

  @MainActor
  public func showLoadingView() {
    let loadingView = LoadingView()
    loadingView.tag = Constants.loadingViewTag

    view.addSubview(loadingView)

    loadingView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.size.equalToSuperview()
    }
    view.isUserInteractionEnabled = false
  }

  @MainActor
  public func hideLoadingView() {
    view.subviews.forEach { subview in
      if subview.tag == Constants.loadingViewTag {
        subview.removeFromSuperview()
      }
    }
    view.isUserInteractionEnabled = true
  }
}

private extension BaseController {
  func configureView() {
    view.backgroundColor = .black
  }
}
