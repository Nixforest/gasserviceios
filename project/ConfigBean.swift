//
//  ConfigBean.swift
//  project
//
//  Created by Nixforest on 9/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class ConfigBean: NSObject {
    /** Id of item */
    var id: String = ""
    /** Name of item */
    var name: String = ""
    /** Data of item */
    var data = [ConfigBean]()
    
    /**
     * Initializer
     * - parameter id: Id of item
     * - parameter name: Name of item
     */
    init(id: String, name: String) {
        super.init()
        self.id = id
        self.name = name
    }
    
    /**
     * Initializer
     * - parameter id: Id of item
     * - parameter name: Name of item
     * - parameter data: List of data
     */
    init(id: String, name: String, data: [ConfigBean]) {
        super.init()
        self.id = id
        self.name = name
        self.data = data
    }
    
    /**
     * Initializer
     * - parameter jsonString: Json string to parse
     */
    init(jsonString: String) {
        super.init()
        if let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                
                // Loop
                for (key, value) in json {
                    let keyName = key as String
                    if let keyValue = value as? String {
                        // If property exists
                        if (self.responds(to: NSSelectorFromString(keyName))) {
                            self.setValue(keyValue, forKey: keyName)
                        }
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        } else {
            print("json is of wrong format")
        }
    }
    init(jsonData: [String: AnyObject]) {
        if let idStr = jsonData["id"] as? String {
            self.id = idStr
        } else {
            if let idInt = jsonData["id"] as? Int {
                self.id = String(idInt)
            }
        }
        if let nameStr = jsonData["name"] as? String  {
            self.name = nameStr
        }
        if let dataArr = jsonData["data"] as? [[String: AnyObject]] {
            for listItem in dataArr {
                self.data.append(ConfigBean(jsonData: listItem))
            }
        }
    }
}
