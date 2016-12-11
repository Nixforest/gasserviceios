//
//  RegisterViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit


class RegisterViewController: CommonViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    //declare outlets
    @IBOutlet weak var imgCenter: UIImageView!
    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var imgAddress: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!    
    //var loginStatusCarrier:NSUserDefaults!
    //var loginStatus:Bool = false
    //declare actions
    
    @IBAction func showPopover(_ sender: AnyObject) {
        print("menu tapped")
    }
    
    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        //Alert
        let registerAlert = UIAlertController(title: "Alert", message: "Bạn phải nhập đầy đủ thông tin", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {(registerAction) -> Void in ()})
        registerAlert.addAction(okAction)
        
        let registerCodeAlert = UIAlertController(title: "Nhập mã xác thực", message: "Một mã xác thực đã được gửi đến số điện thoại của bạn dưới dạng tin nhắn, hãy nhập nó vào ô bên dưới", preferredStyle: .alert)
        let registerAction = UIAlertAction(title: "Đăng ký", style: .default, handler: {(registerCodeAlert) -> Void in()
            print("Register successfully")
            })
        let cancelAction = UIAlertAction(title: "Để sau", style: .cancel, handler: {(registerCodeAlert) -> Void in()
        })
        registerCodeAlert.addTextField { (textField : UITextField!) -> Void in
            let firstTextField = registerCodeAlert.textFields![0] as UITextField
            firstTextField.placeholder = "Mã xác thực"
            firstTextField.layer.cornerRadius = 20.0
            }
        registerCodeAlert.addAction(registerAction)
        registerCodeAlert.addAction(cancelAction)
        
        //check the value of text field
        if (((txtName.text?.isEmpty)! || (txtPhone.text?.isEmpty)! || (txtAddress.text?.isEmpty)!)){
            //Call alert
            self.present(registerAlert, animated: true, completion: nil)
        }else {
            self.present(registerCodeAlert, animated: true, completion: nil)
        }
    }
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        
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
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        //logo customize
        imgCenter.frame = CGRect(x: (self.view.frame.size.width - 140)/2, y: 70, width: 140, height: 140)
        imgCenter.image = UIImage(named: GlobalConst.CONTACT_IMG_NAME)
        imgCenter.translatesAutoresizingMaskIntoConstraints = true
        imgName.frame = CGRect(x: 20, y: 230, width: 40, height: 40)
        imgName.image = UIImage(named: GlobalConst.CONTACT_IMG_NAME)
        imgName.translatesAutoresizingMaskIntoConstraints = true
        imgPhone.frame = CGRect(x: 20, y: 280, width: 40, height: 40)
        imgPhone.image = UIImage(named: GlobalConst.PHONE_IMG_NAME)
        imgPhone.translatesAutoresizingMaskIntoConstraints = true
        imgAddress.frame = CGRect(x: 20, y: 330, width: 40, height: 40)
        imgAddress.image = UIImage(named: GlobalConst.ADDRESS_IMG_NAME)
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
        registerButton.setTitle("Đăng ký", for: UIControlState())
        registerButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        registerButton.setTitleColor(UIColor.white, for: UIControlState())
        registerButton.layer.cornerRadius = 6
        //registerButton.addTarget(self, action: #selector(registerButtonTapped), forControlEvents: .TouchUpInside)
        //self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = true
                
        //Navigation Bar customize
        navigationBar.title = GlobalConst.CONTENT00052
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImage, for: UIControlState())
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        menuButton.addTarget(self, action: #selector(showPopover), for: .touchUpInside)
        menuButton.setTitle("", for: UIControlState())
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.isEnabled = true //disable menu button
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", for: UIControlState())
        notificationButton.setTitleColor(UIColor.white, for: UIControlState())
        //notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)//when enable
        notificationButton.backgroundColor = UIColor.gray//when disable
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        notificationNavBar.isEnabled = false
        
        navigationBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)
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
        
        navigationBar.setLeftBarButton(backNavBar, animated: false)
        
        //let aColor:UIColor = ColorFromRGB().getColorFromRGB(0xF00020)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //popover menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GlobalConst.POPOVER_MENU_IDENTIFIER {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
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
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) 
        isKeyboardShow = false
        
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
