//
//  AppDelegate.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 09/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        parseJson()
        
        return true
    }
    
    private func parseJson() {
        if let jsonObject = JSONParsingService.instance.parseJSONData(from: "allStations") {
            let schedule = Schedule(dictionary: jsonObject)
            GlobalValues.schedule = schedule
            print(GlobalValues.schedule.citiesFrom[22])
            print(GlobalValues.schedule.citiesFrom[22].stations[1])
        }
    }

}

