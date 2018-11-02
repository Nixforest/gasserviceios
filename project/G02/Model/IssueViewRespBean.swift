//
//  IssueViewRespBean.swift
//  project
//
//  Created by Pham Trung Nguyen on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class IssueViewRespBean: BaseRespModel {
    /** model_issue */
    var model_issue:             IssueBean = IssueBean()
    
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
                if let record = json[DomainConst.KEY_MODEL_ISSUE] as? [String: AnyObject] {
                    self.model_issue = IssueBean(jsonData: record)
                }
            } catch let error as NSError {
                print(DomainConst.JSON_ERR_FAILED_LOAD + "\(error.localizedDescription)")
            }
        } else {
            print(DomainConst.JSON_ERR_WRONG_FORMAT)
        }
    }
}
