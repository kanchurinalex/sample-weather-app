//
//  ApiClient.swift
//  revolut
//
//  Created by alex on 27.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

protocol ApiClient {
  
  func request<ResultObject: Decodable>(endpoint: ApiEndpoint, completion: @escaping (Result<ResultObject, ApiError>) -> Void)
}
