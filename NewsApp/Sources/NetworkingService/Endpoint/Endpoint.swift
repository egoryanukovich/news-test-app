//
//  Endpoint.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public class Endpoint<R>: ResponseRequestable {
  public typealias Response = R

  public var path: String
  public var isFullPath: Bool
  public var method: HTTPMethodType
  public var headerParameters: [String: String]
  public var queryParametersEncodable: Encodable?
  public var queryParameters: [String: Any]

  public init(
    path: String,
    isFullPath: Bool = false,
    method: HTTPMethodType,
    headerParameters: [String: String] = [:],
    queryParametersEncodable: Encodable? = nil,
    queryParameters: [String: Any] = [:]
  ) {
    self.path = path
    self.isFullPath = isFullPath
    self.method = method
    self.headerParameters = headerParameters
    self.queryParametersEncodable = queryParametersEncodable
    self.queryParameters = queryParameters
  }
}

extension Requestable {
  public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
    let url = try self.url(with: config)
    var urlRequest = URLRequest(url: url)
    var allHeaders: [String: String] = config.headers
    headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }

    urlRequest.httpMethod = method.rawValue
    urlRequest.allHTTPHeaderFields = allHeaders
    return urlRequest
  }

  private func url(with config: NetworkConfigurable) throws -> URL {
    let baseURL = config.baseURL.absoluteString.last != "/"
    ? config.baseURL.absoluteString + "/"
    : config.baseURL.absoluteString
    let endpoint = isFullPath ? path : baseURL.appending(path)

    guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
    var urlQueryItems: [URLQueryItem] = []

    let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
    queryParameters.forEach {
      urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
    }
    config.queryParameters.forEach {
      urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
    }
    urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
    guard let url = urlComponents.url else { throw RequestGenerationError.components }
    return url
  }

  private func encodeBody(
    bodyParamaters: [String: Any]
  ) -> Data? {
    try? JSONSerialization.data(withJSONObject: bodyParamaters)
  }
}

private extension Dictionary {
  var queryString: String {
    self.map { "\($0.key)=\($0.value)" }
      .joined(separator: "&")
      .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
  }
}

private extension Encodable {
  func toDictionary() throws -> [String: Any]? {
    let data = try JSONEncoder().encode(self)
    let jsonData = try JSONSerialization.jsonObject(with: data)
    return jsonData as? [String: Any]
  }
}
