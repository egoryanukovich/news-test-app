//
//  CollectionExt.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import Foundation

public extension Collection {
  /// Returns the element at the specified index if it exists, otherwise nil.
  subscript (safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}
