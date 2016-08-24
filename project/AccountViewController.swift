//
//  AccountViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var accountNavBar: UINavigationItem!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var imgAccountCenter: UIImageView!
    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var imgAddress: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    
    @IBAction func notificationButtonTapped(sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Trở lại", style: .Cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.presentViewController(notificationAlert, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let saveAlert = UIAlertController(title: "Alert", message: "Bạn phải nhập đầy đủ thông tin", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(saveAlert) -> Void in ()})
        saveAlert.addAction(okAction)
        //check the value of text field
        if (((txtName.text?.isEmpty)! || (txtPhone.text?.isEmpty)! || (txtAddress.text?.isEmpty)!)){
            //Call alert
            self.presentViewController(saveAlert, animated: true, completion: nil)
        }else {
            print("Save successfully")
        }
    }
    
    @IBAction func changePasswordTapped(sender: AnyObject) {
        let mainStoryoard = UIStoryboard(name: "Main", bundle: nil)
        
        let changePasswordVC = mainStoryoard.instantiateViewControllerWithIdentifier("ChangePasswordViewController")
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
        print("to login screen")
    
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background
        view.backgroundColor = ColorFromRGB().getColorFromRGB(0xECECEC)
        
        //logo customize
        imgAccountCenter.frame = CGRect(x: 90, y: 70, width: 140, height: 140)
        imgAccountCenter.image = UIImage(named: "contact.png")
        imgAccountCenter.translatesAutoresizingMaskIntoConstraints = true
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
        saveButton.frame = CGRect(x: 30, y: 380, width: 260, height: 30)
        saveButton.setTitle("Lưu", forState: .Normal)
        saveButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        saveButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = true
        saveButton.layer.cornerRadius = 6
        changePasswordButton.frame = CGRect(x: 30, y: 420, width: 260, height: 30)
        changePasswordButton.setTitle("Đổi mật khẩu", forState: .Normal)
        changePasswordButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        changePasswordButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        changePasswordButton.layer.cornerRadius = 6
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = true
        exitButton.frame = CGRect(x: 30, y: 460, width: 260, height: 30)
        exitButton.setTitle("Thoát", forState: .Normal)
        exitButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        exitButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        exitButton.layer.cornerRadius = 6
        exitButton.translatesAutoresizingMaskIntoConstraints = true
        
        //Navigation Bar customize
        accountNavBar.title = "Tài khoản"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.enabled = true //disable menu button
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", forState: .Normal)
        notificationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        //notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        //set right bar item
        accountNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)
    
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backButton.setImage(tintedBackLogo, forState: .Normal)
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", forState: .Normal)
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        accountNavBar.setLeftBarButtonItem(backNavBar, animated: false)


        // Do any additional setup after loading the view.
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

}
