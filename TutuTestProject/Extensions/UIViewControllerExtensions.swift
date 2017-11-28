//
//  UIViewControllerExtensions.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 28/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
