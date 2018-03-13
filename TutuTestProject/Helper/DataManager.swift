////
////  DataManager.swift
////  TutuTestProject
////
////  Created by Alexey Danilov on 17/11/2017.
////  Copyright © 2017 DanilovDev. All rights reserved.
////
//
//import Foundation
//
//struct DataManager {
//    
//    static func loadData() -> (citiesFrom: [City], citiesTo: [City]) {
//        
//        var citiesFrom = [City]()
//        
//        var citiesTo = [City]()
//        
//        if let filePath = Bundle.main.path(forResource: "allStations", ofType: "json") {
//            let url = URL(fileURLWithPath: filePath)
//            do {
//                let jsonData = try Data(contentsOf: url)
//                do {
//                    if let dict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any> {
//                        
//                        citiesFrom = []
//                        if let citiesArray = dict["citiesFrom" ] as? Array<Any> {
//                            for cityItem in citiesArray {
//                                if let cityDict = cityItem as? Dictionary<String, Any> {
//                                    let newCityFrom = City(dict: cityDict)
//                                    citiesFrom.append(newCityFrom)
//                                }
//                            }
//                        }
//                        
//                        citiesTo = []
//                        if let citiesArray = dict["citiesTo" ] as? Array<Any> {
//                            for cityItem in citiesArray {
//                                if let cityDict = cityItem as? Dictionary<String, Any> {
//                                    let newCityTo = City(dict: cityDict)
//                                    citiesTo.append(newCityTo)
//                                }
//                            }
//                        }
//                    }
//                } catch let error {
//                    print("Error happened when do convertation: \(error)")
//                }
//            } catch let error {
//                print("Error happened when get Data: \(error)")
//            }
//        }
//        return (citiesFrom, citiesTo)
//    }
//    
//}

