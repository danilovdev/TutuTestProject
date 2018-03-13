//
//  CoreDataManager.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 11.03.2018.
//  Copyright © 2018 DanilovDev. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private(set) lazy var manageObjectContext: NSManagedObjectContext = {
        let manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        manageObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return manageObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelUrl = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption : true,
                NSInferMappingModelAutomaticallyOption : true
            ]
            
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreUrl, options: options)
        } catch let error as NSError {
            print("Failed to add persistent store: \(error.userInfo)")
        }
        
        return persistentStoreCoordinator
        
    }()
    
    private lazy var persistentStoreUrl: URL = {
        let fileManager = FileManager.default
        let documentsDirectoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let storeName = "\(modelName).sqlite"
        let persistentStoreUrl = documentsDirectoryUrl.appendingPathComponent(storeName)
        return persistentStoreUrl
    }()
    
    func saveContext() {
        guard manageObjectContext.hasChanges else {
            return
        }
        do {
            try manageObjectContext.save()
        } catch let error as NSError {
            print("Cannot save context: \(error.userInfo)")
        }
    }
    
}
