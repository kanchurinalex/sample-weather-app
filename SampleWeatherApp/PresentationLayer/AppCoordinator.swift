//
//  AppCoordinator.swift
//  revolut
//
//  Created by alex on 29.02.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import UIKit

final class AppCoordinator {
  
  let window: UIWindow
  let navigationController: UINavigationController
  
  let dataContainer: DataContainer
  let serviceContainer: ServiceContainer
  
  private var mainModel: MainModel?
  
  init(window: UIWindow,
       dataContainer: DataContainer,
       serviceContainer: ServiceContainer) {
    self.window = window
    self.dataContainer = dataContainer
    self.serviceContainer = serviceContainer
    self.navigationController = UINavigationController()
  }
  
  // MARK: Interface
  
  func start() {
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    let authService = serviceContainer.getAuthService()
    
    if authService.isAuthorized {
      navigationController.viewControllers = [main()]
    } else {
      navigationController.viewControllers = [auth()]
    }
  }
  
  func preserveData() {
    let persistanceManager = dataContainer.getPersistenceManager()
    persistanceManager.save()
  }
  
  // MARK: Private. Modules
  
  private func auth() -> UIViewController {
    let viewController = AuthViewController()
    let viewModel = AuthViewModelImp(authService: serviceContainer.getAuthService())
    
    bind(viewModel)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
  
  private func main() -> UIViewController {
    let viewController = MainViewController(nibName: nil, bundle: nil)
    
    let viewModel = MainViewModelImp(weatherService: serviceContainer.getWeatherService())
    mainModel = viewModel
    
    bind(viewModel)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
  
  private func add() -> UIViewController {
    let viewController = AddViewController()

    let viewModel = AddViewModelImp(weatherService: serviceContainer.getWeatherService())

    bind(viewModel)

    viewController.viewModel = viewModel

    return viewController
  }
}

// MARK: - AppCoordinator + binding modules' outputs

extension AppCoordinator {
  
  private func bind(_ model: AuthModel) {
    model.processOutput = { [weak self] output in
      guard let self = self else { return }
      
      switch output {
      case .done:
        self.navigationController.viewControllers = [self.main()]
      }
    }
  }
  
  private func bind(_ model: MainModel) {
    model.processOutput = { [weak self] output in
      guard let self = self else { return }
      
      switch output {
      case .addCity:
        self.navigationController.pushViewController(self.add(), animated: true)
      case .done:
        break
      }
    }
  }
  
  private func bind(_ model: AddModel) {
    model.processOutput = { [weak self] output in
      guard let self = self else { return }
      
      switch output {
      case .add(let cityId):
        self.navigationController.popViewController(animated: true)
        self.mainModel?.addCity(id: cityId)
        
      case .close:
        self.navigationController.popViewController(animated: true)
      }
    }
  }
}
