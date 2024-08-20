//
//  DataTransferService.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public final class DataTransferService {
  private let networkService: NetworkServiceInterface

  public init(networkService: NetworkServiceInterface) {
    self.networkService = networkService
  }

  private func resolve(networkError error: NetworkError) -> DataTransferError {
    .networkFailure(error)
  }

  private func decode<T: Decodable>(data: Data) throws -> T {
    do {
      let result = try JSONDecoder().decode(T.self, from: data)
      return result
    } catch {
      throw DataTransferError.parsing(error)
    }
  }

  public func request<T, E>(
    with endpoint: E,
    resultHandler: @escaping (Result<T, DataTransferError>) -> Void
  ) where T: Decodable, T == E.Response, E: ResponseRequestable {
    networkService.request(endpoint: endpoint) { result in
      switch result {
      case let .success(data):
        do {
          let result: T = try self.decode(data: data)
          resultHandler(.success(result))
        } catch {
          if let transferError = error as? DataTransferError {
            resultHandler(.failure(transferError))
          } else {
            resultHandler(
              .failure(
                DataTransferError.resolvedNetworkFailure(
                  error
                )
              )
            )
          }
        }
      case let .failure(error):
        let transferError = self.resolve(networkError: error)
        // TODO: handle errors
        resultHandler(.failure(transferError))
      }
    }
  }
}
