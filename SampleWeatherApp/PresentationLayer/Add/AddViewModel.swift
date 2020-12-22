//
//  AddViewModel.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 22.12.2020.
//

// MARK: - Model

enum AddViewModelState {
  case initial
  case isLoading
  case error(Error)
}

protocol AddViewModel {
  
  var processState: ((AddViewModelState) -> Void)? { get set }
  
  func viewLoaded()
  
  func checkCity(_ city: String)
}

// MARK: - Output

enum AddOutput {
  case add(cityId: UInt64)
  case close
}

protocol AddModel: AnyObject {
  
  var processOutput: ((AddOutput) -> Void)? { get set }
}
