//
//  MainViewModel.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 17.12.2020.
//

// MARK: - Model

struct Weather {
  
  let cityName: String
  
  let temp: String
  
  init(_ dto: CityWeatherDTO) {
    self.cityName = dto.name
    self.temp = String(dto.temperature.degrees)
  }
}

enum MainViewModelState {
  case items([Weather])
  case isLoading
  case error(Error)
}

protocol MainViewModel {
  
  var processState: ((MainViewModelState) -> Void)? { get set }
  
  func viewLoaded()
  
  func addCity()
  
  func refresh()
}

// MARK: - Output

enum MainOutput {
  case addCity
  case done
}

protocol MainModel: AnyObject {
  
  var processOutput: ((MainOutput) -> Void)? { get set }
  
  func addCity(id: UInt64)
}
