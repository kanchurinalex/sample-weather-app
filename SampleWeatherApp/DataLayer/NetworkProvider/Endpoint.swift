//
//  NetworkTypes.swift
//  revolut
//
//  Created by alex kanchurin on 26.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import Foundation

// MARK: - Endpoint

protocol Endpoint {

  var httpMethod: HttpMethod { get }
  
  var path: String { get }
  
  var task: NetworkTask { get }
}

enum HttpMethod: String {
  case get = "GET"
}

// MARK: - Task

enum NetworkTask {
//  case request(paramList: [ParamPair], encoding: ParamListEncoding)
  case request(params: [String: String], encoding: ParamListEncoding)
}
