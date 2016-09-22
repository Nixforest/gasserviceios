//
//  ViewController.swift
//  project
//
//  Created by Lâm Phạm on 7/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class LoginViewController: CommonViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    //MARK: Properties
    var bShowPassword:Bool!
    /**
     * Logo image
     */
    @IBOutlet weak var imgLogo: UIImageView!
    /**
     * Account edit text
     */
    @IBOutlet weak var txtAccount: UITextField!
    /**
     * Password edit text
     */
    @IBOutlet weak var txtPassword: UITextField!
    /**
     * Login button
     */
    @IBOutlet weak var btnLogin: UIButton!
    /**
     * Sign in button
     */
    @IBOutlet weak var btnSignin: UIButton!
    /**
     * Show password checkbox
     */
    @IBOutlet weak var chbShowPassword: CheckBox!
    /**
     * Show password label
     */
    @IBOutlet weak var lblShowPassword: UILabel!
    /**
     * Notification button
     */
    @IBOutlet weak var btnNotification: UIButton!
    /**
     * Menu button
     */
    @IBOutlet weak var btnMenu: UIButton!
    /**
     * Back button
     */
    @IBOutlet weak var btnBack: UIButton!
    
    var loginStatusCarrier:UserDefaults!
    var loginStatus:Bool = false
    var imgLogoTappedCounter:Int = 0
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //MARK: Actions
    /**
     * Handle tap on Back button
     * - parameter sender:AnyObject
     */
    @IBAction func backButtonTapped(_ sender: AnyObject) {
       _ = self.navigationController?.popViewController(animated: true)
        print("Click back button")
    }
    
    /// Handle check/uncheck on Show password checkbox
    /// - parameter sender:AnyObject
    @IBAction func showPassword(_ sender: AnyObject) {
        bShowPassword = !bShowPassword
        txtPassword.isSecureTextEntry = !bShowPassword
    }
    
    /// Handle tap on Login button
    /// - parameter sender:AnyObject
    @IBAction func Login(_ sender: AnyObject) {
        //declare Allert
        let loginAlert = UIAlertController(title: "Alert", message: GlobalConst.CONTENT00023, preferredStyle: .alert)
        //Alert Action
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {(loginAlert) -> Void in ()})
        loginAlert.addAction(okAction)
        // Check the value of text field
        if (((txtPassword.text?.isEmpty)! || (txtAccount.text?.isEmpty)!)){
            // Call alert
            self.present(loginAlert, animated: true, completion: nil)
        } else {
            GlobalConst.LOGIN_STATUS = true
            _ = self.navigationController?.popViewController(animated: true)
            print(GlobalConst.LOGIN_STATUS)
            //loginStatus = true
            //loginStatusCarrier.setObject(loginStatus, forKey: "loginStatus")
        }
    }
    
    /// Handle tap on Login button
    /// - parameter sender:AnyObject
    @IBAction func Register(_ sender: AnyObject) {
        //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let registerVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.REGISTER_VIEW_CTRL)
        
        //self.presentViewController(dangkiVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    /**
     * Handle tap on Notification button
     */
    @IBAction func notification(_ sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Back", style: .cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.present(notificationAlert, animated: true, completion: nil)
    }
    /**
     * Handle tap on Logo image
     */
    func imgLogoTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        //let tappedImageView = gestureRecognizer.view!
        imgLogoTappedCounter += 1
        print(imgLogoTappedCounter)
        if imgLogoTappedCounter == 7 {
            imgLogoTappedCounter = 0
            print(imgLogoTappedCounter)
            //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let configVC = mainStoryboard.instantiateViewController(withIdentifier: "ConfigurationViewController")
            self.navigationController?.pushViewController(configVC, animated: true)
            
        }
    }
    
    /**
     * Handle tap on Configuration menu item
     */
    func configButtonInLoginTapped(_ notification: Notification) {
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.CONFIGURATION_VIEW_CTRL)
        self.navigationController?.pushViewController(configVC, animated: true)
    }
