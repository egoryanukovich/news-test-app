//
//  NetworkError.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public enum NetworkError: Error {
  case error(statusCode: Int, data: Data)
  case notConnected
  case cancelled
  case generic(Error)
  case urlGeneration
  case noData
}

extension NetworkError {
  public var isNotFoundError: Bool {
    return hasStatusCode(404)
  }

  public func hasStatusCode(_ codeError: Int) -> Bool {
    switch self {
    case let .error(code, _):
      return code == codeError
    default: return false
    }
  }
}
