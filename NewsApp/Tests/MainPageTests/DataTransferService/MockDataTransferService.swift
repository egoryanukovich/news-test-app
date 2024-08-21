//
//  MockDataTransferService.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

@testable import NewsFeedFeature
@testable import NetworkingService

class MockDataTransferService: DataTransferServiceInterface {
  var requestCalled = false
  var endpointPassed: Any?
  var requestResult: Result<NewsFeedResponseModel, DataTransferError>?

  func request<T: Decodable, E: ResponseRequestable>(
    with endpoint: E,
    resultHandler: @escaping (Result<T, DataTransferError>) -> Void
  ) where T == E.Response {
    requestCalled = true
    endpointPassed = endpoint
    if let result = requestResult as? Result<T, DataTransferError> {
      resultHandler(result)
    }
  }
}

