//
//  Feed.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 09/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

struct Schedule {
    
    private(set) var citiesFrom = [City]()
    
    private(set) var citiesTo = [City]()
    
    init(dictionary: Dictionary<String, Any> = Dictionary<String, Any>()) {
        if let citiesFromDict = dictionary["citiesFrom"] as? Array<Dictionary<String, Any>> {
            for cityFromDict in citiesFromDict {
                let city = City(dictionary: cityFromDict)
                citiesFrom += [city]
            }
        }
        if let citiesToDict = dictionary["citiesTo"] as? Array<Dictionary<String, Any>> {
            for cityToDict in citiesToDict {
                let city = City(dictionary: cityToDict)
                citiesTo += [city]
            }
        }
    }
}
