//
//  ApiError.swift
//  revolut
//
//  Created by alex on 27.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

enum ApiError: Error {
  case badRequest
  case decodingError(info: String)
  case internetConnection(info: String)
  case emptyResponse
  case backendError(WeatherError)
}

// MARK: - ApiError + NetworkError

extension ApiError {
  
  init(_ networkError: NetworkError) {
    switch networkError {
    case .badRequest:
      self = .badRequest
      
    case .transport(let description):
      self = .internetConnection(info: description)
      
    case .emptyResponse:
      self = .emptyResponse
    }
  }
}
