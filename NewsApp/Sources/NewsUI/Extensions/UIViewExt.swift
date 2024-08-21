//
//  UIViewExt.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import UIKit

public extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach { addSubview($0) }
  }
}
