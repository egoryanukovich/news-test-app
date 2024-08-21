//
//  UITableViewCellExt.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import UIKit

public extension UITableView {
  func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
    dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
  }
}

public extension UITableViewCell {
  static var identifier: String {
    return String(describing: self)
  }
}
