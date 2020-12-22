//
//  MainViewModelImp.swift
//  revolut
//
//  Created by alex on 29.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import Foundation

final class MainViewModelImp: MainViewModel, MainModel {
  
  typealias State = MainViewModelState
  typealias Output = MainOutput
  
  private let weatherService: WeatherService
  private var state: State = .items([])
  private var cityIdList: [UInt64] = []
  
  init(weatherService: WeatherService) {
    self.weatherService = weatherService
  }
  
  // MARK: - Interface for Coordinator
  
  var processOutput: ((Output) -> Void)?
  
  func addCity(id: UInt64) {
    update(newState: .isLoading)
    
    cityIdList.append(id)
    
    weatherService.getCityListWeather(cityIdList: cityIdList) { [weak self] result in
      DispatchQueue.main.async {
        guard let self = self else { return }
        
        switch result {
        case .success(let weatherList):
          let list = weatherList.map { Weather($0) }
          self.update(newState: .items(list))
        
        case .failure(let error):
          self.update(newState: .error(error))
        }
      }
    }
  }
  
  // MARK: Interface for UI
  
  var processState: ((State) -> Void)?
  
  func viewLoaded() {
    update(newState: .items([]))
  }
  
  func addCity() {
    processOutput?(.addCity)
  }
  
  func refresh() {
  }
  
  // MARK: Private. Update state
  
  private func update(newState: State) {
    self.state = newState
    processState?(newState)
  }
}
