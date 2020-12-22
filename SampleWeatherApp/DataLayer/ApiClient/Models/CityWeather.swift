//
//  CityWeather.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 12.11.2020.
//

// DTO stays for Data Transfer Object

struct CityWeatherListDTO: Decodable {
  
  let list: [CityWeatherDTO]
}

struct CityWeatherDTO: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case temperature = "main"
  }
  
  let id: UInt64
  
  let name: String
  
  let temperature: TemperatureDTO
}

struct TemperatureDTO: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case degrees = "temp"
    case feltDegrees = "feels_like"
  }
  
  let degrees: Double
  
  let feltDegrees: Double
}
