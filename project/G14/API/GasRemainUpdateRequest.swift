//
//  GasRemainUpdateRequest.swift
//  project
//
//  Created by SPJ on 1/2/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class GasRemainUpdateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter id:              Id of gas remain
     * - parameter customerId:      Id of customer
     * - parameter date:            Delivery date
     * - parameter orderDetail:     Detail of order
     */
    func setData(id: String, customerId: String,
                 date: String,
                 seri: String,
                 kg_has_gas: String,
                 kg_empty: String,
                 materials_id: String,
                 materials_type_id: String) {
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d,\"%@\":%@,\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":%d}",
            DomainConst.KEY_TOKEN, BaseModel.shared.getUserToken(),
            DomainConst.KEY_ID, id,
            DomainConst.KEY_CUSTOMER_ID, customerId,
            DomainConst.KEY_DATE_INPUT, date,
            DomainConst.KEY_GAS_REMAIN_TYPE, BaseModel.shared.getGasRemainType(),
            DomainConst.KEY_FLAG_GAS_24H, BaseModel.shared.getAppType(),
            DomainConst.KEY_SERI, seri,
            DomainConst.KEY_KG_HAS_GAS, kg_has_gas,
            DomainConst.KEY_KG_EMPTY, kg_empty,
            DomainConst.KEY_MATERIALS_ID, materials_id,
            DomainConst.KEY_MATERIALS_TYPE_ID, materials_type_id,
            DomainConst.KEY_PLATFORM, DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request VIP customer store card list
     * - parameter action:          Action execute when finish this task
     * - parameter view:            Current view
     * - parameter customerId:      Id of customer
     * - parameter date:            Delivery date
     * - parameter orderDetail:     Detail of order
     */
    public static func request(action: Selector, view: BaseViewController,
                               id: String, customerId: String,
                               date: String,
                               seri: String,
                               kg_has_gas: String,
                               kg_empty: String,
                               materials_id: String,
                               materials_type_id: String) {
        let request = GasRemainUpdateRequest(url: G14Const.PATH_VIP_CUSTOMER_GAS_REMAIN_UPDATE,
                                             reqMethod: DomainConst.HTTP_POST_REQUEST,
                                             view: view)
        request.setData(id: id, customerId: customerId,
                        date: date,
                        seri: seri,
                        kg_has_gas: kg_has_gas,
                        kg_empty: kg_empty,
                        materials_id: materials_id,
                        materials_type_id: materials_type_id)
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
