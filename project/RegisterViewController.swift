//
//  RegisterViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //declare outlets
    @IBOutlet weak var imgCenter: UIImageView!
    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var imgAddress: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var registerNavBar: UINavigationItem!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    //declare actions
    @IBAction func notificationButtonTapped(sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Back", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)
    }
    @IBAction func registerButtonTapped(sender: AnyObject) {
        //declare Allert
        let registerAlert = UIAlertController(title: "Alert", message: "Bạn phải nhập đầy đủ thông tin", preferredStyle: .Alert)
        //Alert Action
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(loginAlert) -> Void in ()})
        registerAlert.addAction(okAction)
        //check the value of text field
        if (((txtName.text?.isEmpty)! || (txtPhone.text?.isEmpty)! || (txtAddress.text?.isEmpty)!)){
            //Call alert
            self.presentViewController(registerAlert, animated: true, completion: nil)
        }else {
            print("Register Successfully")
        }
    }
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        print("Cancel button tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background
        view.backgroundColor = UIColorFromRGB(0xECECEC)
        
        //logo customize
        imgCenter.frame = CGRect(x: 90, y: 70, width: 140, height: 140)
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
        
        txtPhone.frame = CGRect(x: 70, y: 280, width: 220, height: 40)
        txtPhone.placeholder = "Số điện thoại"
        txtPhone.translatesAutoresizingMaskIntoConstraints = true
        
        txtAddress.frame = CGRect(x: 70, y: 330, width: 220, height: 40)
        txtAddress.placeholder = "Địa chỉ"
        txtAddress.translatesAutoresizingMaskIntoConstraints = true
        
        //button customize
        registerButton.frame = CGRect(x: 30, y: 380, width: 260, height: 30)
        registerButton.setTitle("Đăng ký", forState: .Normal)
        registerButton.backgroundColor = UIColorFromRGB(0xF00020)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.layer.cornerRadius = 6
        //registerButton.addTarget(self, action: #selector(registerButtonTapped), forControlEvents: .TouchUpInside)
        //self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = true
        cancelButton.frame = CGRect(x: 30, y: 420, width: 260, height: 30)
        cancelButton.setTitle("Thoát", forState: .Normal)
        cancelButton.backgroundColor = UIColorFromRGB(0xF00020)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancelButton.layer.cornerRadius = 6
        //cancelButton.addTarget(self, action: #selector(cancelButtonTapped), forControlEvents: .TouchUpInside)
        //self.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = true
        
        //Navigation Bar customize
        registerNavBar.title = "Đăng nhập"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColorFromRGB(0xF00020)]
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = UIColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
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
        notificationButton.backgroundColor = UIColorFromRGB(0xF00020)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        
        //set right bar item
        registerNavBar.setLeftBarButtonItems([menuNavBar, notificationNavBar], animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //color from RGB
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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

}
