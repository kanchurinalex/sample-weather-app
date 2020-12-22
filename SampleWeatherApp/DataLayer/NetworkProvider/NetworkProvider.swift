//
//  NetworkProvider.swift
//  revolut
//
//  Created by alex on 25.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import Foundation

protocol NetworkProvider {
  
  func setRequestAdapter(_ adapter: @escaping (inout URLRequest) -> Void)
  
  func request(endpoint: Endpoint, completion: @escaping (Result<Data, NetworkError>) -> Void)
}
