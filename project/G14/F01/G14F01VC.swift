//
//  G14F01VC.swift
//  project
//
//  Created by SPJ on 12/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G14F01VC: StepVC {
    /** Step 3 */
    private var step3:             G14F01S03?
    /** Mode: 0 - Create, 1 - Update */
    private var _mode:              String      = DomainConst.NUMBER_ZERO_VALUE
    /** Id of gas remain (for update mode) */
    private var _id:                String      = DomainConst.BLANK

    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        let height = self.getTopHeight()
        let step1 = G14F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G14F01S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step3 = G14F01S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G14F01Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
        step2.stepDoneDelegate = self
        step3?.stepDoneDelegate = self
        appendContent(stepContent: step1)
        appendContent(stepContent: step2)
        appendContent(stepContent: step3!)
        appendSummary(summary: summary)
        if _mode == DomainConst.NUMBER_ONE_VALUE {
            self.setTitle(title: DomainConst.CONTENT00548)
        } else {
            self.setTitle(title: DomainConst.CONTENT00558)
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        G14F01S01._selectedValue = DomainConst.BLANK
        G14F01S02._target = CustomerBean.init()
        G14F01S02._type = DomainConst.SEARCH_TARGET_TYPE_CUSTOMER
        G14F01S03._data.removeAll()
        G14F01S03._type = G14F01S03.TYPE_NONE
    }
    
    /**
     * Handle send request create gas remain
     */
    override func btnSendTapped() {
        if _mode == DomainConst.NUMBER_ONE_VALUE {
            GasRemainUpdateRequest.request(
                action: #selector(finishCreateGasRemain(_:)),
                view: self,
                id: self._id,
                customerId: G14F01S02._target.id,
                date: G14F01S01._selectedValue,
                seri: G14F01S03._data[0].seri,
                kg_has_gas: G14F01S03._data[0].kg_has_gas,
                kg_empty: G14F01S03._data[0].kg_empty,
                materials_id: G14F01S03._data[0].material_id,
                materials_type_id: G14F01S03._data[0].materials_type_id)
        } else {
            // Create order detail
            var orderDetail = [String]()
            for item in G14F01S03._data {
                if !item.material_id.isEmpty {
                    orderDetail.append(item.createJsonDataForUpdateOrder())
                }
            }
            GasRemainCreateRequest.request(
                action: #selector(finishCreateGasRemain(_:)),
                view: self,
                customerId: G14F01S02._target.id,
                date: G14F01S01._selectedValue,
                orderDetail: orderDetail.joined(separator: DomainConst.SPLITER_TYPE2))
        }
    }
    
    /**
     * Handle when finish create store card
     */
    internal func finishCreateGasRemain(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            self.clearData()
            showAlert(message: model.message,
                      okHandler: {
                        alert in
                        self.backButtonTapped(self)
            })
        } else {    // Error
            self.showAlert(message: model.message)
        }
    }
    
    /**
     * Notifies the view controller that its view is about to be added to a view hierarchy.
     */
    override func viewWillAppear(_ animated: Bool) {
        switch G14F01S03._type {
        case G14F01S03.TYPE_GAS:
            print(G14F01S03._type)
        case G14F01S03.TYPE_CYLINDER:
            print(G14F01S03._type)
        case G14F01S03.TYPE_OTHERMATERIAL:
            print(G14F01S03._type)
        default:
            break
        }
        // Check if select from MaterialSelectViewController
        //++ BUG0152-SPJ (NguyenPT 20170819) Fix bug
        //if !MaterialSelectViewController.getSelectedItem().isEmpty() {
        if G14F01S03._type != G14F01S03.TYPE_NONE && !MaterialSelectViewController.getSelectedItem().isEmpty() {
            //-- BUG0152-SPJ (NguyenPT 20170819) Fix bug
            // Append to list data at step 3
            step3?.appendMaterial(material: OrderDetailBean(data: MaterialSelectViewController.getSelectedItem()))
            // Reset selected item data
            MaterialSelectViewController.setSelectedItem(item: OrderDetailBean.init())
        }
    }
    
    /**
     * Set id for update mode
     * - parameter id: Id of gas remain
     */
    public func setData(bean: GasRemainBean) {
        self._id = bean.id
        self._mode = DomainConst.NUMBER_ONE_VALUE
        G14F01S01._selectedValue = bean.date_input.replacingOccurrences(
            of: DomainConst.SPLITER_TYPE3,
            with: DomainConst.SPLITER_TYPE1)
        G14F01S02._target = CustomerBean(
            id: bean.customer_id,
            name: bean.customer_name,
            phone: bean.customer_phone,
            address: bean.customer_address)
        var orderDetail = OrderDetailBean()
        orderDetail.materials_type_id = bean.materials_type_id
        orderDetail.material_id = bean.materials_id
        orderDetail.material_name = bean.materials_name
        var vipOrderDetail = OrderVIPDetailBean(orderDetail: orderDetail)
        vipOrderDetail.kg_empty = String(describing: bean.amount_empty)
        vipOrderDetail.kg_has_gas = String(describing: bean.amount_has_gas)
        vipOrderDetail.seri = bean.name
        G14F01S03._data.append(vipOrderDetail)
    }
}

extension G14F01VC: StepDoneDelegate {
    
}
