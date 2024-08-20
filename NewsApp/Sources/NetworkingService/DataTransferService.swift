//
//  DataTransferService.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public final class DataTransferService: DataTransferServiceInterface {
  private let networkService: NetworkServiceInterface

  // MARK: - Init
  public init(networkService: NetworkServiceInterface) {
    self.networkService = networkService
  }

  // MARK: - Public methods
  public func request<T: Decodable, E: ResponseRequestable>(
    with endpoint: E,
    resultHandler: @escaping (Result<T, DataTransferError>) -> Void
  ) where T == E.Response {
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

  // MARK: - Private methods
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
}
