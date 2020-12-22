//
//  WeatherServiceImp.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 27.10.2020.d
//

final class WeatherServiceImp {
  
  private let apiClient: ApiClient
  private let persistenceManager: PersistenceManager
  
  init(apiClient: ApiClient, persistenceManager: PersistenceManager) {
    self.apiClient = apiClient
    self.persistenceManager = persistenceManager
  }
}

// MARK: - WeatherService

extension WeatherServiceImp: WeatherService {
  
  func checkCity(name: String, completion: @escaping (Result<CityWeatherDTO, ServiceError>) -> Void) {
    apiClient.request(endpoint: .cityWeather(name: name)) { (result: Result<CityWeatherDTO, ApiError>) in      
      switch result {
      case .success(let weather):
        completion(.success(weather))
        
      case .failure(let error):
        completion(.failure(ServiceError(error)))
      }
    }
  }
  
  func getCityListWeather(cityIdList: [UInt64], completion: @escaping (Result<[CityWeatherDTO], ServiceError>) -> Void) {
    apiClient.request(endpoint: .cityListWeather(cityIdList: cityIdList)) { (result: Result<CityWeatherListDTO, ApiError>) in
      switch result {
      case .success(let weatherList):
        completion(.success(weatherList.list))
        
      case .failure(let error):
        let serviceError = ServiceError(error)
        completion(.failure(serviceError))
      }
    }
  }
}
