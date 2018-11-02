//
//  OrderVIPCreateByCoordinatorRespModel.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class OrderVIPCreateByCoordinatorRespModel: BaseRespModel {
    /** Record */
    var id: String = DomainConst.BLANK
    
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
                
                // Id
                self.id = getString(json: json, key: DomainConst.KEY_ID)
            } catch let error as NSError {
                print(DomainConst.JSON_ERR_FAILED_LOAD + "\(error.localizedDescription)")
            }
            
        } else {
            print(DomainConst.JSON_ERR_WRONG_FORMAT)
        }
    }
}
