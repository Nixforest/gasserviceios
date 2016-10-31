//
//  G01F02VC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02VC: StepVC, StepDoneDelegate {
    
    override func viewDidLoad() {
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        var listContent = [StepContent]()
        let step1 = G01F02S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step2 = G01F02S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step3 = G01F02S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step4 = G01F02S04(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step5 = G01F02S05(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var step6 = G01F02S06(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        var summary = G01F02S07(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        listContent.append(step1)
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        listContent.append(step2)
        step3.stepDoneDelegate = self
        self.appendContent(stepContent: step3)
        listContent.append(step3)
        step4.stepDoneDelegate = self
        self.appendContent(stepContent: step4)
        listContent.append(step4)
        step5.stepDoneDelegate = self
        self.appendContent(stepContent: step5)
        listContent.append(step5)
        step6.stepDoneDelegate = self
        self.appendContent(stepContent: step6)
        listContent.append(step6)
        self._numberStep = listContent.count + 1
        super.setListContents(listContent: listContent)
        appendSummary(summary: summary)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clearData() {
        G01F02S01._selectedValue = ConfigBean(id: "", name: "")
        G01F02S02._selectedValue = ConfigBean(id: "", name: "")
        G01F02S03._selectedValue = nil
        G01F02S04._selectedValue = (name: "", phone: "")
        G01F02S05._selectedValue = ""
        G01F02S06._selectedValue.removeAll()
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
}
