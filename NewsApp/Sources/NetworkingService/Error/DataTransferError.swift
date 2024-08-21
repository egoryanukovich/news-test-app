//
//  DataTransferError.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public enum DataTransferError: Error {
  case parsing(Error)
  case api(NewsApiErrorModel)
  case networkFailure(NetworkError)
  case resolvedNetworkFailure(Error)
}

public struct NewsApiErrorModel: Decodable {
  let status: String
  public let message: String
}
