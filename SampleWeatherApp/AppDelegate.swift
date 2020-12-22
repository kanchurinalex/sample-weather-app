//
//  AppDelegate.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 25.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private var appCoordinator: AppCoordinator?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    
    appCoordinator = createAppCoordinator(window: window)
    appCoordinator?.start()
    
    return true
  }
  
  // MARK: - Private
  
  private func createAppCoordinator(window: UIWindow) -> AppCoordinator  {
    let dataContainer = DataContainerImp()
    let serviceContainer = ServiceContainerImp(dataContainer: dataContainer)
    return AppCoordinator(window: window, dataContainer: dataContainer, serviceContainer: serviceContainer)
  }
}

