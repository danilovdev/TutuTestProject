//
//  StationDetailsViewController.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 19/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit

class StationDetailsViewController: UITableViewController {
    
    var stationsMode: StationsMode!
    
    var stationSelectionDelegate: StationSelectionDelegate!
    
    var station: Station!
    
    let tableFooterView: UIView = {
       let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        container.backgroundColor = UIColor.blue
        let selectButton = CustomButton(type: UIButtonType.system)
        selectButton.setTitle("Выбрать", for: .normal)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.layer.cornerRadius = 6.0
        selectButton.layer.borderColor = UIColor.white.cgColor
        selectButton.layer.borderWidth = 1.0
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(selectButton)
        
        selectButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        selectButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        selectButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        
        return container
    }()
    
    @objc func selectButtonTapped() {
        self.stationSelectionDelegate.didSelectStation(station: self.station, mode: self.stationsMode)
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Информация"
        
        let titleLabel = UILabel()
        titleLabel.text = "TuTu.ru"
        titleLabel.font = titleLabel.font.withSize(26)
        titleLabel.font = titleLabel.font.boldItalic
        titleLabel.textColor = .white
        self.navigationItem.titleView = titleLabel
        
        self.tableView.register(UINib.init(nibName: "StationDetailsCell", bundle: nil), forCellReuseIdentifier: "StationDetailsCell")
        self.tableView.tableFooterView = self.tableFooterView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationDetailsCell", for: indexPath) as! StationDetailsCell
        switch indexPath.row {
        case 0:
            cell.configure(property: ("Название", self.analyzeValue(self.station.stationTitle)))
        case 1:
            cell.configure(property: ("Страна", self.analyzeValue(self.station.countryTitle)))
        case 2:
            cell.configure(property: ("Регион", self.analyzeValue(self.station.regionTitle)))
        case 3:
            cell.configure(property: ("Город", self.analyzeValue(self.station.cityTitle)))
        case 4:
            cell.configure(property: ("Район", self.analyzeValue(self.station.districtTitle)))
        case 5:
            cell.configure(property: ("Координаты", self.station.point?.description() ?? "Неизвестно"))
        default:
            break
        }
        return cell
    }
    
    func analyzeValue(_ value: String?) -> String {
        guard let unwrappedValue = value else {
            return "Неизвестно"
        }
        
        guard unwrappedValue.count > 0 else {
            return "Неизвестно"
        }
        return unwrappedValue
    }
}
