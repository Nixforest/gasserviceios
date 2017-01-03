//
//  OrderViewRespModel.swift
//  project
//
//  Created by SPJ on 12/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderViewRespModel: BaseRespModel {
    /** Record */
    var record: OrderBean = OrderBean()
    
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
                
                if self.status != "1" {
                    return
                }
                
                // Record
                let order = json[DomainConst.KEY_RECORD] as? [String: AnyObject]
                
                self.record = OrderBean(jsonData: order!)
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        } else {
            print("json is of wrong format")
        }
    }
    
    /**
     * Get record value.
     * - returns: Record value
     */
    public func getRecord() -> OrderBean {
        return self.record
    }
}
