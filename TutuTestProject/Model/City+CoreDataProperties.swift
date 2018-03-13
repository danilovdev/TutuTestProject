//
//  City+CoreDataProperties.swift
//  
//
//  Created by Alexey Danilov on 13.03.2018.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityId: Int32
    @NSManaged public var cityTitle: String?
    @NSManaged public var countryTitle: String?
    @NSManaged public var districtTitle: String?
    @NSManaged public var regionTitle: String?
    @NSManaged public var point: PointCoordinates?
    @NSManaged public var dataSourceFrom: DataSource?
    @NSManaged public var dataSourceTo: DataSource?
    @NSManaged public var stations: NSSet?
    

}
