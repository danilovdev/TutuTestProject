//
//  AppDelegate.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 16/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let coreDataManager = CoreDataManager(modelName: "TutuTestProject")
    
    lazy var aboutNavController: UINavigationController = {
        let aboutVC = AboutViewController()
        let aboutNavController = UINavigationController(rootViewController: aboutVC)
        return aboutNavController
    }()
    
    lazy var scheduleNavController: UINavigationController = {
        let sheduleVC = ScheduleViewController()
//        sheduleVC.data = DataManager.loadData()
        let scheduleNavController = UINavigationController(rootViewController: sheduleVC)
        scheduleNavController.navigationBar.prefersLargeTitles = true
        return scheduleNavController
    }()
    
    lazy var tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [scheduleNavController, aboutNavController]
        tabBarController.tabBar.items![0].title = Constants.TabBarConfig.Schedule.name
        tabBarController.tabBar.items![0].image = UIImage(named: Constants.TabBarConfig.Schedule.image)?.af_imageAspectScaled(toFit: CGSize(width: 30, height: 30))
        tabBarController.tabBar.items![1].title = Constants.TabBarConfig.About.name
        tabBarController.tabBar.items![1].image = UIImage(named: Constants.TabBarConfig.About.image)?.af_imageAspectScaled(toFit: CGSize(width: 30, height: 30))
        return tabBarController
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        configureStatusBar()
        configureTabBarAppearance()
        configureNavBarAppearance()
        configureRootController()
        
        importJSONSeedDataIfNeeded()
        
        return true
    }
    
    private func configureStatusBar() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func configureNavBarAppearance() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.isTranslucent = false
        navBarAppearance.tintColor = UIColor.white
        navBarAppearance.barTintColor = UIColor.blue
        let font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        navBarAppearance.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: font
        ]
        navBarAppearance.largeTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
    }
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.isTranslucent = false
    }
    
    private func configureRootController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
    }
    
    private func importJSONSeedDataIfNeeded() {
        let fetchRequest = NSFetchRequest<City>(entityName: "City")

        do {
            let count = try coreDataManager.manageObjectContext.count(for: fetchRequest)

            guard count == 0 else {
                return
            }
        } catch let error as NSError {
            print("Error fetching: \(error), \(error.userInfo)")
        }

        do {
           let results = try coreDataManager.manageObjectContext.fetch(fetchRequest)
            results.forEach {
                coreDataManager.manageObjectContext.delete($0)
            }
            coreDataManager.saveContext()
            importJSONSeedData()
        } catch let error as NSError {
            print("Error fetching: \(error), \(error.userInfo)")
        }
    }
    
    private func importJSONSeedData() {
        guard let jsonUrl = Bundle.main.url(forResource: "allStations", withExtension: "json") else {
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            let decoder = JSONDecoder()
            
            guard let contextUserInfoKey = CodingUserInfoKey.context else {
                fatalError()
            }
            
            decoder.userInfo[contextUserInfoKey] = coreDataManager.manageObjectContext
            let dataSource = try decoder.decode(DataSource.self, from: jsonData)
            
            coreDataManager.saveContext()
            
        } catch let error as NSError {
            print("Error importing data: \(error), \(error.userInfo)")
        }
    }
}
