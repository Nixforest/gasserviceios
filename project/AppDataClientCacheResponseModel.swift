//
//  AppDataClientCacheResponseModel.swift
//  project
//
//  Created by SPJ on 8/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class AppDataClientCacheResponseModel: BaseRespModel {
    /** Record */
    var record: [OrderDetailBean] = [OrderDetailBean]() 
    
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
                // Record
                if let recordList: [[String: AnyObject]] = json[DomainConst.KEY_CACHE_MODULE] as? [[String : AnyObject]]{
                    for item in recordList {
                        self.record.append(OrderDetailBean(jsonData: item))
                    }
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
    public func getRecord() -> [OrderDetailBean] {
        return self.record
    }
    
    /**
     * Append list of record
     * - parameter contentOf: List of record
     */
    public func append(contentOf: [OrderDetailBean]) {
        self.record.append(contentsOf: contentOf)
    }
    
    /**
     * Remove all data
     */
    public func clearData() {
        self.record.removeAll()
    }
}
