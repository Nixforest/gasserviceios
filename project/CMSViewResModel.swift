//
//  CMSViewResModel.swift
//  project
//
//  Created by SPJ on 10/7/18.
//  Copyright © 2018 admin. All rights reserved.
//
import UIKit
import harpyframework

class CMSViewResModel: BaseRespModel {
    var record: CMSListBean = CMSListBean() 
    
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
                if let str = json[DomainConst.KEY_RECORD] as? [String: AnyObject]{
                    self.record = CMSListBean(jsonData: str)
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
    public func getRecord() -> CMSListBean {
        return self.record
    }

}
