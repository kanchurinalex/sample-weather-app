//
//  CredentialsImp.swift
//  SampleWeatherApp
//
//  Created by alex kanchurin on 28.10.2020.
//

import Foundation
import Security

final class CredentialsImp {
  
  private func insertStringValue(_ value: String, forKey key: String) -> Bool {
    guard let valueData = value.data(using: .utf8) else { return false }
    
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key,
      kSecValueData as String: valueData
    ]
    
    return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
  }
  
  private func searchStringValueForKey(_ key: String) -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key,
      kSecReturnData as String: true
    ]
    
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    
    guard status == errSecSuccess else { return nil }
    
    guard let valueData = item as? Data,
          let value = String(data: valueData, encoding: .utf8) else { return nil }
    
    return value
  }
  
  private func updateStringValue(_ value: String, forKey key: String) -> Bool {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key
    ]
    
    let attributes: [String: Any] = [kSecValueData as String: value]
    
    return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
  }
  
  private func deleteStringValue(forKey key: String) -> Bool {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: key
    ]
    
    return SecItemDelete(query as CFDictionary) == errSecSuccess
  }
}

// MARK: - Credentials

extension CredentialsImp: Credentials {
  
  func setValue(_ value: String, forKey key: CredentialsKey) -> Bool {
    if let _ = searchStringValueForKey(key.rawValue) {
      return updateStringValue(value, forKey: key.rawValue)
    } else {
      return insertStringValue(value, forKey: key.rawValue)
    }
  }
  
  func getValue(forKey key: CredentialsKey) -> String? {
    return searchStringValueForKey(key.rawValue)
  }
  
  func removeValue(forKey key: CredentialsKey) {
    _ = deleteStringValue(forKey: key.rawValue)
  }
}
