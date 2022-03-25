//
//  CoreDataManager.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 24.03.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
  
  static let sharedManager = CoreDataManager()
    
  private init() {} // Prevent clients from creating another instance.
  
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "Myfinan")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
