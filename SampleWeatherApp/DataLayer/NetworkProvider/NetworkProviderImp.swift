//
//  NetworkProviderImp.swift
//  revolut
//
//  Created by alex on 25.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import Foundation

final class NetworkProviderImp {
  
  private let session: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 1
    let session = URLSession(configuration: configuration)
    return session
  }()
  
  private var adapterClosure: ((inout URLRequest) -> Void)?
}

// MARK: - NetworkProvider

extension NetworkProviderImp: NetworkProvider {
  
  func setRequestAdapter(_ adapter: @escaping (inout URLRequest) -> Void) {
    self.adapterClosure = adapter
  }

  func request(endpoint: Endpoint, completion: @escaping (Result<Data, NetworkError>) -> Void) {
    guard let url = URL(string: endpoint.path) else {
      completion(.failure(.badRequest))
      return
    }
    
    var request = URLRequest(url: url)
    
    adapterClosure?(&request)
    
    switch endpoint.task {
    case let .request(params, encoding):
      request = encoding.encode(request: request, params: params)
    }
    
    let task = session.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(.transport(description: error.localizedDescription)))
        return
      }
      
      guard let data = data else {
        completion(.failure(.emptyResponse))
        return
      }
      
      completion(.success(data))
    }
    
    task.resume()
  }
}
