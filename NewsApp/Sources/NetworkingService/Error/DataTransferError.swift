//
//  DataTransferError.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public enum DataTransferError: Error, Equatable {
  public static func == (lhs: DataTransferError, rhs: DataTransferError) -> Bool {
    switch (lhs, rhs) {
    case let (.parsing(lhsError), .parsing(rhsError)):
      return (lhsError as NSError).domain == (rhsError as NSError).domain &&
      (lhsError as NSError).code == (rhsError as NSError).code

    case let (.api(lhsModel), .api(rhsModel)):
      return lhsModel == rhsModel

    case let (.networkFailure(lhsNetworkError), .networkFailure(rhsNetworkError)):
      return lhsNetworkError == rhsNetworkError

    case let (.resolvedNetworkFailure(lhsError), .resolvedNetworkFailure(rhsError)):
      return (lhsError as NSError).domain == (rhsError as NSError).domain &&
      (lhsError as NSError).code == (rhsError as NSError).code

    default:
      return false
    }
  }

  case parsing(Error)
  case api(NewsApiErrorModel)
  case networkFailure(NetworkError)
  case resolvedNetworkFailure(Error)
}

public struct NewsApiErrorModel: Decodable, Equatable {
  let status: String
  public let message: String
}
