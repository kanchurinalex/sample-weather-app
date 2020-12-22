//
//  NetworkError.swift
//  revolut
//
//  Created by alex on 27.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

enum NetworkError: Error {
  case badRequest
  case transport(description: String)
  case emptyResponse
}
