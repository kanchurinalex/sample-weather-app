//
//  DataFabricImp.swift
//  revolut
//
//  Created by alex kanchurin on 03.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

final class DataContainerImp {
  
  private let networkProvider = NetworkProviderImp()
  
  private let persistenceManager = PersistenceManagerImp()
  
  private let credentials = CredentialsImp()
}

// MARK: - DataFabric

extension DataContainerImp: DataContainer {
  
  func getApiClient() -> ApiClient {
    return ApiClientImp(networkProvider: networkProvider, credentials: credentials)
  }
  
  func getPersistenceManager() -> PersistenceManager {
    return persistenceManager
  }
  
  func getCredentials() -> Credentials {
    return credentials
  }
}
