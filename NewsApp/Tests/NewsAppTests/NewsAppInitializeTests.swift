//
//  NewsAppInitializeTests.swift
//
//
//  Created by Egor Yanukovich on 21.08.24.
//

import XCTest
@testable import NewsApp

class YourCoordinatorTests: XCTestCase {
  var window: UIWindow!

  override func setUp() {
    super.setUp()
    window = UIWindow()
  }

  override func tearDown() {
    window = nil
    super.tearDown()
  }

  @MainActor
  func testInitWithValidURL() throws {
    let validURLString = "https://api.example.com"

    let coordinator = try NewsApp.Module(
      window: window,
      urlString: validURLString
    )


    XCTAssertNotNil(coordinator)
  }

  @MainActor
  func testInitWithInvalidURL() {
    let invalidURLString = "invalid_url_string"

    XCTAssertThrowsError(try NewsApp.Module(window: window, urlString: invalidURLString)) { error in
      XCTAssertEqual(error as? NewsAppError, NewsAppError.noURL)
    }
  }
}
