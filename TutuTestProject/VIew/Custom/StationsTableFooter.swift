//
//  StationsTableFooter.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 27/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

class StationsTableFooter: UIView {
    
    let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure() {
        self.backgroundColor = UIColor.blue
//        self.alpha = 0.0
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.textAlignment = .center
//        self.addSubview(self.titleLabel)
    }
    
//    override func draw(_ rect: CGRect) {
////        self.titleLabel.frame = self.bounds
//    }
    
    
    private func hide() {
        UIView.animate(withDuration: 0.6) {
            self.alpha = 0.0
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.6) {
            self.alpha = 1.0
        }
    }
    
    func showResults() {
        self.show()
    }
    
    func dismiss() {
        
    }
}
