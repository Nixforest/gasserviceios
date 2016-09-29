//
//  AccountViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class AccountViewController: CommonViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // MARK: Properties
    /** Menu button */
    @IBOutlet weak var menuButton: UIButton!
    /** Notification button */
    @IBOutlet weak var notificationButton: UIButton!
    /** Back button */
    @IBOutlet weak var backButton: UIButton!
    /** Save button */
    @IBOutlet weak var saveButton: UIButton!
    /** Change password button */
    @IBOutlet weak var changePasswordButton: UIButton!
    /** Logout button */
    @IBOutlet weak var logoutButton: UIButton!
    /** Avatar image */
    @IBOutlet weak var imgAvatar: UIImageView!
    /** Name image */
    @IBOutlet weak var imgName: UIImageView!
    /** Phone image */
    @IBOutlet weak var imgPhone: UIImageView!
    /** Address image */
    @IBOutlet weak var imgAddress: UIImageView!
    /** Name textbox */
    @IBOutlet weak var txtName: UITextField!
    /** Phone textbox */
    @IBOutlet weak var txtPhone: UITextField!
    /** Address textbox */
    @IBOutlet weak var txtAddress: UITextField!
    /** User avatar picker */
    var userAvatarPicker = UIImagePickerController()
    
    //MARK: Actions
    /**
     * Handle tap on Notification button
     * - parameter sender:AnyObject
     */
    @IBAction func notificationButtonTapped(_ sender: AnyObject) {
        let notificationAlert = UIAlertController(title: GlobalConst.CONTENT00162,
                                                  message: "Bạn có tin nhắn mới",
                                                  preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                         style: .cancel,
                                         handler: {(notificationAlert) -> Void in ()})
        notificationAlert.addAction(cancelAction)
        self.present(notificationAlert, animated: true, completion: nil)
    }
    
    /**
     * Handle tap on Save button
     * - parameter sender:AnyObject
     */
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        let saveAlert = UIAlertController(title: GlobalConst.CONTENT00162,
                                          message: GlobalConst.CONTENT00025,
                                          preferredStyle: .alert)
        let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                     style: .cancel,
                                     handler: {(saveAlert) -> Void in ()})
        saveAlert.addAction(okAction)
        // Check the value of text field
        if (((txtName.text?.isEmpty)! || (txtPhone.text?.isEmpty)! || (txtAddress.text?.isEmpty)!)){
            //Call alert
            self.present(saveAlert, animated: true, completion: nil)
        }else {
            print("Save successfully")
        }
    }
    
    /**
     * Handle tap on Change password button
     * - parameter sender:AnyObject
     */
    @IBAction func changePasswordTapped(_ sender: AnyObject) {
        let changePasswordVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.CHANGE_PASSWORD_VIEW_CTRL)
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    /**
     * Handle tap on Back button
     * - parameter sender:AnyObject
     */
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /**
     * Handle tap on Logout button
     * - parameter sender:AnyObject
     */
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        LoadingView.shared.showOverlay(view: self.view)
        CommonProcess.requestLogout()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Methods
    //training mode
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    /**
     * Handle when tap on Home menu item
     */
    func gasServiceButtonInAccountVCTapped(_ notification: Notification) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    /**
     * Handle when tap on Issue menu item
     */
    func issueButtonInAccountVCTapped(_ notification: Notification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
         self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    
    /**
     * Handle when tap on Config menu item
     */
    func configButtonInAccountVCTapped(_ notification: Notification) {
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.CONFIGURATION_VIEW_CTRL)
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Training mode
        asignNotifyForTrainingModeChange()
        // Menu item tap
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.gasServiceButtonInAccountVCTapped(_:)), name:NSNotification.Name(rawValue: "gasServiceButtonInAccountVCTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.issueButtonInAccountVCTapped(_:)), name:NSNotification.Name(rawValue: "issueButtonInAccountVCTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.configButtonInAccountVCTapped(_:)), name:NSNotification.Name(rawValue: "configButtonInAccountVCTapped"), object: nil)
        
        // Background
        view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        // Logo customize
        let heigh = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        imgAvatar.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.ACCOUNT_AVATAR_W) / 2,
                                 y: heigh + GlobalConst.MARGIN,
                                 width: GlobalConst.ACCOUNT_AVATAR_W,
                                 height: GlobalConst.ACCOUNT_AVATAR_H)
        imgAvatar.image = UIImage(named: GlobalConst.CONTACT_IMG_NAME)
        imgAvatar.translatesAutoresizingMaskIntoConstraints = true
        imgAvatar.isUserInteractionEnabled = true
        
        let avatarTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AccountViewController.avatarPicker))
        avatarTap.numberOfTapsRequired = 1
        imgAvatar.addGestureRecognizer(avatarTap)
        self.view.addSubview(imgAvatar)
        
        imgName.frame = CGRect(x: GlobalConst.MARGIN,
                               y: imgAvatar.frame.maxY + GlobalConst.MARGIN,
                               width: GlobalConst.ACCOUNT_ICON_SIZE,
                               height: GlobalConst.ACCOUNT_ICON_SIZE)
        imgName.image = UIImage(named: GlobalConst.CONTACT_IMG_NAME)
        imgName.translatesAutoresizingMaskIntoConstraints = true
        imgPhone.frame = CGRect(x: GlobalConst.MARGIN,
                                y: imgName.frame.maxY + GlobalConst.MARGIN,
                                width: GlobalConst.ACCOUNT_ICON_SIZE,
                                height: GlobalConst.ACCOUNT_ICON_SIZE)
        imgName.image = UIImage(named: GlobalConst.CONTACT_IMG_NAME)
        imgPhone.image = UIImage(named: GlobalConst.PHONE_IMG_NAME)
        imgPhone.translatesAutoresizingMaskIntoConstraints = true
        imgAddress.frame = CGRect(x: GlobalConst.MARGIN,
                                  y: imgPhone.frame.maxY + GlobalConst.MARGIN,
                                  width: GlobalConst.ACCOUNT_ICON_SIZE,
                                  height: GlobalConst.ACCOUNT_ICON_SIZE)
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
        navigationBar.title = GlobalConst.CONTENT00100
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
        navigationBar.setRightBarButtonItems([menuNavBar, notificationNavBar], animated: false)
    
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


        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(AccountViewController.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        
        // Notify set data
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.setData(_:)), name:NSNotification.Name(rawValue: "view.setData"), object: nil)
        
        // Set background color
        changeBackgroundColor(Singleton.sharedInstance.checkTrainningMode())
        if Singleton.sharedInstance.user_info == nil {
            CommonProcess.requestUserProfile(view: self)
        } else {
            txtName.text = Singleton.sharedInstance.user_info?.first_name
            txtPhone.text = Singleton.sharedInstance.user_info?.phone
            txtAddress.text = Singleton.sharedInstance.user_info?.address
            if let url = NSURL(string: String(Singleton.sharedInstance.getServerURL() + (Singleton.sharedInstance.user_info?.image_avatar)!)!) {
                if let data = NSData(contentsOf: url as URL) {
                    imgAvatar.image = UIImage(data: data as Data)
                }
            }
        }

    }
    override func setData(_ notification: Notification) {
        txtName.text = Singleton.sharedInstance.user_info?.first_name
        txtPhone.text = Singleton.sharedInstance.user_info?.phone
        txtAddress.text = Singleton.sharedInstance.user_info?.address
//        var url = NSURL(fileURLWithPath: String(Singleton.sharedInstance.getServerURL() + (Singleton.sharedInstance.user_info?.image_avatar)!)!)
//        var data = NSData(contentsOf: url as URL)
//        imgAvatar.image = UIImage(data: data! as Data)
        if let url = NSURL(string: String(Singleton.sharedInstance.getServerURL() + (Singleton.sharedInstance.user_info?.image_avatar)!)!) {
            if let data = NSData(contentsOf: url as URL) {
                imgAvatar.image = UIImage(data: data as Data)
            }        
        }
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
