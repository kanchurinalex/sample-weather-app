//
//  PersistenceManagerImp.swift
//  revolut
//
//  Created by alex kanchurin on 04.03.2020.
//  Copyright © 2020 kanchurinalex. All rights reserved.
//

import CoreData

final class PersistenceManagerImp {
  
  private lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: Constants.modelName)
    
//    description.type = NSSQLiteStoreType
//    container.persistentStoreDescriptions = [description]
    
    container.loadPersistentStores { storeDescription, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
    }
    
    return container
  }()
}

// MARK: - PersistenceManager

extension PersistenceManagerImp: PersistenceManager {
  
  func addRecord(_ record: Record) {
    let context = container.viewContext
    
    let item = StringObject(context: context)
    item.id = record.id
    item.value = record.value
    
    context.insert(item)
  }
  
  func deleteRecordBy(id: Int64) {
    let context = container.viewContext
    
    let request: NSFetchRequest = StringObject.fetchRequest()
    request.predicate = NSPredicate(format: "id = \(id)")
    
    if let item = (try? context.fetch(request))?.first {
      context.delete(item)
    }
  }
  
  func getRecords() -> [Record] {
    let context = container.viewContext
    
    let request: NSFetchRequest = StringObject.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
    
    let items = (try? context.fetch(request)) ?? []
    
    return items.compactMap {
      guard let value = $0.value else { return nil }
      return Record(id: $0.id, value: value)
    }
  }
  
  func save() {
    guard container.viewContext.hasChanges else { return }
    try? container.viewContext.save()
  }
}

// MARK: - Private. Constants

extension PersistenceManagerImp {
  
  private enum Constants {
    static let modelName = "Model"
  }
}
