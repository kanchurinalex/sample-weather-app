//
//  ServiceContainer.swift
//  revolut
//
//  Created by alex kanchurin on 03.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

protocol ServiceContainer {
  
  func getWeatherService() -> WeatherService
  
  func getAuthService() -> AuthService
}
