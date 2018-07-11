//
//  JSONParsingService.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 09/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//
import Foundation

class JSONParsingService {
    
    typealias ScheduleCompletion = (Schedule) -> Void
    
    typealias JSONDictionary = [String: Any]
    
    static let instance = JSONParsingService()
    
    private func parseJSONData(from file: String) -> JSONDictionary? {
        guard let jsonUrl = Bundle.main.url(forResource: file, withExtension: "json") else { return nil }
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? JSONDictionary {
                return jsonObject
            }
        } catch let error {
            print("Error happened when parsing json: \(error.localizedDescription)")
        }
        return nil
    }
    
    func getSchedule(completion: @escaping ScheduleCompletion) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            sleep(3)
            if let jsonObject = strongSelf.parseJSONData(from: "allStations") {
                let schedule = Schedule(dictionary: jsonObject)
                completion(schedule)
            }
        }
    }
}
