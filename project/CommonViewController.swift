//
//  CommonViewController.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonViewController : UIViewController {
    //MARK: Properties
    /** Navigation bar */
    @IBOutlet weak var navigationBar: UINavigationItem!
    /** Flag check keyboard is show or hide */
    var isKeyboardShow : Bool = false
    /** Main story board */
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //MARK: Methods
    /**
     * Notify turn on training mode
     */
    func trainingModeOn(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
    }
    /**
     * Notify turn off training mode
     */
    func trainingModeOff(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
    }
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        //changeBackgroundColor(Singleton.sharedInstance.checkTrainningMode())
    }
    /**
     * TrainingMode on/off
     * - parameter isTrainingMode: Training mode flag
     */
    func changeBackgroundColor(_ isTrainingMode :Bool)  {
        if isTrainingMode {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
        }else {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        }
        
    }
    /**
     * Set data
     */
    func setData(_ notification: Notification) {
        
    }
    /**
     * Handle show alert message
     */
    func showAlert(message: String) -> Void {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: GlobalConst.CONTENT00008, style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func asignNotifyForTrainingModeChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.trainingModeOn(_:)), name:NSNotification.Name(rawValue: "TrainingModeOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.trainingModeOff(_:)), name:NSNotification.Name(rawValue: "TrainingModeOff"), object: nil)
    }
    
    
}
