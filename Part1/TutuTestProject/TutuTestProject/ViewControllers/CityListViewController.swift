//
//  StationListViewController.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 11/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {
    
    // MARK: - Inner Types
    enum CityType {
        case from
        case to
    }
    
    // MARK: - Properties
    private var isLoading = false
    
    private let cellId = "StationCell"
    
    private var cityList = [City]()
    
    private var currentCitiesFromIndexPath = IndexPath(item: 0, section: 0)
    
    private var currentCitiesToIndexPath = IndexPath(item: 0, section: 0)
    
    private var schedule = Schedule() {
        didSet {
            reloadSegmentedControl(schedule: schedule)
            reloadTableViewData(schedule: schedule)
        }
    }
    
    private var selectedCityType: CityType = .from {
        didSet {
            reloadTableViewData(schedule: schedule)
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.alpha = 0.0
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - IBActions
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedCityType = .from
        } else if sender.selectedSegmentIndex == 1 {
            selectedCityType = .to
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getSchedule()
    }
    
    // MARK: - Main Logic
    private func reloadSegmentedControl(schedule: Schedule) {
        guard !isLoading else { return }
        DispatchQueue.main.async {
            let citiesFromCount = schedule.citiesFrom.count
            if let fromTitle = self.segmentedControl.titleForSegment(at: 0),
                citiesFromCount > 0 {
                self.segmentedControl.setTitle("\(fromTitle) \(citiesFromCount)", forSegmentAt: 0)
            }
            let citiesToCount = schedule.citiesTo.count
            if let toTitle = self.segmentedControl.titleForSegment(at: 1),
                citiesToCount > 0 {
                self.segmentedControl.setTitle("\(toTitle) \(citiesToCount)", forSegmentAt: 1)
            }
        }
    }
    
    private func reloadTableViewData(schedule: Schedule) {
        guard !isLoading else { return }
        DispatchQueue.main.async {
            let isFrom = self.selectedCityType == .from
            self.cityList = isFrom ? schedule.citiesFrom : schedule.citiesTo
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: isFrom ? self.currentCitiesFromIndexPath : self.currentCitiesToIndexPath, at: .top, animated: true)
        }
    }
    
    private func getSchedule() {
        isLoading = true
        activityIndicator.startAnimating()
        JSONParsingService.instance.getSchedule { [unowned self] schedule in
            self.isLoading = false
            self.schedule = schedule
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.6, animations: {
                    self.tableView.alpha = 1.0
                })
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource
extension CityListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let city = cityList[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1) \(city.cityTitle)"
        cell.detailTextLabel?.text = city.countryTitle
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension CityListViewController: UITableViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = tableView.indexPathsForVisibleRows?.first {
            if selectedCityType == .from {
                currentCitiesFromIndexPath = indexPath
            } else {
                currentCitiesToIndexPath = indexPath
            }
        }
    }
}
