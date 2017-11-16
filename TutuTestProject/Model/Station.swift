//
//  Station.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 17/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation

class Station {
    
    var countryTitle: String?
    
    var point: PointCoordinates?
    
    var districtTitle: String?
    
    var cityId: Int?
    
    var cityTitle: String?
    
    var regionTitle: String?
    
    var stationId: Int?
    
    var stationTitle: String?
    
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
        
        if let stationId = dict["stationId"] as? Int {
            self.stationId = stationId
        }
        
        if let stationTitle = dict["stationTitle"] as? String {
            self.stationTitle = stationTitle
        }
    }
}
