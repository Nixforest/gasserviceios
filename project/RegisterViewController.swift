//
//  RegisterViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    //declare outlets
    @IBOutlet weak var imgCenter: UIImageView!
    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var imgAddress: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBOutlet weak var registerNavBar: UINavigationItem!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var hideKeyboard:Bool = true
    //var loginStatusCarrier:NSUserDefaults!
    //var loginStatus:Bool = false
    //declare actions
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func notificationButtonTapped(sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Back", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)
    }
    @IBAction func registerButtonTapped(sender: AnyObject) {
        //Alert
        let registerAlert = UIAlertController(title: "Alert", message: "Bạn phải nhập đầy đủ thông tin", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(registerAction) -> Void in ()})
        registerAlert.addAction(okAction)
        
        let registerCodeAlert = UIAlertController(title: "Nhập mã xác thực", message: "Một mã xác thực đã được gửi đến số điện thoại của bạn dưới dạng tin nhắn, hãy nhập nó vào ô bên dưới", preferredStyle: .Alert)
        let registerAction = UIAlertAction(title: "Đăng ký", style: .Default, handler: {(registerCodeAlert) -> Void in()
            print("Register successfully")
            })
        let cancelAction = UIAlertAction(title: "Để sau", style: .Cancel, handler: {(registerCodeAlert) -> Void in()
        })
        registerCodeAlert.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            let firstTextField = registerCodeAlert.textFields![0] as UITextField
            firstTextField.placeholder = "Mã xác thực"
            firstTextField.layer.cornerRadius = 20.0
            }
        registerCodeAlert.addAction(registerAction)
        registerCodeAlert.addAction(cancelAction)
        
        //check the value of text field
        if (((txtName.text?.isEmpty)! || (txtPhone.text?.isEmpty)! || (txtAddress.text?.isEmpty)!)){
            //Call alert
            self.presentViewController(registerAlert, animated: true, completion: nil)
        }else {
            self.presentViewController(registerCodeAlert, animated: true, completion: nil)
        }
    }
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        //logo customize
        imgCenter.frame = CGRect(x: (self.view.frame.size.width - 140)/2, y: 70, width: 140, height: 140)
        imgCenter.image = UIImage(named: "contact.png")
        imgCenter.translatesAutoresizingMaskIntoConstraints = true
        imgName.frame = CGRect(x: 20, y: 230, width: 40, height: 40)
        imgName.image = UIImage(named: "contact.png")
        imgName.translatesAutoresizingMaskIntoConstraints = true
        imgPhone.frame = CGRect(x: 20, y: 280, width: 40, height: 40)
        imgPhone.image = UIImage(named: "mobile.png")
        imgPhone.translatesAutoresizingMaskIntoConstraints = true
        imgAddress.frame = CGRect(x: 20, y: 330, width: 40, height: 40)
        imgAddress.image = UIImage(named: "address.png")
        imgAddress.translatesAutoresizingMaskIntoConstraints = true
        
        //textfield customize
        txtName.frame = CGRect(x: 70, y: 230, width: 220, height: 40)
        txtName.placeholder = "Họ và tên"
        txtName.translatesAutoresizingMaskIntoConstraints = true
        txtName.delegate = self
        txtPhone.frame = CGRect(x: 70, y: 280, width: 220, height: 40)
        txtPhone.placeholder = "Số điện thoại"
        txtPhone.translatesAutoresizingMaskIntoConstraints = true
        txtPhone.delegate = self
        txtAddress.frame = CGRect(x: 70, y: 330, width: 220, height: 40)
        txtAddress.placeholder = "Địa chỉ"
        txtAddress.translatesAutoresizingMaskIntoConstraints = true
        txtAddress.delegate = self
        //button customize
        registerButton.frame = CGRect(x: 30, y: 400, width: 260, height: 30)
        registerButton.setTitle("Đăng ký", forState: .Normal)
        registerButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.layer.cornerRadius = 6
        //registerButton.addTarget(self, action: #selector(registerButtonTapped), forControlEvents: .TouchUpInside)
        //self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = true
                
        //Navigation Bar customize
        registerNavBar.title = "Đăng ký"
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.enabled = false //disable menu button
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", forState: .Normal)
        notificationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        
        registerNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)
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
        
        registerNavBar.setLeftBarButtonItem(backNavBar, animated: false)
        
        //let aColor:UIColor = ColorFromRGB().getColorFromRGB(0xF00020)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
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
    internal func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
        if hideKeyboard == true {
        UIView.animateWithDuration(0.3) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 100, self.view.frame.size.width, self.view.frame.size.height)
            }
            hideKeyboard = false
        }
        return true
    }
    func hideKeyboard(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        UIView.animateWithDuration(0.3) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)
        }
        hideKeyboard = true
        
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
