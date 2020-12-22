//
//  NetworkParamEncoding.swift
//  revolut
//
//  Created by alex kanchurin on 26.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import Foundation

protocol ParamListEncoding {
  
  func encode(request: URLRequest, params: [String: String]) -> URLRequest
}

// MARK: - QueryStringEncoding

struct QueryStringEncoding: ParamListEncoding {
  
  static let `default` = QueryStringEncoding()
  
  func encode(request: URLRequest, params: [String: String]) -> URLRequest {
    var resultRequest = request

    let queryItems = params.map { key, value in URLQueryItem(name: key, value: value) }
    resultRequest.append(queryItems: queryItems)
    
    return resultRequest
  }
}
