//
//  StoreCardViewRespModel.swift
//  project
//
//  Created by SPJ on 5/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class StoreCardViewRespModel: BaseRespModel {
    /** Record */
    var record: StoreCardBean = StoreCardBean()
    
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
                
                // Record
                self.record = StoreCardBean(jsonData: (json[DomainConst.KEY_RECORD] as? [String: AnyObject])!)
            } catch let error as NSError {
                print(DomainConst.JSON_ERR_FAILED_LOAD + "\(error.localizedDescription)")
            }
            
        } else {
            print(DomainConst.JSON_ERR_WRONG_FORMAT)
        }
    }
}
