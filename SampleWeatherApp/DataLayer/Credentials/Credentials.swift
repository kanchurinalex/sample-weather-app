//
//  Credentials.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 28.10.2020.
//

enum CredentialsKey: String, CaseIterable {
  case apiKey
}

protocol Credentials {
  
  func setValue(_ value: String, forKey key: CredentialsKey) -> Bool
  
  func getValue(forKey key: CredentialsKey) -> String?
  
  func removeValue(forKey key: CredentialsKey)
}
