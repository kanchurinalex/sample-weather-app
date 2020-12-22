//
//  AuthServiceImp.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 12.11.2020.
//

final class AuthServiceImp {
  
  private let apiClient: ApiClient
  private let credentials: Credentials
  
  init(apiClient: ApiClient,
       credentials: Credentials) {
    self.apiClient = apiClient
    self.credentials = credentials
  }
}

// MARK: - AuthService

extension AuthServiceImp: AuthService {
  
  var isAuthorized: Bool {
    let apiKey = credentials.getValue(forKey: .apiKey)
    return apiKey != nil
  }
  
  func loginWith(apiKey: String, completion: @escaping (ServiceError?) -> Void) {
    credentials.removeValue(forKey: .apiKey)
    
    guard credentials.setValue(apiKey, forKey: .apiKey) else {
      completion(ServiceError.system("Unable to save apiKey to credentials"))
      return
    }
    
    apiClient.request(endpoint: .cityWeather(name: "Moscow")) { [weak self] (result: Result<CityWeatherDTO, ApiError>) in
      guard let self = self else { return }
      
      switch result {
      case .success:
        completion(nil)
        return
        
      case .failure(let error):
        self.credentials.removeValue(forKey: .apiKey)
        let serviceError = ServiceError(error)
        completion(serviceError)
      }
    }
  }
}
