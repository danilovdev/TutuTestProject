//
//  City.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 09/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

struct City {
    
    private(set) var countryTitle: String

    private(set) var districtTitle: String
    
    private(set) var cityId: Int
    
    private(set) var cityTitle: String
    
    private(set) var regionTitle: String
    
    private(set) var point: PointCoordinates
    
    private(set) var stations = [Station]()
    
    init(dictionary: Dictionary<String, Any>) {
        if let countryTitle = dictionary["countryTitle"] as? String {
            self.countryTitle = countryTitle
        } else {
            countryTitle = String.unknownValue
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
        
        if let pointDict = dictionary["point"] as? Dictionary<String, Any> {
            self.point = PointCoordinates(dictionary: pointDict)
        } else {
            self.point = PointCoordinates()
        }
        
        if let stationsArray = dictionary["stations"] as? Array<Dictionary<String, Any>> {
            for stationItemDict in stationsArray {
                let station = Station(dictionary: stationItemDict)
                stations += [station]
            }
        }
    }
}

extension City: CustomStringConvertible {
    var description: String {
        return "City(id: \(cityId), title: \(cityTitle), region: \(regionTitle), "
            + "country: \(countryTitle), stations count: \(stations.count), "
            + "point: (\(point.longitude, point.latitude)))"
    }
}
