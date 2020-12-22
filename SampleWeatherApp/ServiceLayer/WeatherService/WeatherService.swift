//
//  WeatherService.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 25.10.2020.
//

protocol WeatherService {
  
  func checkCity(name: String, completion: @escaping (Result<CityWeatherDTO, ServiceError>) -> Void)
  
  func getCityListWeather(cityIdList: [UInt64], completion: @escaping (Result<[CityWeatherDTO], ServiceError>) -> Void)
}
