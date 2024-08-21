//
//  NetworkError.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public enum NetworkError: Error, Equatable {
  public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    switch (lhs, rhs) {
    case let (.error(lhsStatusCode, lhsData), .error(rhsStatusCode, rhsData)):
      return lhsStatusCode == rhsStatusCode && lhsData == rhsData

    case (.notConnected, .notConnected),
      (.cancelled, .cancelled),
      (.urlGeneration, .urlGeneration),
      (.noData, .noData):
      return true

    case let (.generic(lhsError), .generic(rhsError)):
      return (lhsError as NSError).domain == (rhsError as NSError).domain &&
      (lhsError as NSError).code == (rhsError as NSError).code
    default:
      return false
    }
  }

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
