//
//  ServiceFabricImp.swift
//  revolut
//
//  Created by alex on 03.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

final class ServiceContainerImp {
  
  private let dataContainer: DataContainer
  
  private lazy var weatherService: WeatherService = {
    let apiClient = dataContainer.getApiClient()
    let persistenceManager = dataContainer.getPersistenceManager()
    
    return WeatherServiceImp(apiClient: apiClient, persistenceManager: persistenceManager)
  }()
  
  private lazy var authService: AuthService = {
    let apiClient = dataContainer.getApiClient()
    let credentials = dataContainer.getCredentials()
    
    return AuthServiceImp(apiClient: apiClient, credentials: credentials)
  }()
  
  init(dataContainer: DataContainer) {
    self.dataContainer = dataContainer
  }
}

// MARK: - ServiceContainer

extension ServiceContainerImp: ServiceContainer {
  
  func getWeatherService() -> WeatherService { weatherService }
  
  func getAuthService() -> AuthService { authService }
}
