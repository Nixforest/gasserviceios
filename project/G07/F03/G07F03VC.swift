//
//  G07F03VC.swift
//  project
//
//  Created by SPJ on 7/27/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F03VC: StepVC, StepDoneDelegate {
    /** Current agent */
    public static var _currentAgent: CustomerBean    = CustomerBean()

    override func viewDidLoad() {
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G07F03S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G07F03Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
        appendContent(stepContent: step1)
        appendSummary(summary: summary)
        step1.setTargetType(title: DomainConst.CONTENT00377,
                            type: DomainConst.SEARCH_TARGET_TYPE_AGENT)
        self.setTitle(title: DomainConst.CONTENT00458)
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

}
