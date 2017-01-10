//
//  CreateUpholdViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework


class G01F01VC: StepVC, StepDoneDelegate {
    let TOP_PART_HEIGHT: CGFloat = 100.0
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self, selector: #selector(gasServiceItemTapped), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_GAS_SERVICE_ITEM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(issueItemTapped(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_ISSUE_ITEM), object: nil)
    }
    
    override func viewDidLoad() {
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G01F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G01F01S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G01F01S03(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        //self._numberStep = self._arrayContent.count + 1
        appendSummary(summary: summary)
        // Set title
        self.setTitle(title: DomainConst.CONTENT00178)
//        var listIcon = [String]()
//        listIcon.append("problemType")
//        listIcon.append("informationSum")
//        super.setListIcon(listIcon: listIcon)
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Do any additional setup after loading the view.
        let phone: UIButton = UIButton()
        phone.frame = CGRect(x: GlobalConst.MARGIN, y: self.getTitleHeight(), width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN, height: TOP_PART_HEIGHT / 2)
        phone.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        phone.setTitle(BaseModel.shared.getCallCenterUpholdNumber(), for: UIControlState())
        phone.setTitleColor(UIColor.white, for: UIControlState())
        phone.titleLabel?.textAlignment = .center
        phone.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        let tintImg = UIImage(named: "icon63.png")
        let tinted = tintImg?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        phone.setImage(tinted, for: UIControlState())
        phone.tintColor = UIColor.white
        phone.imageView?.contentMode = .scaleAspectFit
        phone.isEnabled = false
        self.view.addSubview(phone)
        
        let phoneStr: UIButton = UIButton()
        phoneStr.frame = CGRect(x: phone.frame.minX, y: phone.frame.maxY, width: phone.frame.width, height: TOP_PART_HEIGHT / 2)
        phoneStr.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        phoneStr.setTitle(BaseModel.shared.getHotlineNumber(), for: UIControlState())
        phoneStr.setTitleColor(UIColor.white, for: UIControlState())
        phoneStr.titleLabel?.textAlignment = .center
        phoneStr.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.BIG_FONT_SIZE)
        phoneStr.setImage(UIImage(named: "icon64.png"), for: UIControlState())
        phoneStr.imageView?.contentMode = .scaleAspectFit
        phoneStr.isEnabled = false
        self.view.addSubview(phoneStr)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clearData() {
        G01F01S01._selectedValue = ConfigBean(id: "", name: "")
        G01F01S01._otherProblem = ""
        G01F01S02._selectedValue = ConfigBean(id: "", name: "")
        G01F01S02._name = ""
        G01F01S02._phone = ""
    }
    override func btnSendTapped() {
        CreateUpholdRequest.requestCreateUphold(
            customerId: BaseModel.shared.user_id,
            employeeId: "",
            typeUphold: G01F01S01._selectedValue.id,
            content: G01F01S01._otherProblem,
            contactPerson: G01F01S02._name,
            contactTel: G01F01S02._phone,
            requestBy: G01F01S02._selectedValue.id, view: self)
    }
    
    func stepDone() {
        self.moveNext()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewDidAppear(_ animated: Bool) {
        self.updateNotificationStatus()
    }
    
    override func getTopHeight() -> CGFloat {
        let top = (self.navigationController!.navigationBar.frame.size.height
            + UIApplication.shared.statusBarFrame.size.height)
        return top + TOP_PART_HEIGHT
    }
    
    func getTitleHeight() -> CGFloat {
        return (self.navigationController!.navigationBar.frame.size.height
            + UIApplication.shared.statusBarFrame.size.height)
    }
}
