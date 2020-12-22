//
//  AuthService.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 12.11.2020.
//

protocol AuthService {
  
  var isAuthorized: Bool { get }
  
  func loginWith(apiKey: String, completion: @escaping (ServiceError?) -> Void)
}
