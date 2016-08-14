//
//  ViewController.swift
//  project
//
//  Created by Lâm Phạm on 7/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bShowPassword:Bool!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtAccount: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var checkBoxButton: CheckBox!
    @IBOutlet weak var lblCheckBox: UILabel!
    
    @IBOutlet weak var menuRightNavBar: UIBarButtonItem!
    @IBOutlet weak var backLeftNavBar: UIBarButtonItem!
    @IBOutlet weak var loginNavBar: UINavigationItem!
    
    
    @IBAction func ShowPassword(sender: AnyObject) {
        bShowPassword = !bShowPassword
        txtPassword.secureTextEntry = !bShowPassword
    }
    //Login
    @IBAction func Login(sender: AnyObject) {
        //declare Allert
        let loginAlert = UIAlertController(title: "Alert", message: "Bạn phải nhập tài khoản và mật khẩu", preferredStyle: .Alert)
        //Alert Action
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(loginAlert) -> Void in ()})
        loginAlert.addAction(okAction)
        //check the value of text field
        if (((txtPassword.text?.isEmpty)! || (txtAccount.text?.isEmpty)!)){
            //Call alert
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }else {
            print("Login Successfully")
        }
    }
    
    //Register
    @IBAction func Register(sender: AnyObject) {
        //declare Allert
        let registerAlert = UIAlertController(title: "Alert", message: "Bạn phải nhập tài khoản và mật khẩu", preferredStyle: .Alert)
        //Alert Action
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(loginAlert) -> Void in ()})
        registerAlert.addAction(okAction)
        //check the value of the text field
        if ((txtPassword.text?.isEmpty)! || (txtAccount.text?.isEmpty)!) {
            //Call alert
            self.presentViewController(registerAlert, animated: true, completion: nil)
        }else {
            print("Register Successfully")
        }
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //background
        view.backgroundColor = UIColorFromRGB(0xECECEC)
        imgLogo.image = UIImage(named: "gas_logo.png")
        imgLogo.frame = CGRect(x: 65, y: 70, width: 190, height: 140)
        imgLogo.translatesAutoresizingMaskIntoConstraints = true
        
        //check box status
        bShowPassword = false
        
        //account text field
        txtAccount.frame = CGRect(x: 30, y: 230, width: 260, height: 30)
        txtAccount.translatesAutoresizingMaskIntoConstraints = true
        txtPassword.frame = CGRect(x: 30, y: 280, width: 260, height: 30)
        txtPassword.translatesAutoresizingMaskIntoConstraints = true
        
        //check box button
        checkBoxButton.frame = CGRect(x: 30, y: 340, width: 15, height: 15)
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = true
        lblCheckBox.frame = CGRect(x: 50, y: 338, width: 140, height: 20)
        lblCheckBox.translatesAutoresizingMaskIntoConstraints = true
        
        
        
        //login button
        loginButton.frame = CGRect(x: 30, y: 400, width: 260, height: 40)
        loginButton.backgroundColor = UIColorFromRGB(0xF00020)
        loginButton.setTitle("Đăng nhập", forState: .Normal)
        loginButton.addTarget(self, action: #selector(Login), forControlEvents: .TouchUpInside)
        loginButton.layer.cornerRadius = 6
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = true
        
        //sign in button
        signInButton.frame = CGRect(x: 30, y: 450, width: 260, height: 40)
        signInButton.backgroundColor = UIColorFromRGB(0xF00020)
        signInButton.setTitle("Đăng ký", forState: .Normal)
        signInButton.addTarget(self, action: #selector(Register), forControlEvents: .TouchUpInside)
        signInButton.layer.cornerRadius = 6
        self.view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = true
        
        
        
        //Login NavBar
        
        //loginNavBar.setLeftBarButtonItem(backLeftNavBar, animated: false)
        loginNavBar.setRightBarButtonItem(menuRightNavBar, animated: false)
        loginNavBar.title = "Đăng nhập"
        
        
        menuRightNavBar.image = UIImage(named: "menu.png")
        
        //backLeftNavBar.image = UIImage(named: "back.png")
        
        //Menu Nav Bar open
        menuRightNavBar.target = self.revealViewController()
        menuRightNavBar.enabled = false
        menuRightNavBar.action = #selector(SWRevealViewController.rightRevealToggle(_:))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //RGB color
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

