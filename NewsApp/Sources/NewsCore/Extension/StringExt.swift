//
//  StringExt.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import Foundation

public extension String {
  func isValidUrl() -> Bool {
    let regex = "((http|https|ftp)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: self)
  }
}
