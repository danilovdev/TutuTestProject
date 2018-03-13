//
//  Station+CoreDataProperties.swift
//  
//
//  Created by Alexey Danilov on 13.03.2018.
//
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }

    @NSManaged public var countryTitle: String?
    @NSManaged public var districtTitle: String?
    @NSManaged public var cityId: Int32
    @NSManaged public var cityTitle: String?
    @NSManaged public var regionTitle: String?
    @NSManaged public var stationId: Int32
    @NSManaged public var stationTitle: String?
    @NSManaged public var point: PointCoordinates?
    @NSManaged public var city: City?

}
