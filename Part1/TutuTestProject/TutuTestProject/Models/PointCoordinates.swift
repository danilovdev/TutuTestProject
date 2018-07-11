//
//  Point.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 09/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

struct PointCoordinates {
    
    private(set) var longitude: Double
    
    private(set) var latitude: Double
    
    init(longitude: Double = 0.0, latitude: Double = 0.0) {
        self.longitude = longitude
        self.latitude = latitude
    }
    
    init(dictionary: Dictionary<String, Any>) {
        var longitude = 0.0
        var latitude = 0.0
        if let longitudeVal = dictionary["longitude"] as? Double {
            longitude = longitudeVal
        }
        if let latitudeVal = dictionary["latitude"] as? Double {
            latitude = latitudeVal
        }
        self.init(longitude: longitude, latitude: latitude)
    }
    
}