//    /**
//     * Handle turn on training mode
//     */
//    func trainingModeOn(_ notification: Notification) {
//        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
//    }
//    /**
//     * Handle turn off training mode
//     */
//    func trainingModeOff(_ notification: Notification) {
//        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//    }
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        //transmit login status
        /*loginStatusCarrier = NSUserDefaults()
        loginStatus = (loginStatusCarrier.objectForKey("Text") as? Bool)!
        //notification button enable/disable
        if loginStatus == true {
            btnNotification.enabled = true
        } else {
            btnNotification.enabled = false
        }*/
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.trainingModeOn(_:)), name:NSNotification.Name(rawValue: "TrainingModeOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.trainingModeOn(_:)),name:NSNotification.Name(rawValue: "TrainingModeOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.trainingModeOff(_:)), name:NSNotification.Name(rawValue: "TrainingModeOff"), object: nil)
        //CommonProcess.handleTrainingMode(self)

        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.configButtonInLoginTapped(_:)), name:NSNotification.Name(rawValue: "configButtonInLoginTapped"), object: nil)
        
        //background
        view.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
    
        imgLogo.image = UIImage(named: "gas_logo.png")
        imgLogo.frame = CGRect(x: 65, y: 70, width: 190, height: 140)
        imgLogo.translatesAutoresizingMaskIntoConstraints = true
        imgLogo.isUserInteractionEnabled = true
        //now you need a tap gesture recognizer
        //note that target and action point to what happens when the action is recognized.
        let imgLogoTappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.imgLogoTapped(_:)))
        //Add the recognizer to your view.
        imgLogo.addGestureRecognizer(imgLogoTappedRecognizer)
        
        
        //account text field
        txtAccount.frame = CGRect(x: 30, y: 230, width: 260, height: 30)
        txtAccount.placeholder = GlobalConst.CONTENT00049
        txtAccount.translatesAutoresizingMaskIntoConstraints = true
        self.txtAccount.becomeFirstResponder()
        
        txtPassword.frame = CGRect(x: 30, y: 280, width: 260, height: 30)
        txtPassword.translatesAutoresizingMaskIntoConstraints = true
        txtPassword.placeholder = GlobalConst.CONTENT00050
        
        //check box button
        chbShowPassword.frame = CGRect(x: 30, y: 340, width: 15, height: 15)
        chbShowPassword.tintColor = UIColor.black
        chbShowPassword.translatesAutoresizingMaskIntoConstraints = true
        lblShowPassword.frame = CGRect(x: 50, y: 338, width: 120, height: 20)
        lblShowPassword.text = GlobalConst.CONTENT00102
        lblShowPassword.translatesAutoresizingMaskIntoConstraints = true
        //check box status
        bShowPassword = false
        
        
        
        //login button
        btnLogin.frame = CGRect(x: 30, y: 400, width: 260, height: 40)
        btnLogin.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        btnLogin.setTitle(GlobalConst.CONTENT00051, for: UIControlState())
        btnLogin.setTitleColor(UIColor.white, for: UIControlState())
        btnLogin.addTarget(self, action: #selector(Login), for: .touchUpInside)
        btnLogin.layer.cornerRadius = 6
        self.view.addSubview(btnLogin)
        btnLogin.translatesAutoresizingMaskIntoConstraints = true
        
        //sign in button
        btnSignin.frame = CGRect(x: 30, y: 450, width: 260, height: 40)
        btnSignin.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        btnSignin.setTitle(GlobalConst.CONTENT00052, for: UIControlState())
        btnSignin.setTitleColor(UIColor.white, for: UIControlState())
        btnSignin.addTarget(self, action: #selector(Register), for: .touchUpInside)
        btnSignin.layer.cornerRadius = 6
        self.view.addSubview(btnSignin)
        btnSignin.translatesAutoresizingMaskIntoConstraints = true
        
        
        
        //login navigation bar
        navigationBar.title = GlobalConst.CONTENT00051
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        btnMenu.setImage(tintedImage, for: UIControlState())
        btnMenu.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        btnMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        btnMenu.addTarget(self, action: #selector(showPopOver), for: .touchUpInside)
        btnMenu.setTitle("", for: UIControlState())
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = btnMenu
        menuNavBar.isEnabled = true
        
        //noti button on NavBar
        btnNotification.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnNotification.layer.cornerRadius = 0.5 * btnNotification.bounds.size.width
        btnNotification.setTitle("!", for: UIControlState())
        btnNotification.setTitleColor(UIColor.white, for: UIControlState())
        //btnNotification.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020) //when enable
        btnNotification.backgroundColor = ColorFromRGB().getColorFromRGB(0xD5D5D5) //when disable

        btnNotification.addTarget(self, action: #selector(notification), for: .touchUpInside)
        let notiNavBar = UIBarButtonItem()
        notiNavBar.customView = btnNotification
        notiNavBar.isEnabled = false
        
        //set right navigation bar item
        self.navigationItem.rightBarButtonItems = [menuNavBar, notiNavBar]
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        btnBack.setImage(tintedBackLogo, for: UIControlState())
        btnBack.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //btnMenu.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        btnBack.setTitle("", for: UIControlState())
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = btnBack
        navigationBar.setLeftBarButton(backNavBar, animated: false)
        
        txtAccount.delegate = self
        txtPassword.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)

        
    }
    
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        
    }

    

    //popover menu
    @IBAction func showPopOver(_ sender: AnyObject) {
    print("menu tapped")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popOverMenu" {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    @IBAction func showNotification(_ sender: AnyObject) {
        print("noti tapped")
    }
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//            })
        isKeyboardShow = false
        
    }
    
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

