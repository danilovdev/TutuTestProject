//
//  City+CoreDataClass.swift
//
//
//  Created by Alexey Danilov on 11.03.2018.
//
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case cityId
        case cityTitle
        case countryTitle
        case districtTitle
        case regionTitle
        case point
        case stations
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "City", in: managedObjectContext) else {
                fatalError("Failed to decode DataSource")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            cityTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.cityTitle)
            countryTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.countryTitle)
            districtTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.districtTitle)
            regionTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.regionTitle)
            cityId = try container.decode(Int32.self, forKey: CodingKeys.cityId)
            point = try container.decodeIfPresent(PointCoordinates.self, forKey: CodingKeys.point)
            if let stationsArray = try container.decodeIfPresent([Station].self, forKey: CodingKeys.stations) {
                stations = NSSet(array: stationsArray)
            }
        } catch let error as NSError {
            print("\(error)")
        }
    }
}


