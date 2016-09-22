//
//  CommonProcess.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonProcess {
    /*static func handleTrainingMode(_ controller: CommonViewController) -> Void {
        NotificationCenter.default.addObserver(controller, selector: #selector(controller.trainingModeOn(_:)), name:"TrainingModeOn", object: nil)
        NotificationCenter.default.addObserver(controller, selector: #selector(controller.trainingModeOff(_:)), name:"TrainingModeOff", object: nil)
     }*/
    /**
     * TrainingMode on/off
     */
    static func changeBackgroundColor(_ isTrainingMode :Bool, aView :UIView)  {
        if isTrainingMode == true {
            aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
        }else {
            aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        }
        
    }
}
