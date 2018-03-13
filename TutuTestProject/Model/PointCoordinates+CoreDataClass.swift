//
//  PointCoordinates+CoreDataClass.swift
//  
//
//  Created by Alexey Danilov on 13.03.2018.
//
//

import Foundation
import CoreData

@objc(PointCoordinates)
public class PointCoordinates: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "PointCoordinates", in: managedObjectContext) else {
                fatalError("Failed to decode DataSource")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            longitude = try container.decode(Double.self, forKey: CodingKeys.longitude)
            latitude = try container.decode(Double.self, forKey: CodingKeys.latitude)
        } catch let error as NSError {
            print("\(error)")
        }
    }

}
