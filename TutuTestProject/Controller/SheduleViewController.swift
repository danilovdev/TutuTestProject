//
//  SheduleViewController.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 18/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

class SheduleViewController: UITableViewController {
    
    var selectFromStationCell = UITableViewCell()
    
    var selectToStationCell = UITableViewCell()
    
    var selectDateCell = UITableViewCell()
    
    var submitButtonCell = UITableViewCell()
    
    let dateTextInput = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    override func loadView() {
        super.loadView()
        
        self.selectFromStationCell.accessoryType = .disclosureIndicator
        self.selectFromStationCell.textLabel?.text = "Выберите станцию отправления"
        
        self.selectToStationCell.accessoryType = .disclosureIndicator
        self.selectToStationCell.textLabel?.text = "Выберите станцию прибытия"
        
        self.selectDateCell.contentView.addSubview(self.dateTextInput)
        
        self.submitButtonCell.textLabel?.text = "Найти"
        self.submitButtonCell.textLabel?.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Расписание"
        self.configureNavBar()
        self.configureTableView()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureNavBar() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func configureTableView() {
        self.tableView.tableFooterView = UIView()
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
            self.pushStationsVC()
        case 1:
            self.pushStationsVC()
        case 2:
            self.showDatePicker()
        case 3:
            print("Success")
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.lightGray
    }
    
    func pushStationsVC() {
        self.hidesBottomBarWhenPushed = true
        let stationsVC = StationsViewController()
        self.navigationController?.pushViewController(stationsVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    func showDatePicker() {
        let datePicker = UIDatePicker()
        let toolbar = self.createDatePickerToolbar()
        self.dateTextInput.inputView = datePicker
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
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    
}
