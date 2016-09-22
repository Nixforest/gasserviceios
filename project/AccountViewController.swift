//
//  AccountViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class AccountViewController: CommonViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var accountNavBar: UINavigationItem!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var imgAddress: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    var hideKeyboard:Bool = true
    //var loginStatusCarrier:NSUserDefaults!
    //var loginStatus:Bool = false
    var userAvatarPicker = UIImagePickerController()
    
    @IBAction func notificationButtonTapped(_ sender: AnyObject) {
        let notificationAlert = UIAlertController(title: "Thông báo", message: "Bạn có tin nhắn mới", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Trở lại", style: .cancel, handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.present(notificationAlert, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        let saveAlert = UIAlertController(title: "Alert", message: "Bạn phải nhập đầy đủ thông tin", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {(saveAlert) -> Void in ()})
        saveAlert.addAction(okAction)
        //check the value of text field
        if (((txtName.text?.isEmpty)! || (txtPhone.text?.isEmpty)! || (txtAddress.text?.isEmpty)!)){
            //Call alert
            self.present(saveAlert, animated: true, completion: nil)
        }else {
            print("Save successfully")
        }
    }
    
    @IBAction func changePasswordTapped(_ sender: AnyObject) {
        let mainStoryoard = UIStoryboard(name: "Main", bundle: nil)
        
        let changePasswordVC = mainStoryoard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        GlobalConst.LOGIN_STATUS = false
        self.navigationController?.popViewController(animated: true)
    }
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        
    }
    //NSNotification action
    func gasServiceButtonInAccountVCTapped(_ notification: Notification) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func issueButtonInAccountVCTapped(_ notification: Notification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
         self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    func configButtonInAccountVCTapped(_ notification: Notification) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: "ConfigurationViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    
//    func trainingModeOn(_ notification: Notification) {
//        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
//    }
//    func trainingModeOff(_ notification: Notification) {
//        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//    }

    
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
        imgAvatar.frame = CGRect(x: 90, y: 70, width: 140, height: 140)
        imgAvatar.image = UIImage(named: "contact.png")
        imgAvatar.translatesAutoresizingMaskIntoConstraints = true
        imgAvatar.isUserInteractionEnabled = true
        
        let avatarTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AccountViewController.avatarPicker))
        avatarTap.numberOfTapsRequired = 1
        imgAvatar.addGestureRecognizer(avatarTap)
        self.view.addSubview(imgAvatar)
        
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
        saveButton.frame = CGRect(x: 30, y: 380, width: 260, height: 30)
        saveButton.setTitle(GlobalConst.CONTENT00086, for: UIControlState())
        saveButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        saveButton.setTitleColor(UIColor.white, for: UIControlState())
        saveButton.translatesAutoresizingMaskIntoConstraints = true
        saveButton.layer.cornerRadius = 6
        changePasswordButton.frame = CGRect(x: 30, y: 420, width: 260, height: 30)
        changePasswordButton.setTitle(GlobalConst.CONTENT00089, for: UIControlState())
        changePasswordButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        changePasswordButton.setTitleColor(UIColor.white, for: UIControlState())
        changePasswordButton.layer.cornerRadius = 6
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = true
        logoutButton.frame = CGRect(x: 30, y: 460, width: 260, height: 30)
        logoutButton.setTitle(GlobalConst.CONTENT00090, for: UIControlState())
        logoutButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        logoutButton.setTitleColor(UIColor.white, for: UIControlState())
        logoutButton.layer.cornerRadius = 6
        logoutButton.translatesAutoresizingMaskIntoConstraints = true
        
        //Navigation Bar customize
        accountNavBar.title = GlobalConst.CONTENT00100
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        
        
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menuButton.setImage(tintedImage, for: UIControlState())
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        menuButton.setTitle("", for: UIControlState())
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.isEnabled = true //disable menu button
        
        //noti button on NavBar
        notificationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationButton.layer.cornerRadius = 0.5 * notificationButton.bounds.size.width
        notificationButton.setTitle("!", for: UIControlState())
        notificationButton.setTitleColor(UIColor.white, for: UIControlState())
        notificationButton.backgroundColor = ColorFromRGB().getColorFromRGB(0xF00020)
        //notificationButton.addTarget(self, action: #selector(notificationButtonTapped), forControlEvents: .TouchUpInside)
        let notificationNavBar = UIBarButtonItem()
        notificationNavBar.customView = notificationButton
        //set right bar item
        accountNavBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)
    
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBackLogo, for: UIControlState())
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", for: UIControlState())
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        accountNavBar.setLeftBarButton(backNavBar, animated: false)


        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(AccountViewController.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.trainingModeOn(_:)), name:NSNotification.Name(rawValue: "TrainingModeOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.trainingModeOff(_:)), name:NSNotification.Name(rawValue: "TrainingModeOff"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.gasServiceButtonInAccountVCTapped(_:)), name:NSNotification.Name(rawValue: "gasServiceButtonInAccountVCTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.issueButtonInAccountVCTapped(_:)), name:NSNotification.Name(rawValue: "issueButtonInAccountVCTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.configButtonInAccountVCTapped(_:)), name:NSNotification.Name(rawValue: "configButtonInAccountVCTapped"), object: nil)
        // Set background color
        //CommonProcess.changeBackgroundColor(Singleton.sharedInstance.isTrainningMode, aView: self.view)
        
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

    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if hideKeyboard == true {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y - 100, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }) 
            hideKeyboard = false
        }
        return true
    }
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) 
        hideKeyboard = true
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
    func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
        })
        imgAvatar.image = image
    }
    func avatarPicker(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            print("pick avatar")
            userAvatarPicker.delegate = self
            userAvatarPicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            userAvatarPicker.allowsEditing = false
            self.present(userAvatarPicker, animated: true, completion: nil)
        }
    }
}
