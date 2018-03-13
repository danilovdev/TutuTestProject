//
//  PointCoordinates+CoreDataProperties.swift
//  
//
//  Created by Alexey Danilov on 13.03.2018.
//
//

import Foundation
import CoreData


extension PointCoordinates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PointCoordinates> {
        return NSFetchRequest<PointCoordinates>(entityName: "PointCoordinates")
    }

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    
    var desc: String {
        let longitudeStr = String(format: "%.4f", Double(longitude))
        let latitudeStr = String(format: "%.4f", Double(latitude))
        return "Долгота: \(longitudeStr), Широта: \(latitudeStr)"
    }

}
