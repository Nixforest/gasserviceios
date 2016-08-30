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
    
    
    @IBOutlet weak var checkboxButton: CheckBox!
    @IBOutlet weak var lblCheckboxButton: UILabel!
    
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtNewPasswordRetype: UITextField!
    
    var hideKeyboard:Bool = true
    var loginStatus:NSUserDefaults!
    
    @IBAction func checkboxButtonTapped(sender: AnyObject) {
        bShowPassword = !bShowPassword
        txtOldPassword.secureTextEntry = !bShowPassword
        txtNewPassword.secureTextEntry = !bShowPassword
        txtNewPasswordRetype.secureTextEntry = !bShowPassword
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func saveButtonTapped(sender: AnyObject) {
        //Alert
        let saveAlert = UIAlertController(title: "Alert", message: "Bạn phải nhập đầy đủ thông tin", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(saveAlert) -> Void in ()})
        saveAlert.addAction(okAction)
        
        let checkNewPasswordAlert = UIAlertController(title: "Alert", message: "Mật khẩu mới không trùng nhau", preferredStyle: .Alert)
        checkNewPasswordAlert.addAction(okAction)
        
        if (((txtOldPassword.text?.isEmpty)! || (txtNewPassword.text?.isEmpty)! || (txtNewPasswordRetype.text?.isEmpty)!)){
            //Call alert
            self.presentViewController(saveAlert, animated: true, completion: nil)
        }else {
        }
        if((txtNewPassword.text) == (txtNewPasswordRetype.text)){
            print("password update successfully")
        }else {
            self.presentViewController(checkNewPasswordAlert, animated: true, completion: nil)
        }

    }
    
    @IBAction func notificationButtonTapped(sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Back", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //background
        view.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        
        //textfield customize
        txtOldPassword.frame = CGRect(x: 45, y: 100, width: 230, height: 40)
        txtOldPassword.placeholder = "Mật khẩu cũ"
        txtOldPassword.translatesAutoresizingMaskIntoConstraints = true
        txtOldPassword.delegate = self
        
        txtNewPassword.frame = CGRect(x: 45, y: 150, width: 230, height: 40)
        txtNewPassword.placeholder = "Mật khẩu mới"
        txtNewPassword.translatesAutoresizingMaskIntoConstraints = true
        txtNewPassword.delegate = self
        txtNewPasswordRetype.frame = CGRect(x: 45, y: 200, width: 230, height: 40)
        txtNewPasswordRetype.placeholder = "Nhập lại mật khẩu mới"
        txtNewPasswordRetype.translatesAutoresizingMaskIntoConstraints = true
        txtNewPasswordRetype.delegate = self
        //check box button
        checkboxButton.frame = CGRect(x: 45, y: 250, width: 15, height: 15)
        checkboxButton.tintColor = UIColor.blackColor()
        checkboxButton.translatesAutoresizingMaskIntoConstraints = true
        lblCheckboxButton.frame = CGRect(x: 65, y: 248, width: 140, height: 20)
        lblCheckboxButton.text = "Hiện mật khẩu"
        lblCheckboxButton.translatesAutoresizingMaskIntoConstraints = true
        //check box status
        bShowPassword = false
        
        //button customize
        saveButton.frame = CGRect(x: 30, y: 310, width: 260, height: 30)
        saveButton.setTitle("Lưu", forState: .Normal)
        saveButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        saveButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = true
        saveButton.layer.cornerRadius = 6
        
        
        //Navigation Bar customize
        changePasswordNavBar.title = "Đổi mật khẩu"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.enabled = false//disable menu button
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", forState: .Normal)
        notificationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        //notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        changePasswordNavBar.setLeftBarButtonItems([menuNavBar, notificationNavBar], animated: false)
        //back button
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backButton.setImage(tintedBackLogo, forState: .Normal)
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", forState: .Normal)
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        changePasswordNavBar.setLeftBarButtonItem(backNavBar, animated: false)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popoverMenu" {
            let popoverVC = segue.destinationViewController
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    func hideKeyboard(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        hideKeyboard = true
    }
    
    internal func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
        hideKeyboard = false
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
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
            UIView.animateWithDuration(0.3) {
                self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)
            }
        }
        return true
    }


}
