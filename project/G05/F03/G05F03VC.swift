
//
//  G05F03VC.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.

//

import UIKit
import harpyframework

class G05F03VC: StepVC, StepDoneDelegate {
    /**
     * View did load
     */
    override func viewDidLoad() {
        let height = self.getTopHeight()
        let step1 = G05F03S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G05F03S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step3 = G05F03S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step4 = G05F03S04(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G05F03Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
        step2.stepDoneDelegate = self
        step3.stepDoneDelegate = self
        step4.stepDoneDelegate = self
        appendContent(stepContent: step1)
        appendContent(stepContent: step2)
        appendContent(stepContent: step3)
        appendContent(stepContent: step4)
        appendSummary(summary: summary)
        // Set title
        self.setTitle(title: DomainConst.CONTENT00376)
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
     * Handle send request create uphold
     */
    override func btnSendTapped() {
        var b50         = DomainConst.NUMBER_ZERO_VALUE
        var b50Note     = DomainConst.BLANK
        var b45         = DomainConst.NUMBER_ZERO_VALUE
        var b45Note     = DomainConst.BLANK
        var b12         = DomainConst.NUMBER_ZERO_VALUE
        var b12Note     = DomainConst.BLANK
        var b6          = DomainConst.NUMBER_ZERO_VALUE
        var b6Note      = DomainConst.BLANK
        var note        = DomainConst.BLANK
        // Loop for all selector in S02
        for item in G05F03S02._lstSelector {
            switch item.getSelectorValue().id {
            case DomainConst.KEY_B50:       // 50kg type
                b50 = item.getSelectorValue().name
                if item.getSelectorValue().name != DomainConst.NUMBER_ZERO_VALUE {
                    b50Note = String.init(format: "%@ bình 50kg", item.getSelectorValue().name)
                }
                break
            case DomainConst.KEY_B45:       // 45kg type
                b45 = item.getSelectorValue().name
                if item.getSelectorValue().name != DomainConst.NUMBER_ZERO_VALUE {
                    b45Note = String.init(format: "%@ bình 45kg", item.getSelectorValue().name)
                }
                break
            case DomainConst.KEY_B12:       // 12kg type
                b12 = item.getSelectorValue().name
                if item.getSelectorValue().name != DomainConst.NUMBER_ZERO_VALUE {
                    b12Note = String.init(format: "%@ bình 12kg", item.getSelectorValue().name)
                }
                break
            case DomainConst.KEY_B6:        // 6kg type
                b6 = item.getSelectorValue().name
                if item.getSelectorValue().name != DomainConst.NUMBER_ZERO_VALUE {
                    b6Note = String.init(format: "%@ bình 6kg", item.getSelectorValue().name)
                }
                break
            default:
                break
            }
        }
        // Create note content
        if !b50Note.isEmpty {           // 50kg type
            note = b50Note
        }
        if !b45Note.isEmpty {           // 45kg type
            if !note.isEmpty {
                note += DomainConst.SPLITER_TYPE1 + b45Note
            } else {
                note = b45Note
            }
        }
        if !b12Note.isEmpty {           // 12kg type
            if !note.isEmpty {
                note += DomainConst.SPLITER_TYPE1 + b12Note
            } else {
                note = b12Note
            }
        }
        if !b6Note.isEmpty {            // 6kg type
            if !note.isEmpty {
                note += DomainConst.SPLITER_TYPE1 + b6Note
            } else {
                note = b6Note
            }
        }
        
        var format = "%@: %@"
        if G05F03S02._note.isBlank {
            format = "%@%@"
        }
        note = String.init(format: format, note, G05F03S02._note)
        
        if !G05F03S04._selectedValue.isBlank {
            note += " - ĐT: " + G05F03S04._selectedValue
        } else {
            note += " - ĐT: " + G05F03S01._target.getActivePhone()
        }
        
        OrderVIPCreateByCoordinatorRequest.request(
            action: #selector(finishHandler(_:)),
            view: self,
            customer_id: G05F03S01._target.id,
            agent_id: G05F03S03._selectedValue.id,
            date: CommonProcess.getCurrentDate(),
            type: DomainConst.NUMBER_ONE_VALUE,
            b50: b50, b45: b45, b12: b12, b6: b6,
            note: note)
    }
    
    /**
     * Handle when finish update store card
     */
    internal func finishHandler(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = OrderVIPCreateByCoordinatorRespModel(jsonString: data)
        if model.isSuccess() {
            showAlert(message: model.message,
                      okHandler: {
                        alert in
                        self.backButtonTapped(self)
            })
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        G05F03S01._target = G05CustomerBean()
        G05F03S02._lstSelector.removeAll()
        G05F03S03._selectedValue = ConfigBean()
        //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        G05F03S01.keyword = DomainConst.BLANK
        G05F03S02._note = DomainConst.BLANK
        G05F03S04._selectedValue = DomainConst.BLANK
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
    }
}
