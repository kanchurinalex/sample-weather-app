//
//  ApiClientImp.swift
//  revolut
//
//  Created by alex on 27.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import Foundation

final class ApiClientImp {
  
  static private let appIdKey = "appid"
  
  let networkProvider: NetworkProvider
  let credentials: Credentials
  
  init(networkProvider: NetworkProvider,
       credentials: Credentials) {
    self.networkProvider = networkProvider
    self.credentials = credentials
    
    networkProvider.setRequestAdapter { [weak self] request in
      self?.addApiKeyToRequest(&request)
    }
  }
  
  // MARK: - Private. Add apiKey to request
  
  private func addApiKeyToRequest(_ request: inout URLRequest) {
    guard let apiKey = credentials.getValue(forKey: .apiKey) else { return }
    request.append(queryItems: [URLQueryItem(name: "appid", value: apiKey)])
  }
}

// MARK: - ApiClient

extension ApiClientImp: ApiClient {
  
  func request<ResultObject: Decodable>(endpoint: ApiEndpoint,
                                        completion: @escaping (Result<ResultObject, ApiError>) -> Void) {
    networkProvider.request(endpoint: endpoint) { result in
      switch result {
      case .failure(let networkError):
        let error = ApiError(networkError)
        completion(.failure(error))
        return
        
      case .success(let data):
        guard let resultObject = try? JSONDecoder().decode(ResultObject.self, from: data) else {
          
          var error: ApiError
          if let weatherError = try? JSONDecoder().decode(WeatherError.self, from: data) {
            error = .backendError(weatherError)
          } else {
            error = .decodingError(info: "Error decoding \(ResultObject.self)")
          }
          
          completion(.failure(error))
          return
        }
        
        completion(.success(resultObject))
      }
    }
  }
}
