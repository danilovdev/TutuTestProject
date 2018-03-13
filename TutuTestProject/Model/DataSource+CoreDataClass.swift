//
//  DataSource+CoreDataClass.swift
//
//
//  Created by Alexey Danilov on 11.03.2018.
//
//

import Foundation
import CoreData

@objc(DataSource)
public class DataSource: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case citiesFrom
        case citiesTo
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "DataSource", in: managedObjectContext) else {
                fatalError("Failed to decode DataSource")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let citiesFromArray = try container.decodeIfPresent([City].self, forKey: CodingKeys.citiesFrom) {
                citiesFrom = NSSet(array: citiesFromArray)
            }
            if let citiesToArray = try container.decodeIfPresent([City].self, forKey: CodingKeys.citiesTo) {
                citiesTo = NSSet(array: citiesToArray)
            }
        } catch let error as NSError {
            print("Failed to decode cities: \(error.userInfo)")
        }
    }
    
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}



