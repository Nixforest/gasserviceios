//
//  CustomerListRespModel.swift
//  project
//
//  Created by SPJ on 5/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerListRespModel: BaseRespModel {
    /** Record */
    var record: [CustomerBean] = [CustomerBean]()
    
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
                // Menu
                if let recordList = json[DomainConst.KEY_RECORD] as? [[String: AnyObject]] {
                    for item in recordList {
                        self.record.append(CustomerBean(jsonData: item))
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
     * Initializer
     */
    override init() {
        super.init()
    }
    
    /**
     * Get record value.
     * - returns: Record value
     */
    public func getRecord() -> [CustomerBean] {
        return self.record
    }
}
