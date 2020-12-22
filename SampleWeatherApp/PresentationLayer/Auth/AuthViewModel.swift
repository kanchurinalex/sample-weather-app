//
//  AuthViewModel.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 01.12.2020.
//

// MARK: - Model

enum AuthViewModelState {
  case initial
  case isLoading
  case error(Error)
}

protocol AuthViewModel {
  
  var processState: ((AuthViewModelState) -> Void)? { get set }
  
  func viewLoaded()
  
  func loginWith(apiKey: String)
}

// MARK: - Output

enum AuthOutput {
  case done
}

protocol AuthModel: AnyObject {
  
  var processOutput: ((AuthOutput) -> Void)? { get set }
}
