//
//  ScheduleViewController.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 09/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dict = Dictionary<String, Any>()
        let city = City(dictionary: dict)
        let a = city.districtTitle
//        print(a?.append(<#T##other: String##String#>))
    }
}
