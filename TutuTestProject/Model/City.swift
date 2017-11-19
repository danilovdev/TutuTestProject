//
//  City.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 17/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation

struct City {
    
    var countryTitle: String?
    
    var point: PointCoordinates?
    
    var districtTitle: String?
    
    var cityId: Int?
    
    var cityTitle: String?
    
    var regionTitle: String?
    
    var stations: [Station]?
    
    init(dict: Dictionary<String, Any>) {
        if let countryTitle = dict["countryTitle"] as? String {
            self.countryTitle = countryTitle
        }
        
        if let pointDict = dict["point"] as? Dictionary<String, Any> {
            self.point = PointCoordinates(dict: pointDict)
        }
        
        if let districtTitle = dict["districtTitle"] as? String {
            self.districtTitle = districtTitle
        }
        
        if let cityId = dict["cityId"] as? Int {
            self.cityId = cityId
        }
        
        if let cityTitle = dict["cityTitle"] as? String {
            self.cityTitle = cityTitle
        }
        
        if let regionTitle = dict["regionTitle"] as? String {
            self.regionTitle = regionTitle
        }
        
        self.stations = []
        if let stationsArray = dict["stations"] as? Array<Any> {
            for item in stationsArray {
                if let stationDict = item as? Dictionary<String, Any> {
                    let station = Station(dict: stationDict)
                    self.stations?.append(station)
                }
            }
        }
    }
}

