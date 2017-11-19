//
//  StationsViewController.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 18/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

protocol StationSelectionDelegate {
    func didSelectStation(station: Station, mode: StationsMode)
}

class StationsViewController: UITableViewController {
    
    var stationSelectionDelegate: StationSelectionDelegate!
    
    var selectedStation: Station!
    
    var stationsMode: StationsMode!
    
    var cities: [City]!
    
    var filteredCities: [City]!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Станции"

        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(stationSelectionDone))
        self.navigationItem.setRightBarButton(doneBarButtonItem, animated: false)
        
        self.configureSearchController()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.isFiltering() {
            return self.filteredCities.count
        } else {
            return self.cities.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.isFiltering() {
            return self.filteredCities[section].cityTitle
        } else {
            return "\(self.cities[section].countryTitle), \(self.cities[section].cityTitle)"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering() {
            if let stations = self.filteredCities[section].stations {
                return stations.count
            }
        } else if let stations = self.cities[section].stations {
            return stations.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let stationTitle: String?
        if self.isFiltering() {
            stationTitle = self.filteredCities[indexPath.section].stations?[indexPath.row].stationTitle
        } else {
            stationTitle = self.cities[indexPath.section].stations?[indexPath.row].stationTitle
        }
        
        cell.textLabel?.text = stationTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedStation = self.cities[indexPath.section].stations?[indexPath.row]
//        self.showStationDetails()
    }
    
    @objc func stationSelectionDone() {
        self.stationSelectionDelegate.didSelectStation(station: self.selectedStation, mode: self.stationsMode)
        self.navigationController?.popViewController(animated: true)
    }
    
    func showStationDetails() {
        let stationDetailsVC = StationDetailsViewController()
        stationDetailsVC.station = self.selectedStation
        self.navigationController?.pushViewController(stationDetailsVC, animated: true)
    }
    
    func configureSearchController() {
        self.definesPresentationContext = true
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Найти станцию"
        self.navigationItem.searchController = self.searchController
    }
    
    func filterContent(searchText: String) {
        
        self.filteredCities = self.cities.map({ city -> City? in
            if let stations = city.stations {
                let filteredStations = stations.filter({ station  -> Bool in
                    if let stationTitle = station.stationTitle {
                        return stationTitle.lowercased().contains(searchText.lowercased())
                    }
                    return false
                })
                if filteredStations.count == 0 {
                    return nil
                }
                var filteredCity = city
                filteredCity.stations = filteredStations
                return filteredCity
            }
            return nil
        }).flatMap { $0 }
        
//        self.filteredCities = self.cities.filter({ city -> Bool in
//            if let cityTitle = city.cityTitle {
//                return cityTitle.lowercased().contains(searchText.lowercased())
//            }
//            return false
//        })
        
        tableView.reloadData()
    }
    
    func isSearchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return (self.searchController.isActive && !self.isSearchBarIsEmpty())
    }
}

extension StationsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        self.filterContent(searchText: searchText!)
    }
}
