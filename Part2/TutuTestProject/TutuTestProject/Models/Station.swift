//
//  Station.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 09/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

struct Station {
    
    private(set) var countryTitle: String
    
    private(set) var districtTitle: String
    
    private(set) var cityId: Int
    
    private(set) var cityTitle: String
    
    private(set) var regionTitle: String
    
    private(set) var stationId: String
    
    private(set) var stationTitle: String
    
    private(set) var point: PointCoordinates
    
    init(dictionary: Dictionary<String, Any>) {
        if let countryTitle = dictionary["countryTitle"] as? String {
            self.countryTitle = countryTitle
        } else {
            self.countryTitle = String.unknownValue
        }
        if let districtTitle = dictionary["districtTitle"] as? String {
            self.districtTitle = districtTitle
        } else {
            self.districtTitle = String.unknownValue
        }
        if let cityId = dictionary["cityId"] as? Int {
            self.cityId = cityId
        } else {
            self.cityId = Int.unknownValue
        }
        if let cityTitle = dictionary["cityTitle"] as? String {
            self.cityTitle = cityTitle
        } else {
            self.cityTitle = String.unknownValue
        }
        if let regionTitle = dictionary["regionTitle"] as? String {
            self.regionTitle = regionTitle
        } else {
            self.regionTitle = String.unknownValue
        }
        if let stationId = dictionary["stationId"] as? String {
            self.stationId = stationId
        } else {
            self.stationId = String.unknownValue
        }
        if let stationTitle = dictionary["stationTitle"] as? String {
            self.stationTitle = stationTitle
        } else {
            self.stationTitle = String.unknownValue
        }
        if let pointDict = dictionary["point"] as? Dictionary<String, Any> {
            self.point = PointCoordinates(dictionary: pointDict)
        } else {
            self.point = PointCoordinates()
        }
    }
}

extension Station: CustomStringConvertible {
    
    var description: String {
        return "Station: \(stationTitle), with id: \(stationId), country: \(countryTitle), city: \(cityTitle), "
            + "region: \(regionTitle), district: \(districtTitle), "
            + "point: \(point.longitude, point.latitude)"
    }
}
