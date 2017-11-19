//
//  SheduleViewController.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 18/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

enum StationsMode {
    case from
    case to
}

class ScheduleViewController: UITableViewController {
    
    var data: (citiesFrom: [City], citiesTo: [City])!
    
    var selectFromStationCell = UITableViewCell()
    
    var selectToStationCell = UITableViewCell()
    
    var selectDateCell = UITableViewCell()
    
    var submitButtonCell = UITableViewCell()
    
    let dateTextInput = UITextField()
    
    let datePicker = UIDatePicker()
    
    override func loadView() {
        super.loadView()
        
        let titleView = UIView()
        titleView.backgroundColor = UIColor.red
        self.navigationItem.titleView = titleView
        
        
        self.selectFromStationCell.accessoryType = .disclosureIndicator
        self.selectFromStationCell.textLabel?.numberOfLines = 0
        self.selectFromStationCell.textLabel?.text = "Выберите станцию отправления"
        
        self.selectToStationCell.accessoryType = .disclosureIndicator
        self.selectToStationCell.textLabel?.numberOfLines = 0
        self.selectToStationCell.textLabel?.text = "Выберите станцию прибытия"
        
        self.selectDateCell.selectionStyle = .none
        self.dateTextInput.borderStyle = .roundedRect
        self.dateTextInput.placeholder = "Выберите дату"
        self.selectDateCell.contentView.addSubview(self.dateTextInput)
        
        self.submitButtonCell.textLabel?.text = "Найти"
        self.submitButtonCell.textLabel?.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Расписание"
        self.configureNavBar()
        self.configureTableView()
        self.configureDatePicker()
        
        self.dateTextInput.translatesAutoresizingMaskIntoConstraints = false
        self.selectDateCell.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[v0]-15-|",
                                                                          options: NSLayoutFormatOptions(),
                                                                          metrics: nil,
                                                                          views: ["v0" : self.dateTextInput]))
        self.selectDateCell.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|",
                                                                          options: NSLayoutFormatOptions(),
                                                                          metrics: nil,
                                                                          views: ["v0" : self.dateTextInput]))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureNavBar() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func configureTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Станция Отправления"
        case 1:
            return "Станция Прибытия"
        case 2:
            return "Дата"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return self.selectFromStationCell
        case 1:
            return self.selectToStationCell
        case 2:
            return self.selectDateCell
        case 3:
            return self.submitButtonCell
        default:
            fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.pushStationsVC(mode: StationsMode.from)
        case 1:
            self.pushStationsVC(mode: StationsMode.to)
        case 2:
            print("Success")
        case 3:
            print("Success")
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.lightGray
    }
    
    func pushStationsVC(mode: StationsMode) {
        self.hidesBottomBarWhenPushed = true
        let stationsVC = StationsViewController()
        var cities: [City]!
        mode == .from ? (cities = self.data.citiesFrom) : (cities = self.data.citiesTo)
        stationsVC.cities = cities
        stationsVC.stationsMode = mode
        stationsVC.stationSelectionDelegate = self
        self.navigationController?.pushViewController(stationsVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    func configureDatePicker() {
        
        let toolbar = self.createDatePickerToolbar()
        self.dateTextInput.inputView = self.datePicker
        self.dateTextInput.inputAccessoryView = toolbar
    }
    
    func createDatePickerToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.tintColor = .black
        toolbar.barStyle = .default
        toolbar.isTranslucent = false
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(datePickerDoneTapped))
        toolbar.setItems([spaceButton, doneButton], animated: false)
        return toolbar
    }
    
    @objc func datePickerDoneTapped() {
        self.view.endEditing(true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        self.dateTextInput.text = dateFormatter.string(from: self.datePicker.date)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    
}

extension ScheduleViewController: StationSelectionDelegate {
    
    func didSelectStation(station: Station, mode: StationsMode) {
        if mode == .from {
            self.selectFromStationCell.textLabel?.text = station.stationTitle
        } else if mode == .to {
            self.selectToStationCell.textLabel?.text = station.stationTitle
        }
    }
}