//
//  URLRequest+QueryItems.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 17.12.2020.
//

import Foundation

extension URLRequest {
  
  mutating func append(queryItems: [URLQueryItem]) {
    guard let url = url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
    
    urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
    
    self.url = urlComponents.url
  }
}
