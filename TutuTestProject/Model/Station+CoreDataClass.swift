//
//  Station+CoreDataClass.swift
//  
//
//  Created by Alexey Danilov on 13.03.2018.
//
//

import Foundation
import CoreData

@objc(Station)
public class Station: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case countryTitle
        case districtTitle
        case cityId
        case cityTitle
        case regionTitle
        case stationId
        case stationTitle
        case point
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Station", in: managedObjectContext) else {
                fatalError("Failed to decode DataSource")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            cityTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.cityTitle)
            countryTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.countryTitle)
            districtTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.districtTitle)
            regionTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.regionTitle)
            stationTitle = try container.decodeIfPresent(String.self, forKey: CodingKeys.stationTitle)
            cityId = try container.decode(Int32.self, forKey: CodingKeys.cityId)
            stationId = try container.decode(Int32.self, forKey: CodingKeys.stationId)
            point = try container.decodeIfPresent(PointCoordinates.self, forKey: CodingKeys.point)
        } catch let error as NSError {
            print("\(error)")
        }
    }

}
