//
//  TempDataRespModel.swift
//  project
//
//  Created by SPJ on 5/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class TempDataRespModel: BaseRespModel {
    /** Record */
    private static var record: TempDataModel = TempDataModel()
    
    /**
     * Default constructor
     */
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
                TempDataRespModel.record = TempDataModel(jsonData: (json[DomainConst.KEY_RECORD] as? [String: AnyObject])!)
            } catch let error as NSError {
                print(DomainConst.JSON_ERR_FAILED_LOAD + "\(error.localizedDescription)")
            }
            
        } else {
            print(DomainConst.JSON_ERR_WRONG_FORMAT)
        }
    }
    
    /**
     * Get temp data
     * - returns: Temp data object
     */
    public static func getData() -> TempDataModel {
        return TempDataRespModel.record
    }
    
    /**
     * Check if temp data is empty
     * - returns: True if list agent is empty, False otherwise
     */
    public static func isEmpty() -> Bool {
        return TempDataRespModel.record.data.isEmpty
    }
}
