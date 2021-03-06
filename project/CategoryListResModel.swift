//
//  CategoryListResModel.swift
//  project
//
//  Created by SPJ on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class CategoryListResModel: BaseRespModel {
    /** Total record */
    var total_record: Int = 0
    /** Total page */
    var total_page: Int = 0
    /** Record */
    var record: [ConfigBean] = [ConfigBean]() 
    
    override init() {
        super.init()
    }
    
    /**
     * Initializer
     */
    override init(jsonString: String) {
        // Call super initializer
        super.init(jsonString: jsonString)
        
        // Start parse
        if let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                
                if self.status != DomainConst.RESPONSE_STATUS_SUCCESS {
                    return
                }
                // Total record
                self.total_record = getIntFromString(json: json, key: DomainConst.KEY_TOTAL_RECORD)
                // Total page
                self.total_page = getInt(json: json, key: DomainConst.KEY_TOTAL_PAGE)
                
                // Record
                let recordList = json[DomainConst.KEY_RECORD] as? [[String: AnyObject]]
                for item in recordList! {
                    self.record.append(ConfigBean(jsonData: item))
                }
            } catch let error as NSError {
                print(DomainConst.JSON_ERR_FAILED_LOAD + "\(error.localizedDescription)")
            }
            
        } else {
            print(DomainConst.JSON_ERR_WRONG_FORMAT)
        }
    }
    
    /**
     * Get record value.
     * - returns: Record value
     */
    public func getRecord() -> [ConfigBean] {
        return self.record
    }
    
    /**
     * Append list of record
     * - parameter contentOf: List of record
     */
    public func append(contentOf: [ConfigBean]) {
        self.record.append(contentsOf: contentOf)
    }
    
    /**
     * Remove all data
     */
    public func clearData() {
        self.record.removeAll()
        self.total_page = 0
        self.total_record = 0
    }
}
