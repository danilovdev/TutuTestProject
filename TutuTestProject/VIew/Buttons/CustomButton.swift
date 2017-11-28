//
//  CustomButton.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 29/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
}

extension CustomButton {
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                self.layer.borderColor = UIColor.lightGray.cgColor
            case false:
                self.layer.borderColor = self.currentTitleColor.cgColor
            }
        }
    }
}
