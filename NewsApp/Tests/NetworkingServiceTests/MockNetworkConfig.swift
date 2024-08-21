//
//  MockNetworkConfig.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import Foundation
@testable import NetworkingService

struct MockNetworkConfig: NetworkConfigurable {
  var baseURL: URL
  var headers: [String: String] = [:]
  var queryParameters: [String: String] = [:]
}
