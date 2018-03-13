//
//  DataSource+CoreDataProperties.swift
//  
//
//  Created by Alexey Danilov on 13.03.2018.
//
//

import Foundation
import CoreData


extension DataSource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataSource> {
        return NSFetchRequest<DataSource>(entityName: "DataSource")
    }

    @NSManaged public var citiesFrom: NSSet?
    @NSManaged public var citiesTo: NSSet?

}
