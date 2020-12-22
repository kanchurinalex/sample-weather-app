//
//  PersistanceManger.swift
//  revolut
//
//  Created by alex kanchurin on 04.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

protocol PersistenceManager {
  
  func addRecord(_ record: Record)
  
  func deleteRecordBy(id: Int64)
  
  func getRecords() -> [Record]
  
  func save()
}
