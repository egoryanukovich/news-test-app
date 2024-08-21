//
//  NetworkConfigurable.swift
//  
//
//  Created by Egor Yanukovich on 20.08.24.
//

import Foundation

public protocol NetworkConfigurable {
  var baseURL: URL { get }

  /// URLRequest.allHTTPHeaderFields
  var headers: [String: String] { get }

  /// URLComponents.queryItems:
  /// 1: Global query Parameters should be Here. For All requests
  /// &language=en
  var queryParameters: [String: String] { get }
}
