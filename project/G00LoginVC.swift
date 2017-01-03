//
//  ViewController.swift
//  project
//
//  Created by Lâm Phạm on 7/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00LoginVC: BaseViewController, UITextFieldDelegate {
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
    //@IBOutlet weak var chbShowPassword: CheckBox!
    @IBOutlet weak var chbShowPassword: CustomCheckBox!
    /** Show password label */
    @IBOutlet weak var lblShowPassword: UILabel!
    /** Forgot password button */
    @IBOutlet weak var btnForgotPass: UIButton!
    /** Separator */
    @IBOutlet weak var btnSeparator: UIButton!
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
            showAlert(message: DomainConst.CONTENT00023)
        } else {
            // Start login process
            RequestAPI.requestLogin(username: txtAccount.text!, password: txtPassword.text!, view: self)
        }
    }
    
    /**
     * Handle tap on Login button
     * - parameter sender:AnyObject
     */
    @IBAction func Register(_ sender: AnyObject) {
        let registerVC = mainStoryboard.instantiateViewController(withIdentifier: DomainConst.REGISTER_VIEW_CTRL)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    /**
     * Handle tap on Forgot password button
     * - parameter sender:AnyObject
     */
    @IBAction func forgotPass(_ sender: AnyObject) {
        showAlert(message: DomainConst.CONTENT00197)
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
            let configVC = mainStoryboard.instantiateViewController(withIdentifier: DomainConst.G00_CONFIGURATION_VIEW_CTRL)
            self.navigationController?.pushViewController(configVC, animated: true)
        }
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(super.configItemTap(_:)),
                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_COFIG_ITEM),
                                               object: nil)
    }
    
    /**
     * View did load
     */
    override public func viewDidLoad() {
        setBackground(bkg: "bg1.jpg")
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        //imgLogo.image = UIImage(named: GlobalConst.LOGO_IMG_NAME)
        imgLogo.image = UIImage(named: "logo-1.png")
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
        txtAccount.placeholder = DomainConst.CONTENT00049
        txtAccount.translatesAutoresizingMaskIntoConstraints = true
        // Set icon
        setLeftViewForTextField(textField: txtAccount, named: "icon2.png")
        
        // Make username textbox is focus when load view
        //self.txtAccount.becomeFirstResponder()
        
        // Password textfield
        txtPassword.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                   y: txtAccount.frame.maxY + GlobalConst.MARGIN,
                                   width: GlobalConst.EDITTEXT_W,
                                   height: GlobalConst.EDITTEXT_H)
        txtPassword.translatesAutoresizingMaskIntoConstraints = true
        txtPassword.placeholder = DomainConst.CONTENT00050
        
        // Set icon
        setLeftViewForTextField(textField: txtPassword, named: "icon3.png")
        
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
        lblShowPassword.text = DomainConst.CONTENT00102
        lblShowPassword.translatesAutoresizingMaskIntoConstraints = true
        // Check box status
        bShowPassword = false
        
        // Login button
        btnLogin.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                y: chbShowPassword.frame.maxY + GlobalConst.MARGIN,
                                width: GlobalConst.BUTTON_W,
                                height: GlobalConst.BUTTON_H)
        btnLogin.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnLogin.setTitle(DomainConst.CONTENT00051.uppercased(), for: UIControlState())
        btnLogin.setTitleColor(UIColor.white, for: UIControlState())
        btnLogin.addTarget(self, action: #selector(Login), for: .touchUpInside)
        btnLogin.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        //self.view.addSubview(btnLogin)
        btnLogin.translatesAutoresizingMaskIntoConstraints = true
        btnLogin.setImage(UIImage(named: "icon4-ios.png"), for: UIControlState())
        btnLogin.imageView?.contentMode = .scaleAspectFit
        
        // Sign in button
        btnSignin.frame = CGRect(x: GlobalConst.SCREEN_WIDTH / 2 + GlobalConst.MARGIN / 2,
                                 y: btnLogin.frame.maxY,
                                 width: (GlobalConst.BUTTON_W - GlobalConst.MARGIN) / 2,
                                 height: GlobalConst.BUTTON_H)
        btnSignin.setTitle(DomainConst.CONTENT00228, for: UIControlState())
        //self.view.addSubview(btnSignin)
        btnSignin.translatesAutoresizingMaskIntoConstraints = true
        
        // Forgot password button
        btnForgotPass.translatesAutoresizingMaskIntoConstraints = true
        btnForgotPass.frame = CGRect(x: btnLogin.frame.minX,
                                     y: btnLogin.frame.maxY,
                                     width: (GlobalConst.BUTTON_W - GlobalConst.MARGIN) / 2,
                                     height: GlobalConst.BUTTON_H)
        
        btnForgotPass.setTitle(DomainConst.CONTENT00227, for: UIControlState())
        btnForgotPass.titleLabel?.textAlignment = .right
        //self.view.addSubview(btnForgotPass)
        
        // Separator
        btnSeparator.translatesAutoresizingMaskIntoConstraints = true
        btnSeparator.frame = CGRect(x: btnForgotPass.frame.maxX,
                                     y: btnLogin.frame.maxY,
                                     width: btnSignin.frame.minX - btnForgotPass.frame.maxX,
                                     height: GlobalConst.BUTTON_H)
        
        //btnSeparator.setTitle(DomainConst.CONTENT00226, for: UIControlState())
        btnSeparator.titleLabel?.textAlignment = .right
        //self.view.addSubview(btnForgotPass)
        
        // Navigation bar
        setupNavigationBar(title: DomainConst.CONTENT00051, isNotifyEnable: false)
        
        txtAccount.delegate     = self
        txtPassword.delegate    = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(G00LoginVC.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        
        // Fill data in training mode
        if BaseModel.shared.checkTrainningMode() {
            txtAccount.text = "truongnd"
            txtPassword.text = "123123"
        }
    }
    
    /**
     * Set left image for text field
     * - parameter textField:   Text field object
     * - parameter named:       Image name
     */
    func setLeftViewForTextField(textField: UITextField, named: String) {
        textField.leftViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                width: GlobalConst.EDITTEXT_H - GlobalConst.MARGIN_CELL_X,
                                                height: GlobalConst.EDITTEXT_H - GlobalConst.MARGIN_CELL_X))
        let img = UIImage(named: named)
        imgView.image = img
        textField.leftView = imgView
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

