//
//  WeatherError.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 04.12.2020.
//

struct WeatherError: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case code = "cod"
    case message = "message"
  }
  
  let code: String
  
  let message: String
}
