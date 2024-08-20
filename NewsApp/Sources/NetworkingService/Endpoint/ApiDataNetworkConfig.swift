//
//  ApiDataNetworkConfig.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public struct ApiDataNetworkConfig: NetworkConfigurable {
  public let baseURL: URL
  public let headers: [String: String]
  public let queryParameters: [String: String]

  public init(
    baseURL: URL,
    headers: [String: String] = [:],
    queryParameters: [String: String] = [:]
  ) {
    self.baseURL = baseURL
    self.headers = headers
    self.queryParameters = queryParameters
  }
}
