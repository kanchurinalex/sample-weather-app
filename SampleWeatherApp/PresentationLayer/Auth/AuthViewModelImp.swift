//
//  AuthViewModel.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 12.11.2020.
//

import Foundation

final class AuthViewModelImp: AuthViewModel, AuthModel {
  
  typealias State = AuthViewModelState
  typealias Output = AuthOutput
  
  private let authService: AuthService
  private var state: State = .initial
  
  init(authService: AuthService) {
    self.authService = authService
  }
  
  // MARK: Interface for Coordinator
  
  var processOutput: ((Output) -> Void)?
  
  // MARK: Interface for UI
  
  var processState: ((State) -> Void)?
  
  func viewLoaded() {
    update(newState: .initial)
  }

  func loginWith(apiKey: String) {
    update(newState: .isLoading)
    
    authService.loginWith(apiKey: apiKey) { [weak self] error in
      DispatchQueue.main.async {
        guard let self = self else { return }
        
        if let error = error {
          self.update(newState: .error(error))
          return
        }
        
        self.processOutput?(.done)
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

extension AuthViewModelImp {}
