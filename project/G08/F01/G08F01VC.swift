//
//  G08F01VC.swift
//  project
//
//  Created by SPJ on 5/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G08F01VC: StepVC, StepDoneDelegate {
    /** Type of store card */
    public static var _typeId:      String = DomainConst.BLANK
    /** Step 3 */
    private var _step3:             G08F01S03?
    /** Mode: 0 - Create, 1 - Update */
    public static var _mode:        String  = DomainConst.NUMBER_ZERO_VALUE
    /** Id of store card updating */
    public static var _id:          String = DomainConst.BLANK

    override func viewDidLoad() {

        // Do any additional setup after loading the view.
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G08F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G08F01S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        _step3 = G08F01S03(w: GlobalConst.SCREEN_WIDTH,
                           h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step4 = G08F01S04(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        let step5 = G08F01S05(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        let summary = G08F01Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        step2.stepDoneDelegate = self
        _step3?.stepDoneDelegate = self
        step4.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        self.appendContent(stepContent: step1)
        self.appendContent(stepContent: _step3!)
        self.appendContent(stepContent: step4)
        //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        step5.stepDoneDelegate = self
        self.appendContent(stepContent: step5)
        //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        
        appendSummary(summary: summary)
        // Set title
        if G08F01VC._mode == DomainConst.NUMBER_ZERO_VALUE {
            self.setTitle(title: DomainConst.CONTENT00353)
        } else {
            self.setTitle(title: DomainConst.CONTENT00396)
        }
        
        super.viewDidLoad()
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
     * Hide keyboard
     */
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    /**
     * Tells the responder when one or more fingers touch down in a view or window.
     */
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    
    /**
     * Notifies the view controller that its view is about to be added to a view hierarchy.
     */
    override func viewWillAppear(_ animated: Bool) {
        switch G08F01S03._type {
        case G08F01S03.TYPE_GAS:
            print(G08F01S03._type)
        case G08F01S03.TYPE_CYLINDER:
            print(G08F01S03._type)
        case G08F01S03.TYPE_OTHERMATERIAL:
            print(G08F01S03._type)
        default:
            break
        }
        // Check if select from MaterialSelectViewController
        if !MaterialSelectViewController.getSelectedItem().isEmpty() {
            // Append to list data at step 3
            _step3?.appendMaterial(material: MaterialSelectViewController.getSelectedItem())
            // Reset selected item data
            MaterialSelectViewController.setSelectedItem(item: OrderDetailBean.init())
        }
    }
    
    /**
     * Handle send request create uphold
     */
    override func btnSendTapped() {
        // Create order detail
        var orderDetail = [String]()
        for item in G08F01S03._data {
            if !item.material_id.isEmpty {
                orderDetail.append(item.createJsonDataForStoreCard())
            }
        }
        // Create new
        if G08F01VC._mode == DomainConst.NUMBER_ZERO_VALUE {
            StoreCardCreateRequest.request(
                action:         #selector(finishCreateStoreCard(_:)),
                view:           self,
                customerId:     G08F01S01._target.id,
                storeCardType:  G08F01VC._typeId,
                date:           G08F01S02._selectedValue,
                note:           G08F01S04._selectedValue,
                orderDetail:    orderDetail.joined(separator: DomainConst.SPLITER_TYPE2),
                //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
                images:         G08F01S05._selectedValue)
                //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        } else {    // Update
            var imgDeleted = [String]()
            for item in G08F01S05._originPreviousImage {
                if !G08F01S05._previousImage.contains(item) {
                    imgDeleted.append(item.id)
                }
            }
            StoreCardUpdateRequest.request(
                action:         #selector(finishUpdateStoreCard(_:)),
                view:           self,
                id:             G08F01VC._id,
                customerId:     G08F01S01._target.id,
                storeCardType:  G08F01VC._typeId,
                date:           G08F01S02._selectedValue,
                note:           G08F01S04._selectedValue,
                orderDetail:    orderDetail.joined(separator: DomainConst.SPLITER_TYPE2),
                //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
                images:         G08F01S05._selectedValue,
                listImgDelete:  imgDeleted.joined(separator: DomainConst.SPLITER_TYPE2))
            //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        }
    }
    
    /**
     * Handle when finish create store card
     */
    internal func finishCreateStoreCard(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = StoreCardViewRespModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            self.clearData()
            showAlert(message: model.message,
                      okHandler: {
                        alert in
                        self.backButtonTapped(self)
                        G08F00S02VC._id = model.record.id
                        self.pushToView(name: G08F00S02VC.theClassName)
            })
        } else {    // Error
            self.showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when finish update store card
     */
    internal func finishUpdateStoreCard(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = StoreCardViewRespModel(jsonString: data)
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
     * Clear data
     */
    override func clearData() {
        G08F01VC._mode                  = DomainConst.NUMBER_ZERO_VALUE
        G08F01S01._target               = CustomerBean.init()
        G08F01S02._selectedValue        = DomainConst.BLANK
        G08F01S03._data                 = [OrderDetailBean].init()
        G08F01S04._selectedValue        = DomainConst.BLANK
        //++ BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
        G08F01S05._selectedValue.removeAll()
        //-- BUG0107-SPJ (NguyenPT 20170609) Handle image in store card
    }
}
