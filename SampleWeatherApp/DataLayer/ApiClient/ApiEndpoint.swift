//
//  ApiEndpoint.swift
//  revolut
//
//  Created by alex on 27.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

enum ApiEndpoint {
  
  static let baseUrl = "https://api.openweathermap.org/data"
  
  case cityWeather(name: String)
  case cityListWeather(cityIdList: [UInt64])
}

extension ApiEndpoint: Endpoint {

  var httpMethod: HttpMethod {
    return .get
  }
  
  var path: String {
    let version = "/2.5/"
    
    switch self {
    case .cityWeather:
      return Self.baseUrl + version + "weather"
      
    case .cityListWeather:
      return Self.baseUrl + version + "group"
    }
  }
  
  var task: NetworkTask {
    switch self {
    case .cityWeather(let name):
      return .request(params: ["q": name], encoding: QueryStringEncoding.default)
      
    case .cityListWeather(let cityIdList):
      let cityString = cityIdList.reduce("") { result, next in result + (!result.isEmpty ? "," : "") + String(next) }
      let params = ["id": cityString, "units": "metric"]
      return .request(params: params, encoding: QueryStringEncoding.default)
    }
  }
}
