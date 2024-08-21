//
//  NetworkingService.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public protocol NetworkServiceInterface {
  func request(
    endpoint: Requestable,
    resultHandler: @escaping (Result<Data, NetworkError>) -> Void
  )
}

public final class NetworkingService: NetworkServiceInterface {
  private let configuration: NetworkConfigurable

  public init(configuration: NetworkConfigurable) {
    self.configuration = configuration
  }

  public func request(
    endpoint: Requestable,
    resultHandler: @escaping (Result<Data, NetworkError>) -> Void
  ) {
    do {
      let urlRequest = try endpoint.urlRequest(with: configuration)
      return request(request: urlRequest) { result in
        resultHandler(result)
      }
    } catch {
      resultHandler(.failure(NetworkError.urlGeneration))
    }
  }
}

private extension NetworkingService {
  func request(
    request: URLRequest,
    resultHandler: @escaping (Result<Data, NetworkError>) -> Void
  ) {
    let urlTask = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error {
        let networkError = self.resolve(error: error)
        resultHandler(.failure(networkError))
        return
      }
      do {
        guard let data else {
          resultHandler(.failure(.noData))
          return
        }
        let resultData = try self.handleResponse(
          data: data,
          response: response
        )
        resultHandler(.success(resultData))
      } catch {
        let networkError = self.resolve(error: error)
        resultHandler(.failure(networkError))
      }
    }
    urlTask.resume()
  }

  private func resolve(error: Error) -> NetworkError {
    if let networkError = error as? NetworkError {
      return networkError
    } else {
      let code = URLError.Code(rawValue: (error as NSError).code)
      switch code {
      case .notConnectedToInternet, .networkConnectionLost, .cannotConnectToHost, .cannotFindHost:
        return .notConnected
      case .cancelled: return .cancelled
      default: return .generic(error)
      }
    }
  }

  private func handleResponse(data: Data, response: URLResponse?) throws -> Data {
    if let response = response as? HTTPURLResponse {
      if (200...299).contains(response.statusCode) {
        return data
      } else {
        let error = NetworkError.error(statusCode: response.statusCode, data: data)
        throw error
      }
    } else {
      return data
    }
  }
}
