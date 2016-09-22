//
//  ChangePasswordViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UIPopoverPresentationControllerDelegate,UITextFieldDelegate {

    var bShowPassword:Bool!
    @IBOutlet weak var changePasswordNavBar: UINavigationItem!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBOutlet weak var checkboxButton: CheckBox!
    @IBOutlet weak var lblCheckboxButton: UILabel!
    
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtNewPasswordRetype: UITextField!
    
    var hideKeyboard:Bool = true
    //var loginStatusCarrier:NSUserDefaults!
    //var loginStatus:Bool = false
    
    func menuButtonTapped(_ sender: AnyObject) {
        print("menu tapped")
    }
    
    @IBAction func checkboxButtonTapped(_ sender: AnyObject) {
        bShowPassword = !bShowPassword
        txtOldPassword.isSecureTextEntry = !bShowPassword
        txtNewPassword.isSecureTextEntry = !bShowPassword
        txtNewPasswordRetype.isSecureTextEntry = !bShowPassword
    }
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        GlobalConst.LOGIN_STATUS = false
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        //Alert
        let saveAlert = UIAlertController(title: "Alert", message: "@CONTENT00025", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {(saveAlert) -> Void in ()})
        saveAlert.addAction(okAction)
        
        let checkNewPasswordAlert = UIAlertController(title: "Alert", message: "@CONTENT00026", preferredStyle: .alert)
        checkNewPasswordAlert.addAction(okAction)
        
        if (((txtOldPassword.text?.isEmpty)! || (txtNewPassword.text?.isEmpty)! || (txtNewPasswordRetype.text?.isEmpty)!)){
            //Call alert
            self.present(saveAlert, animated: true, completion: nil)
        }else {
        }
        if((txtNewPassword.text) == (txtNewPasswordRetype.text)){
            print("password update successfully")
        }else {
            self.present(checkNewPasswordAlert, animated: true, completion: nil)
        }

    }
    
    @IBAction func notificationButtonTapped(_ sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Back", style: .cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.present(notificationAlert, animated: true, completion: nil)
    }
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        
    }
    //NSNotification action
    func gasServiceButtonInChangePassVCTapped(_ notification: Notification) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func issueButtonInChangePassVCTapped(_ notification: Notification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    func configButtonInChangePassVCTapped(_ notification: Notification) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: "ConfigurationViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    
    func trainingModeOn(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
    }
    func trainingModeOff(_ notification: Notification) {
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(ChangePasswordViewController.trainingModeOn(_:)), name:NSNotification.Name(rawValue: "TrainingModeOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChangePasswordViewController.trainingModeOff(_:)), name:NSNotification.Name(rawValue: "TrainingModeOff"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChangePasswordViewController.gasServiceButtonInChangePassVCTapped(_:)), name:NSNotification.Name(rawValue: "gasServiceButtonInChangePassVCTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChangePasswordViewController.issueButtonInChangePassVCTapped(_:)), name:NSNotification.Name(rawValue: "issueButtonInChangePassVCTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChangePasswordViewController.configButtonInChangePassVCTapped(_:)), name:NSNotification.Name(rawValue: "configButtonInChangePassVCTapped"), object: nil)
        
        //transmit login status
        /*loginStatusCarrier = NSUserDefaults()
        loginStatus = (loginStatusCarrier.objectForKey("loginStatus") as? Bool)!
        //notification button enable/disable
        if loginStatus == true {
            notificationButton.enabled = true
        } else {
            notificationButton.enabled = false
        }*/
        //background
        view.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        //textfield customize
        txtOldPassword.frame = CGRect(x: 45, y: 100, width: 230, height: 40)
        txtOldPassword.placeholder = GlobalConst.CONTENT00083
        txtOldPassword.translatesAutoresizingMaskIntoConstraints = true
        txtOldPassword.delegate = self
        
        txtNewPassword.frame = CGRect(x: 45, y: 150, width: 230, height: 40)
        txtNewPassword.placeholder = GlobalConst.CONTENT00084
        txtNewPassword.translatesAutoresizingMaskIntoConstraints = true
        txtNewPassword.delegate = self
        txtNewPasswordRetype.frame = CGRect(x: 45, y: 200, width: 230, height: 40)
        txtNewPasswordRetype.placeholder = GlobalConst.CONTENT00085
        txtNewPasswordRetype.translatesAutoresizingMaskIntoConstraints = true
        txtNewPasswordRetype.delegate = self
        //check box button
        checkboxButton.frame = CGRect(x: 45, y: 250, width: 15, height: 15)
        checkboxButton.tintColor = UIColor.black
        checkboxButton.translatesAutoresizingMaskIntoConstraints = true
        lblCheckboxButton.frame = CGRect(x: 65, y: 248, width: 140, height: 20)
        lblCheckboxButton.text = GlobalConst.CONTENT00102
        lblCheckboxButton.translatesAutoresizingMaskIntoConstraints = true
        //check box status
        bShowPassword = false
        txtOldPassword.isSecureTextEntry = !bShowPassword
        txtNewPassword.isSecureTextEntry = !bShowPassword
        txtNewPasswordRetype.isSecureTextEntry = !bShowPassword
        
        //button customize
        saveButton.frame = CGRect(x: 30, y: 310, width: 260, height: 30)
        saveButton.setTitle(GlobalConst.CONTENT00086, for: UIControlState())
        saveButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        saveButton.setTitleColor(UIColor.white, for: UIControlState())
        saveButton.translatesAutoresizingMaskIntoConstraints = true
        saveButton.layer.cornerRadius = 6
        
        logoutButton.frame = CGRect(x: 30, y: 350, width: 260, height: 30)
        logoutButton.setTitle(GlobalConst.CONTENT00090, for: UIControlState())
        logoutButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        logoutButton.setTitleColor(UIColor.white, for: UIControlState())
        logoutButton.layer.cornerRadius = 6
        logoutButton.translatesAutoresizingMaskIntoConstraints = true

        
        
        //Navigation Bar customize
        changePasswordNavBar.title = GlobalConst.CONTENT00089
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImage, for: UIControlState())
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        menuButton.setTitle("", for: UIControlState())
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.isEnabled = true//disable menu button
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", for: UIControlState())
        notificationButton.setTitleColor(UIColor.white, for: UIControlState())
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        //notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        changePasswordNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)
        //back button
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBackLogo, for: UIControlState())
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", for: UIControlState())
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        changePasswordNavBar.setLeftBarButton(backNavBar, animated: false)
        // Do any additional setup after loading the view.
        
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

    //popover menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverMenu" {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    func hideKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        hideKeyboard = true
    }
    
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        hideKeyboard = false
        return true
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


}
