//
//  ChangePasswordViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G00ChangePassVC: CommonViewController, UIPopoverPresentationControllerDelegate,UITextFieldDelegate {
    // MARK: Properties
    /** Flag show password */
    var bShowPassword:Bool!
    /** Save button */
    @IBOutlet weak var saveButton: UIButton!
    /** Logout button */
    @IBOutlet weak var logoutButton: UIButton!
    /** Checkbox show password button */
    @IBOutlet weak var checkboxButton: CheckBox!
    /** Checkbox show password label */
    @IBOutlet weak var lblCheckboxButton: UILabel!
    /** Old password textbox */
    @IBOutlet weak var txtOldPassword: UITextField!
    /** New password textbox */
    @IBOutlet weak var txtNewPassword: UITextField!
    /** Retype-New password textbox */
    @IBOutlet weak var txtNewPasswordRetype: UITextField!
    
    // MARK: Actions
    /**
     * Handle tap on checkbox button
     * - parameter sender: AnyObject
     */
    @IBAction func checkboxButtonTapped(_ sender: AnyObject) {
        bShowPassword = !bShowPassword
        txtOldPassword.isSecureTextEntry = !bShowPassword
        txtNewPassword.isSecureTextEntry = !bShowPassword
        txtNewPasswordRetype.isSecureTextEntry = !bShowPassword
    }
    
    /**
     * Handle tap on logout button
     * - parameter sender: AnyObject
     */
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        CommonProcess.requestLogout(view: self)
    }
    
    /**
     * Handle tap on Save button
     * - parameter sender: AnyObject
     */
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        // Validate data is filled
        if (((txtOldPassword.text?.isEmpty)! || (txtNewPassword.text?.isEmpty)! || (txtNewPasswordRetype.text?.isEmpty)!)){
            // Call alert
            showAlert(message: GlobalConst.CONTENT00025)
            return
        }
        // Check if password is correct
        if (txtNewPassword.text == txtNewPasswordRetype.text){
            //print("password update successfully")
            CommonProcess.requestChangePassword(
                oldPass: txtOldPassword.text!,
                newPass: txtNewPassword.text!,
                view: self)
        } else {
            // Call alert
            showAlert(message: GlobalConst.CONTENT00026)
        }

    }
    
    /**
     * Handle tap on Menu ite Issue
     * - parameter notification: Notification
     */
    func issueButtonInChangePassVCTapped(_ notification: Notification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.gasServiceItemTapped),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(G00ChangePassVC.issueButtonInChangePassVCTapped(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(super.configItemTap(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_CHANGEPASSVIEW),
                                               object: nil)
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Background
        view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // Textfield old password
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        txtOldPassword.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                      y: heigh + GlobalConst.MARGIN,
                                      width: GlobalConst.EDITTEXT_W,
                                      height: GlobalConst.EDITTEXT_H)
        txtOldPassword.placeholder = GlobalConst.CONTENT00083
        txtOldPassword.translatesAutoresizingMaskIntoConstraints = true
        txtOldPassword.delegate = self
        
        // Textfield new password
        txtNewPassword.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                      y: txtOldPassword.frame.maxY + GlobalConst.MARGIN,
                                      width: GlobalConst.EDITTEXT_W,
                                      height: GlobalConst.EDITTEXT_H)
        txtNewPassword.placeholder = GlobalConst.CONTENT00084
        txtNewPassword.translatesAutoresizingMaskIntoConstraints = true
        txtNewPassword.delegate = self
        
        // Textfield new password retype
        txtNewPasswordRetype.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                            y: txtNewPassword.frame.maxY + GlobalConst.MARGIN,
                                            width: GlobalConst.EDITTEXT_W,
                                            height: GlobalConst.EDITTEXT_H)
        txtNewPasswordRetype.placeholder = GlobalConst.CONTENT00085
        txtNewPasswordRetype.translatesAutoresizingMaskIntoConstraints = true
        txtNewPasswordRetype.delegate = self
        
        // Show password check box
        checkboxButton.frame = CGRect(x: txtOldPassword.frame.minX,
                                      y: txtNewPasswordRetype.frame.maxY + GlobalConst.MARGIN,
                                      width: GlobalConst.CHECKBOX_W,
                                      height: GlobalConst.CHECKBOX_H)
        checkboxButton.tintColor = UIColor.black
        checkboxButton.translatesAutoresizingMaskIntoConstraints = true
        
        // Show password label
        lblCheckboxButton.frame = CGRect(x: checkboxButton.frame.maxX + GlobalConst.MARGIN,
                                         y: checkboxButton.frame.minY,
                                         width: GlobalConst.LABEL_W,
                                         height: GlobalConst.LABEL_H)
        lblCheckboxButton.text = GlobalConst.CONTENT00102
        lblCheckboxButton.translatesAutoresizingMaskIntoConstraints = true
        bShowPassword = false
        txtOldPassword.isSecureTextEntry = !bShowPassword
        txtNewPassword.isSecureTextEntry = !bShowPassword
        txtNewPasswordRetype.isSecureTextEntry = !bShowPassword
        
        // Save button
        saveButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                  y: checkboxButton.frame.maxY + GlobalConst.MARGIN,
                                  width: GlobalConst.BUTTON_W,
                                  height: GlobalConst.BUTTON_H)
        saveButton.setTitle(GlobalConst.CONTENT00086, for: UIControlState())
        saveButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        saveButton.setTitleColor(UIColor.white, for: UIControlState())
        saveButton.translatesAutoresizingMaskIntoConstraints = true
        saveButton.layer.cornerRadius = 6
        
        // Logout buton
        logoutButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                    y: saveButton.frame.maxY + GlobalConst.MARGIN,
                                    width: GlobalConst.BUTTON_W,
                                    height: GlobalConst.BUTTON_H)
        logoutButton.setTitle(GlobalConst.CONTENT00090, for: UIControlState())
        logoutButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        logoutButton.setTitleColor(UIColor.white, for: UIControlState())
        logoutButton.layer.cornerRadius = 6
        logoutButton.translatesAutoresizingMaskIntoConstraints = true
        
        // Navigation Bar customize
        setupNavigationBar(title: GlobalConst.CONTENT00089, isNotifyEnable: true)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    /**
     * Handle show menu.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GlobalConst.POPOVER_MENU_IDENTIFIER {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    /**
     * ...
     */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    /**
     * Hilde keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        isKeyboardShow = false
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        isKeyboardShow = true
        return true
    }
    
    /**
     * Handle when lost focus edittext
     * - parameter textField: Textfield will be focusing
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide keyboard
        //textField.resignFirstResponder()
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if (nextResponder != nil){
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        }
        else
        {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }) 
        }
        return true
    }


}
