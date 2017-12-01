//
//  PointCoordinates.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 17/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

struct PointCoordinates {
    var longitude: CGFloat?
    var latitude: CGFloat?
    init(dict: Dictionary<String, Any>) {
        if let longitude = dict["longitude"] as? CGFloat {
            self.longitude = longitude
        }
        if let latitude = dict["latitude"] as? CGFloat {
            self.latitude = latitude
        }
    }
    
    func description() -> String {
        var longitudeStr = "Неизвестно"
        var latitudeStr = "Неизвестно"
        if let longitude = self.longitude {
           longitudeStr = String(format: "%.4f", Double(longitude))
        }
        if let latitude = self.latitude {
            latitudeStr = String(format: "%.4f", Double(latitude))
        }
        return "Долгота: \(longitudeStr), Широта: \(latitudeStr)"
    }
}
