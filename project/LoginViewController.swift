//
//  ViewController.swift
//  project
//
//  Created by Lâm Phạm on 7/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {

    var bShowPassword:Bool!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtAccount: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var checkBoxButton: CheckBox!
    @IBOutlet weak var lblCheckBox: UILabel!
    
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var loginNavBar: UINavigationItem!
    var hideKeyboard:Bool = true
    var loginStatusCarrier:NSUserDefaults!
    var loginStatus:Bool = false
    var imgLogoTappedCounter:Int = 0
    
    @IBAction func backButtonTapped(sender: AnyObject) {
       self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func ShowPassword(sender: AnyObject) {
        bShowPassword = !bShowPassword
        txtPassword.secureTextEntry = !bShowPassword
    }
    //Login
    @IBAction func Login(sender: AnyObject) {
        //declare Allert
        let loginAlert = UIAlertController(title: "Alert", message: "CONTENT00023", preferredStyle: .Alert)
        //Alert Action
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(loginAlert) -> Void in ()})
        loginAlert.addAction(okAction)
        //check the value of text field
        if (((txtPassword.text?.isEmpty)! || (txtAccount.text?.isEmpty)!)){
            //Call alert
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }else {
            self.navigationController?.popViewControllerAnimated(true)
            //loginStatus = true
            //loginStatusCarrier.setObject(loginStatus, forKey: "loginStatus")
        }
    }
    
    //Register
    @IBAction func Register(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let registerVC = mainStoryboard.instantiateViewControllerWithIdentifier("RegisterViewController")
        
        //self.presentViewController(dangkiVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
   
    @IBAction func notification(sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Back", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)
    }
    func imgLogoTapped(gestureRecognizer: UITapGestureRecognizer) {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        let tappedImageView = gestureRecognizer.view!
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        imgLogoTappedCounter += 1
        print(imgLogoTappedCounter)
        if imgLogoTappedCounter == 7 {
            let imgLogoTappedCounterAlert = UIAlertController(title: "Alert", message: "To Config Screen", preferredStyle: .Alert)
            //Alert Action
            let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(loginAlert) -> Void in ()})
            imgLogoTappedCounterAlert.addAction(okAction)
            //Call alert
            self.presentViewController(imgLogoTappedCounterAlert, animated: true, completion: nil)
            imgLogoTappedCounter = 0
            print(imgLogoTappedCounter)
        }
    }
    
    func configButtonInLoginTapped(notification: NSNotification) {
        let Alert = UIAlertController(title: "Alert", message: "To Config Screen", preferredStyle: .Alert)
        //Alert Action
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(Alert) -> Void in ()})
        Alert.addAction(okAction)
        //Call alert
        self.presentViewController(Alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //transmit login status
        /*loginStatusCarrier = NSUserDefaults()
        loginStatus = (loginStatusCarrier.objectForKey("Text") as? Bool)!
        //notification button enable/disable
        if loginStatus == true {
            notificationButton.enabled = true
        } else {
            notificationButton.enabled = false
        }*/
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.configButtonInLoginTapped(_:)), name:"configButtonInLoginTapped", object: nil)
        
        //background
        view.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        imgLogo.image = UIImage(named: "gas_logo.png")
        imgLogo.frame = CGRect(x: 65, y: 70, width: 190, height: 140)
        imgLogo.translatesAutoresizingMaskIntoConstraints = true
        imgLogo.userInteractionEnabled = true
        //now you need a tap gesture recognizer
        //note that target and action point to what happens when the action is recognized.
        let imgLogoTappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.imgLogoTapped(_:)))
        //Add the recognizer to your view.
        imgLogo.addGestureRecognizer(imgLogoTappedRecognizer)
        if imgLogoTappedCounter == 7 {
            let imgLogoTappedCounterAlert = UIAlertController(title: "Alert", message: "To Config Screen", preferredStyle: .Alert)
            //Alert Action
            let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(loginAlert) -> Void in ()})
            imgLogoTappedCounterAlert.addAction(okAction)
            //check the value of text field
            
            //Call alert
            self.presentViewController(imgLogoTappedCounterAlert, animated: true, completion: nil)
        
        }
        
        //account text field
        txtAccount.frame = CGRect(x: 30, y: 230, width: 260, height: 30)
        txtAccount.translatesAutoresizingMaskIntoConstraints = true
        txtPassword.frame = CGRect(x: 30, y: 280, width: 260, height: 30)
        txtPassword.translatesAutoresizingMaskIntoConstraints = true
        self.txtAccount.becomeFirstResponder()
        //check box button
        checkBoxButton.frame = CGRect(x: 30, y: 340, width: 15, height: 15)
        checkBoxButton.tintColor = UIColor.blackColor()
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = true
        lblCheckBox.frame = CGRect(x: 50, y: 338, width: 140, height: 20)
        lblCheckBox.translatesAutoresizingMaskIntoConstraints = true
        //check box status
        bShowPassword = false
        
        
        
        //login button
        loginButton.frame = CGRect(x: 30, y: 400, width: 260, height: 40)
        loginButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        loginButton.setTitle("Đăng nhập", forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.addTarget(self, action: #selector(Login), forControlEvents: .TouchUpInside)
        loginButton.layer.cornerRadius = 6
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = true
        
        //sign in button
        signInButton.frame = CGRect(x: 30, y: 450, width: 260, height: 40)
        signInButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        signInButton.setTitle("Đăng ký", forState: .Normal)
        signInButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signInButton.addTarget(self, action: #selector(Register), forControlEvents: .TouchUpInside)
        signInButton.layer.cornerRadius = 6
        self.view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = true
        
        
        
        //login navigation bar
        loginNavBar.title = "Đăng nhập"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.enabled = true
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", forState: .Normal)
        notificationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        //notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020) //when enable
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xD5D5D5) //when disable

        notificationButton.addTarget(self, action: #selector(notification), forControlEvents: .TouchUpInside)
        let notiNavBar = UIBarButtonItem()
        notiNavBar.customView = notificationButton
        notiNavBar.enabled = false
        
        //set right navigation bar item
        self.navigationItem.rightBarButtonItems = [menuNavBar, notiNavBar]
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backButton.setImage(tintedBackLogo, forState: .Normal)
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", forState: .Normal)
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        loginNavBar.setLeftBarButtonItem(backNavBar, animated: false)
        
        txtAccount.delegate = self
        txtPassword.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)

        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //popover menu
    @IBAction func showPopOver(sender: AnyObject) {
    print("menu tapped")
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popOverMenu" {
            let popoverVC = segue.destinationViewController
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
    @IBAction func showNotification(sender: AnyObject) {
        print("noti tapped")
    }
    func hideKeyboard(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        hideKeyboard = true
        
    }
    
    internal func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
        hideKeyboard = false
        return true
    }

}

