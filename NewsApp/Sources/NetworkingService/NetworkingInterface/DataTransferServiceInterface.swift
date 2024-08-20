//
//  DataTransferServiceInterface.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public protocol DataTransferServiceInterface {
  func request<T: Decodable, E: ResponseRequestable>(
    with endpoint: E,
    resultHandler: @escaping (Result<T, DataTransferError>) -> Void
  ) where T == E.Response
}
