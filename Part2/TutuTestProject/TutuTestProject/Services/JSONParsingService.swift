//
//  JSONParsingService.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 09/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//
import UIKit

class JSONParsingService {
    
    static let instance = JSONParsingService()
    
    func parseJSONData(from file: String) -> [String: Any]? {
        guard let jsonUrl = Bundle.main.url(forResource: file, withExtension: "json") else { return nil }
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return jsonObject
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
