//
//  OrderListRespModel.swift
//  project
//
//  Created by SPJ on 12/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

public class OrderListRespModel: BaseRespModel {
    /** Total record */
    var total_record: Int = 0
    /** Total page */
    var total_page: Int = 0
    /** Record */
    var record: [OrderListBean] = [OrderListBean]()
    
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
                // Total record
                let totalRecord = json[DomainConst.KEY_TOTAL_RECORD] as? String ?? ""
                if totalRecord != "" {
                    self.total_record = Int(totalRecord)!
                }
                // Total page
                self.total_page = json[DomainConst.KEY_TOTAL_PAGE] as? Int ?? 0
                
                // Record
                let recordList = json[DomainConst.KEY_RECORD] as? [[String: AnyObject]]
                for uphold in recordList! {
                    self.record.append(OrderListBean(jsonData: uphold))
                }
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
    public func getRecord() -> [OrderListBean] {
        return self.record
    }
}
