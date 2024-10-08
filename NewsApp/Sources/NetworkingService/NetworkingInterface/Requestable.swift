//
//  Requestable.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public protocol Requestable {
  var path: String { get }
  var isFullPath: Bool { get }
  var method: HTTPMethodType { get }
  var headerParameters: [String: String] { get }
  var queryParametersEncodable: Encodable? { get }
  var queryParameters: [String: Any] { get }

  func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

public enum HTTPMethodType: String {
  case get     = "GET"
  case head    = "HEAD"
  case post    = "POST"
  case put     = "PUT"
  case patch   = "PATCH"
  case delete  = "DELETE"
}

public protocol ResponseRequestable: Requestable {
  associatedtype Response
}

public enum RequestGenerationError: Error {
  case components
}
