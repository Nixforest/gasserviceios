//
//  CustomerFamilyCreateRequest.swift
//  project
//  P032_CustomerFamilyCreate_API
//  Created by SPJ on 3/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class CustomerFamilyCreateRequest: BaseRequest {
    /**
     * Set data content
     * - parameter phone:           Customer phone
     * - parameter customerBrand:   Current gas brand
     * - parameter province_id:     Id of Province
     * - parameter hgd_type:        Type of customer
     * - parameter district_id:     Id of District
     * - parameter ward_id:         Id of Ward
     * - parameter agent_id:        Id of Agent
     * - parameter hgd_time_use:    Time use gas
     * - parameter street_id:       Id of Street
     * - parameter first_name:      Name of customer
     * - parameter house_numbers:   House number
     * - parameter list_hgd_invest:
     * - parameter longitude:       Longitude
     * - parameter latitude:        Latitude
     * - parameter serial:          Serial
     * - parameter hgd_doi_thu:     Opposite brand
     * - parameter ccsCode:         CCS code
     */
    func setData(phone: String, customerBrand: String,
                 province_id: String, hgd_type: String,
                 district_id: String, ward_id: String,
                 agent_id: String, hgd_time_use: String,
                 //++ BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
                 //version_code: String,
                 //-- BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
                 street_id: String,
                 first_name: String, house_numbers: String,
                 list_hgd_invest: String, longitude: String,
                 latitude: String, serial: String,
                 hgd_doi_thu: String,
                 //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
                 ccsCode: String) {
                 //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        self.data = "q=" + String.init(
            format: "{\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":[%@],\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%@\",\"%@\":\"%d\"}",
            DomainConst.KEY_TOKEN,                  BaseModel.shared.getUserToken(),
            DomainConst.KEY_PHONE,                  phone,
            DomainConst.KEY_CUSTOMER_FAMILY_BRAND,  customerBrand,
            DomainConst.KEY_PROVINCE_ID,            province_id,
            DomainConst.KEY_HGD_TYPE,               hgd_type,
            DomainConst.KEY_DISTRICT_ID,            district_id,
            DomainConst.KEY_WARD_ID,                ward_id,
            DomainConst.KEY_AGENT_ID,               agent_id,
            DomainConst.KEY_HGD_TIME_USE,           hgd_time_use,
            //++ BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
            //DomainConst.KEY_VERSION_CODE,           version_code,
            //-- BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
            DomainConst.KEY_STREET_ID,              street_id,
            DomainConst.KEY_FIRST_NAME,             first_name,
            DomainConst.KEY_HOUSE_NUMBER,           house_numbers,
            DomainConst.KEY_LIST_HGD_INVEST,        list_hgd_invest,
            DomainConst.KEY_LONGITUDE,              longitude,
            DomainConst.KEY_LATITUDE,               latitude,
            DomainConst.KEY_SERIAL,                 serial,
            DomainConst.KEY_HGD_DOI_THU,            hgd_doi_thu,
            //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
            DomainConst.KEY_MENU_CCS_CODE,          ccsCode,
            //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
            DomainConst.KEY_PLATFORM,               DomainConst.PLATFORM_IOS
        )
    }
    
    /**
     * Request create customer family
     * - parameter action:      Action execute when finish this task
     * - parameter view:        Current view
     * - parameter phone:           Customer phone
     * - parameter customerBrand:   Current gas brand
     * - parameter province_id:     Id of Province
     * - parameter hgd_type:        Type of customer
     * - parameter district_id:     Id of District
     * - parameter ward_id:         Id of Ward
     * - parameter agent_id:        Id of Agent
     * - parameter hgd_time_use:    Time use gas
     * - parameter street_id:       Id of Street
     * - parameter first_name:      Name of customer
     * - parameter house_numbers:   House number
     * - parameter list_hgd_invest:
     * - parameter longitude:       Longitude
     * - parameter latitude:        Latitude
     * - parameter serial:          Serial
     * - parameter hgd_doi_thu:     Opposite brand
     * - parameter ccsCode:         CCS code
     */
    public static func request(action: Selector,
                                                 view: BaseViewController,
                                                 phone: String, customerBrand: String,
                                                 province_id: String, hgd_type: String,
                                                 district_id: String, ward_id: String,
                                                 agent_id: String, hgd_time_use: String,
                                                 //++ BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
                                                 //version_code: String,
                                                 //-- BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
                                                 street_id: String,
                                                 first_name: String, house_numbers: String,
                                                 list_hgd_invest: String, longitude: String,
                                                 latitude: String, serial: String,
                                                 hgd_doi_thu: String,
                                                 //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
                                                 ccsCode: String) {
                                                 //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
//        // Show overlay
//        LoadingView.shared.showOverlay(view: view.view)
        let request = CustomerFamilyCreateRequest(url: G06Const.PATH_CUSTOMER_FAMILY_CREATE,
                                                reqMethod: DomainConst.HTTP_POST_REQUEST,
                                                view: view)
        request.setData(phone: phone, customerBrand: customerBrand,
                        province_id: province_id, hgd_type: hgd_type,
                        district_id: district_id, ward_id: ward_id,
                        agent_id: agent_id, hgd_time_use: hgd_time_use,
                        //++ BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
                        //version_code: version_code,
                        //-- BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
                        street_id: street_id,
                        first_name: first_name, house_numbers: house_numbers,
                        list_hgd_invest: list_hgd_invest,
                        longitude: longitude, latitude: latitude,
                        serial: serial, hgd_doi_thu: hgd_doi_thu,
                        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
                        ccsCode: ccsCode)
                        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        NotificationCenter.default.addObserver(view, selector: action, name: NSNotification.Name(rawValue: request.theClassName), object: nil)
        request.execute()
    }
}
