//
//  ServiceError.swift
//  revolut
//
//  Created by alex on 29.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import Foundation

enum ServiceError: Error {
  case readableError(String)
  case noData
  case connection(String)
  case system(String?)
}

extension ServiceError: LocalizedError {
  
  var errorDescription: String? {
    switch self {
    case .readableError(let message):
      return message
    
    case .noData:
      return "No data available"
      
    case .connection(let message):
      return "Connection error: \(message)"
      
    case .system(let message):
      return message ?? "System error"
    }
  }
}

extension ServiceError {
  
  init(_ apiError: ApiError) {
    switch apiError {
    case .badRequest:
      self = .system(nil)
      
    case .decodingError(let info):
      self = .system(info)
      
    case .emptyResponse:
      self = .noData
      
    case .internetConnection(let info):
      self = .connection(info)
      
    case .backendError(let error):
      self = .readableError(error.message)
    }
  }
}
