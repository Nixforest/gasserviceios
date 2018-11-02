//
//  WorkingReportViewRespModel.swift
//  project
//
//  Created by SPJ on 3/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class WorkingReportViewRespModel: BaseRespModel {
    /** Record */
    var record: WorkingReportBean = WorkingReportBean()
    
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
                let str = json[DomainConst.KEY_MODEL_RECORD] as? [String: AnyObject]
                self.record = WorkingReportBean(jsonData: str!)
            } catch let error as NSError {
                print(DomainConst.JSON_ERR_FAILED_LOAD + "\(error.localizedDescription)")
            }
            
        } else {
            print(DomainConst.JSON_ERR_WRONG_FORMAT)
        }
    }
    /**
     * Default constructor
     */
    override public init() {
        super.init()
    }
}
