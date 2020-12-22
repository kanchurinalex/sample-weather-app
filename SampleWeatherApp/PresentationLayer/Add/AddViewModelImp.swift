//
//  AddViewModelImp.swift
//  revolut
//
//  Created by alex on 01.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import Foundation

final class AddViewModelImp: AddViewModel, AddModel {
  
  typealias State = AddViewModelState
  typealias Output = AddOutput
  
  private let weatherService: WeatherService
  private var state: State = .initial
  
  init(weatherService: WeatherService) {
    self.weatherService = weatherService
  }
  
  // MARK: Interface for Coordinator
  
  var processOutput: ((Output) -> Void)?
  
  // MARK: Interface for UI
  
  var processState: ((State) -> Void)?
  
  func viewLoaded() {
    update(newState: .initial)
  }
  
  func checkCity(_ city: String) {
    update(newState: .isLoading)
    
    weatherService.checkCity(name: city) { [weak self] result in
      DispatchQueue.main.async {
        guard let self = self else { return }
        
        switch result {
        case .success(let weather):
          self.processOutput?(.add(cityId: weather.id))
        
        case .failure(let error):
          self.update(newState: .error(error))
        }
      }
    }
  }
  
  // MARK: Private. Update state
  
  private func update(newState: State) {
    self.state = newState
    processState?(newState)
  }
}

// MARK: - Presentation model

extension AddViewModel {
}
