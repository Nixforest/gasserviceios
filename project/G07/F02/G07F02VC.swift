//
//  G07F02VC.swift
//  project
//
//  Created by SPJ on 7/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F02VC: StepVC, StepDoneDelegate {
    /** Current data */
    public static var _data:    CustomerFamilyBean  = CustomerFamilyBean()
    //++ BUG0197-SPJ (NguyenPT 20180512) Add new field transaction id
    /** Current order id */
    public static var _orderId: String              = DomainConst.NUMBER_ZERO_VALUE
    //-- BUG0197-SPJ (NguyenPT 20180512) Add new field transaction id

    override func viewDidLoad() {
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G07F02S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.disablePhone()
        let step2 = G07F02S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
//        G07F02S02._fullAddress.setData(bean: FullAddressBean(
//            provinceId:     G07F02VC._data.province_id,
//            districtId:     G07F02VC._data.district_id,
//            wardId:         G07F02VC._data.ward_id,
//            streetId:       G07F02VC._data.street_id,
//            houseNumber:    G07F02VC._data.house_numbers))
        let summary = G07F02Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        appendSummary(summary: summary)
        self.setTitle(title: DomainConst.CONTENT00154)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /**
     * Clear data before close view
     */
    override func clearData() {
        G07F02S01._selectedValue = (DomainConst.BLANK, DomainConst.BLANK)
        G07F02S02._fullAddress.setData(bean: FullAddressBean.init())
        G07F02VC._data = CustomerFamilyBean.init()
    }
    
    /**
     * Handle send request create uphold
     */
    override func btnSendTapped() {
        var invest: [String] = [String]()
        for item in G07F02VC._data.list_hgd_invest {
            invest.append(String.init(format: "\"%@\"", item))
        }
        CustomerFamilyUpdateRequest.requestCustomerFamilyUpdate(
            action:         #selector(finishCreateCustomer(_:)),
            view: self,
            phone: G07F02VC._data.phone,
            customerBrand: G07F02VC._data.hgd_thuong_hieu,
            province_id: G07F02S02._fullAddress.getData().provinceId,
            hgd_type: G07F02VC._data.hgd_type,
            district_id:    G07F02S02._fullAddress.getData().districtId,
            ward_id:        G07F02S02._fullAddress.getData().wardId,
            agent_id:       G07F02VC._data.agent_id,
            hgd_time_use:   G07F02VC._data.hgd_time_use,
            street_id:      G07F02S02._fullAddress.getData().streetId,
            first_name:     G07F02S01._selectedValue.name,
            house_numbers:  G07F02VC._data.house_numbers,
            list_hgd_invest: invest.joined(separator: DomainConst.ADDRESS_SPLITER),
            longitude:      String(MapViewController._originPos.longitude),
            latitude:       String(MapViewController._originPos.latitude),
            serial:         G07F02VC._data.serial,
            hgd_doi_thu:    G07F02VC._data.hgd_doi_thu,
            customer_id:    G07F02VC._data.id,
            ccsCode:        G07F02VC._data.ccsCode,
            //++ BUG0197-SPJ (NguyenPT 20180512) Add new field transaction id
            transaction_id: G07F02VC._orderId)
            //-- BUG0197-SPJ (NguyenPT 20180512) Add new field transaction id
    }
    
    /**
     * Finish create customer
     * - parameter notification: Notification object
     */
    internal func finishCreateCustomer(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerFamilyCreateRespModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            self.clearData()
            self.showAlert(message: model.message,
                           okHandler: {
                            (alert: UIAlertAction!) in
                            self.backButtonTapped(self)
            })
        } else {
            showAlert(message: model.message)
        }
    }
}
