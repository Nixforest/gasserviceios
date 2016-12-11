//
//  ViewController.swift
//  project
//
//  Created by Lâm Phạm on 7/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G00LoginVC: CommonViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    // MARK: Properties
    var bShowPassword:Bool!
    /** Logo image */
    @IBOutlet weak var imgLogo: UIImageView!
    /** Username edit text */
    @IBOutlet weak var txtAccount: UITextField!
    /** Password edit text */
    @IBOutlet weak var txtPassword: UITextField!
    /** Login button */
    @IBOutlet weak var btnLogin: UIButton!
    /** Sign in button */
    @IBOutlet weak var btnSignin: UIButton!
    /** Show password checkbox */
    @IBOutlet weak var chbShowPassword: CheckBox!
    /** Show password label */
    @IBOutlet weak var lblShowPassword: UILabel!
    /** Tap counter on logo */
    var imgLogoTappedCounter:Int = 0
    
    // MARK: Actions
    /**
     * Handle check/uncheck on Show password checkbox
     * - parameter sender:AnyObject
     */
    @IBAction func showPassword(_ sender: AnyObject) {
        bShowPassword = !bShowPassword
        txtPassword.isSecureTextEntry = !bShowPassword
    }
    
    /**
     * Handle tap on Login button
     * - parameter sender:AnyObject
     */
    @IBAction func Login(_ sender: AnyObject) {
        // Check the value of text field is empty or not
        if (((txtPassword.text?.isEmpty)! || (txtAccount.text?.isEmpty)!)){
            // Call alert
            showAlert(message: GlobalConst.CONTENT00023)
        } else {
            // Start login process
            CommonProcess.requestLogin(username: txtAccount.text!, password: txtPassword.text!, view: self)
        }
    }
    
    /**
     * Handle tap on Login button
     * - parameter sender:AnyObject
     */
    @IBAction func Register(_ sender: AnyObject) {
//        let registerVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.REGISTER_VIEW_CTRL)
//        self.navigationController?.pushViewController(registerVC, animated: true)
        showAlert(message: GlobalConst.CONTENT00197)
    }
    
    // MARK: Methods
    /**
     * Handle tap on Logo image
     * - parameter gestureRecognizer: UITapGestureRecognizer
     */
    func imgLogoTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        //let tappedImageView = gestureRecognizer.view!
        imgLogoTappedCounter += 1
        if imgLogoTappedCounter == 7 {
            imgLogoTappedCounter = 0
            print(imgLogoTappedCounter)
            let configVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G00_CONFIGURATION_VIEW_CTRL)
            self.navigationController?.pushViewController(configVC, animated: true)
        }
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(super.configItemTap(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM),
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
        self.view.backgroundColor   = GlobalConst.BACKGROUND_COLOR_GRAY
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        imgLogo.image = UIImage(named: GlobalConst.LOGO_IMG_NAME)
        imgLogo.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W) / 2,
                               y: heigh + GlobalConst.MARGIN,
                               width: GlobalConst.LOGIN_LOGO_W,
                               height: GlobalConst.LOGIN_LOGO_H)
        imgLogo.translatesAutoresizingMaskIntoConstraints = true
        imgLogo.isUserInteractionEnabled = true
        // Now you need a tap gesture recognizer
        // Note that target and action point to what happens when the action is recognized.
        let imgLogoTappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(G00LoginVC.imgLogoTapped(_:)))
        // Add the recognizer to your view.
        imgLogo.addGestureRecognizer(imgLogoTappedRecognizer)
        
        // Username text field
        txtAccount.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                  y: imgLogo.frame.maxY + GlobalConst.MARGIN,
                                  width: GlobalConst.EDITTEXT_W,
                                  height: GlobalConst.EDITTEXT_H)
        txtAccount.placeholder = GlobalConst.CONTENT00049
        txtAccount.translatesAutoresizingMaskIntoConstraints = true
        // Make username textbox is focus when load view
        //self.txtAccount.becomeFirstResponder()
        
        // Password textfield
        txtPassword.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                   y: txtAccount.frame.maxY + GlobalConst.MARGIN,
                                   width: GlobalConst.EDITTEXT_W,
                                   height: GlobalConst.EDITTEXT_H)
        txtPassword.translatesAutoresizingMaskIntoConstraints = true
        txtPassword.placeholder = GlobalConst.CONTENT00050
        
        // Show password check box
        chbShowPassword.frame = CGRect(x: txtPassword.frame.minX,
                                       y: txtPassword.frame.maxY + GlobalConst.MARGIN,
                                       width: GlobalConst.CHECKBOX_W,
                                       height: GlobalConst.CHECKBOX_H)
        chbShowPassword.tintColor = UIColor.black
        chbShowPassword.translatesAutoresizingMaskIntoConstraints = true
        
        // Show password label
        lblShowPassword.frame = CGRect(x: chbShowPassword.frame.maxX + GlobalConst.MARGIN,
                                       y: txtPassword.frame.maxY + GlobalConst.MARGIN,
                                       width: GlobalConst.LABEL_W,
                                       height: GlobalConst.LABEL_H)
        lblShowPassword.text = GlobalConst.CONTENT00102
        lblShowPassword.translatesAutoresizingMaskIntoConstraints = true
        // Check box status
        bShowPassword = false
        
        // Login button
        btnLogin.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                y: chbShowPassword.frame.maxY + GlobalConst.MARGIN,
                                width: GlobalConst.BUTTON_W,
                                height: GlobalConst.BUTTON_H)
        btnLogin.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnLogin.setTitle(GlobalConst.CONTENT00051, for: UIControlState())
        btnLogin.setTitleColor(UIColor.white, for: UIControlState())
        btnLogin.addTarget(self, action: #selector(Login), for: .touchUpInside)
        btnLogin.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self.view.addSubview(btnLogin)
        btnLogin.translatesAutoresizingMaskIntoConstraints = true
        
        // Sign in button
        btnSignin.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                 y: btnLogin.frame.maxY + GlobalConst.MARGIN,
                                 width: GlobalConst.BUTTON_W,
                                 height: GlobalConst.BUTTON_H)
        btnSignin.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnSignin.setTitle(GlobalConst.CONTENT00052, for: UIControlState())
        btnSignin.setTitleColor(UIColor.white, for: UIControlState())
        btnSignin.addTarget(self, action: #selector(Register), for: .touchUpInside)
        btnSignin.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self.view.addSubview(btnSignin)
        btnSignin.translatesAutoresizingMaskIntoConstraints = true
        
        // Navigation bar
        setupNavigationBar(title: GlobalConst.CONTENT00051, isNotifyEnable: false)
        
        txtAccount.delegate     = self
        txtPassword.delegate    = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(G00LoginVC.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        
        // Fill data in training mode
        if Singleton.shared.checkTrainningMode() {
            txtAccount.text = "truongnd"
            txtPassword.text = "123123"
        }
    }
    
    /**
     * Handle when leave focus edittext
     * - parameter textField: Textfield is focusing
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
            hideKeyboard()
            //Login(_)
        }
        return true
    }
    
    /**
     * Handle memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Override: show menu controller
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
     * Hide keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        hideKeyboard()
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
        isKeyboardShow = false
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if isKeyboardShow == false {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y - 100, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
            isKeyboardShow = true
        }
        return true
    }

}

