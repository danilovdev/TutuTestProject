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

class StationsViewController: UIViewController {
    
    var tableView: UITableView!
    
    var tableFooter: StationsTableFooter!
    
    var stationSelectionDelegate: StationSelectionDelegate!
    
    var selectedStation: Station!
    
    var stationsMode: StationsMode!
    
    var cities: [City]!
    
    var filteredCities: [City]!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavBar()
        self.configureTableView()
        self.configureSearchController()
        self.configureTableFooter()
    }
    
    func configureTableFooter() {
        self.tableFooter = StationsTableFooter()
        self.view.addSubview(self.tableFooter)
        self.tableFooter.translatesAutoresizingMaskIntoConstraints = false
        self.tableFooter.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableFooter.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableFooter.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableFooter.heightAnchor.constraint(equalToConstant: 64).isActive = true
        self.view.bringSubview(toFront: self.tableFooter)
    }

    func configureNavBar() {
        self.navigationItem.title = "Станции"
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(stationSelectionDone))
        self.navigationItem.setRightBarButton(doneBarButtonItem, animated: false)
    }

    func configureTableView() {
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        
        tableView.reloadData()
    }
    
    func isSearchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return (self.searchController.isActive && !self.isSearchBarIsEmpty())
    }
}

extension StationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isFiltering() {
            self.selectedStation = self.filteredCities[indexPath.section].stations?[indexPath.row]
        } else {
            self.selectedStation = self.cities[indexPath.section].stations?[indexPath.row]
        }
    }
}

extension StationsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.isFiltering() {
            return self.filteredCities.count
        } else {
            return self.cities.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering() {
            if let stations = self.filteredCities[section].stations {
                let filteredStationsCount = self.filteredCities.reduce(0, { (result, city) -> Int in
                    return (result + (city.stations?.count ?? 0))
                })
                let totalStationsCount = self.cities.reduce(0, { (result, city) -> Int in
                    return (result + (city.stations?.count ?? 0))
                })
                self.tableFooter.showResults(filteredStationsCount, totalStationsCount)
                return stations.count
            }
        } else if let stations = self.cities[section].stations {
            self.tableFooter.dismiss()
            return stations.count
        }
        self.tableFooter.dismiss()
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.isFiltering() {
            return "\(self.filteredCities[section].countryTitle ?? ""), \(self.filteredCities[section].cityTitle ?? "Неизвестный город")"
        } else {
            return "\(self.cities[section].countryTitle ?? ""), \(self.cities[section].cityTitle ?? "Неизвестный город")"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
}

extension StationsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        self.filterContent(searchText: searchText!)
    }
}
