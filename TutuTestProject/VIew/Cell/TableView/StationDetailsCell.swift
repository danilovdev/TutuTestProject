//
//  StationDetailsCell.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 01.12.17.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit

class StationDetailsCell: UITableViewCell {
    
    @IBOutlet var propertyNameLabel: UILabel!
    
    @IBOutlet var propertyValueLabel: UILabel!
    
    func configure(property : (name: String, value: String)) {
        self.propertyNameLabel.text = property.name
        self.propertyValueLabel.text = property.value
    }
    
}
