//
//  G01F02VC.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02VC: StepVC {
    
    let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
    override func viewDidLoad() {
        self._numberStep = 2
        var listContent = [StepContent]
        var step1 = G01F02S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT))
        
        self.appendContent(step1)
        super.setListContents(listContent: listContent)
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
    func appendContent(stepContent: StepContent) {
        stepContent.translatesAutoresizingMaskIntoConstraints = true
        step.frame = CGRect(
            x: 0,
            y: height,
            width: GlobalConst.SCREEN_WIDTH,
            height: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT))
        
        step._lblTitle.text = GlobalConst.CONTENT00181
        step.setup(mainView: contentView)
        self.view.addSubview(step)
    }
}
