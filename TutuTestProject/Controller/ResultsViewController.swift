//
//  ResultsViewController.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 27/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var fromStation: Station!
    
    var toStation: Station!
    
    var scheduleDate: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Результаты"
        self.view.backgroundColor = .white
        let shareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        self.navigationItem.rightBarButtonItem = shareBarButtonItem
        
        let titleLabel = UILabel()
        titleLabel.text = "TuTu.ru"
        titleLabel.font = titleLabel.font.withSize(26)
        titleLabel.font = titleLabel.font.boldItalic
        titleLabel.textColor = .white
        self.navigationItem.titleView = titleLabel
    }
    
    @objc func shareButtonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let scheduleDateStr = dateFormatter.string(from: self.scheduleDate)
        let array = [
            self.fromStation.stationTitle,
            self.toStation.stationTitle,
            scheduleDateStr
        ]
        let activityVC = UIActivityViewController(activityItems: array, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }

}
