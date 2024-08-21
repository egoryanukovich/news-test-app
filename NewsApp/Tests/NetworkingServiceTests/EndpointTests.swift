//
//  EndpointTests.swift
//
//
//  Created by Egor Yanukovich on 21.08.24.
//

import XCTest
@testable import NetworkingService

final class EndpointTests: XCTestCase {
  func testEndpointInitializationWithDefaults() {
    let endpoint = Endpoint<Void>(path: "/test", method: .get)

    XCTAssertEqual(endpoint.path, "/test")
    XCTAssertEqual(endpoint.isFullPath, false)
    XCTAssertEqual(endpoint.method, .get)
    XCTAssertTrue(endpoint.headerParameters.isEmpty)
    XCTAssertNil(endpoint.queryParametersEncodable)
    XCTAssertTrue(endpoint.queryParameters.isEmpty)
  }

  func testEndpointInitializationWithCustomValues() {
    let headers = ["Authorization": "Bearer token"]
    let queryParams = ["key": "value"]

    let endpoint = Endpoint<Void>(
      path: "/custom",
      isFullPath: true,
      method: .post,
      headerParameters: headers,
      queryParameters: queryParams
    )

    XCTAssertEqual(endpoint.path, "/custom")
    XCTAssertEqual(endpoint.isFullPath, true)
    XCTAssertEqual(endpoint.method, .post)
    XCTAssertEqual(endpoint.headerParameters, headers)
    XCTAssertNil(endpoint.queryParametersEncodable)
    XCTAssertEqual(endpoint.queryParameters as NSDictionary, queryParams as NSDictionary)
  }

  func testURLGenerationWithBaseURLAndPath() throws {
    let config = MockNetworkConfig(baseURL: URL(string: "https://api.example.com")!)
    let endpoint = Endpoint<Void>(path: "v1/test", method: .get)

    let urlRequest = try endpoint.urlRequest(with: config)

    XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.example.com/v1/test")
  }

  func testURLGenerationWithFullPath() throws {
    let config = MockNetworkConfig(baseURL: URL(string: "https://api.example.com")!)
    let endpoint = Endpoint<Void>(path: "https://fullpath.example.com/test", isFullPath: true, method: .get)

    let urlRequest = try endpoint.urlRequest(with: config)

    XCTAssertEqual(urlRequest.url?.absoluteString, "https://fullpath.example.com/test")
  }

  func testURLGenerationWithQueryParameters() throws {
    let config = MockNetworkConfig(baseURL: URL(string: "https://api.example.com")!)
    let queryParams = ["key": "value", "another_key": "another_value"]
    let endpoint = Endpoint<Void>(path: "v1/test", method: .get, queryParameters: queryParams)

    let urlRequest = try endpoint.urlRequest(with: config)

    XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.example.com/v1/test?key=value&another_key=another_value")
  }

  func testURLGenerationWithEncodableQueryParameters() throws {
    struct TestQuery: Encodable {
      let key: String
      let anotherKey: String
    }

    let config = MockNetworkConfig(baseURL: URL(string: "https://api.example.com")!)
    let query = TestQuery(key: "value", anotherKey: "another_value")
    let endpoint = Endpoint<Void>(path: "v1/test", method: .get, queryParametersEncodable: query)

    let urlRequest = try endpoint.urlRequest(with: config)

    XCTAssertTrue(urlRequest.url?.absoluteString.contains("key=value") ?? false)

    XCTAssertFalse(urlRequest.url?.absoluteString.contains("another_key=another_value") ?? false)
  }

  func testURLRequestWithHeaders() throws {
    let config = MockNetworkConfig(baseURL: URL(string: "https://api.example.com")!, headers: ["Global-Header": "GlobalValue"])
    let headers = ["Authorization": "Bearer token"]
    let endpoint = Endpoint<Void>(path: "v1/test", method: .get, headerParameters: headers)

    let urlRequest = try endpoint.urlRequest(with: config)

    XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Authorization"], "Bearer token")
    XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Global-Header"], "GlobalValue")
  }

  func testURLRequestWithHTTPMethod() throws {
    let config = MockNetworkConfig(baseURL: URL(string: "https://api.example.com")!)
    let endpoint = Endpoint<Void>(path: "v1/test", method: .post)

    let urlRequest = try endpoint.urlRequest(with: config)

    XCTAssertEqual(urlRequest.httpMethod, "POST")
  }
}
