//
//  AccountViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00AccountVC: BaseViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // MARK: Properties
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
    
    // MARK: Actions
    /**
     * Handle when tap on image to select from library
     * - parameter sender: Tap gesture
     */
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        let imgPickerController         = UIImagePickerController()
        imgPickerController.sourceType  = .photoLibrary
        imgPickerController.delegate    = self
        present(imgPickerController, animated: true, completion: nil)
    }
    
    /**
     * Handle cancel select image
     * - parameter picker: ImagePickerController
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Handle select image from library
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImgAvatar = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgAvatar.image = selectedImgAvatar
        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Handle tap on Save button
     * - parameter sender:AnyObject
     */
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        // Check the value of text field
        if (((txtName.text?.isEmpty)! || (txtPhone.text?.isEmpty)!
            || (txtAddress.text?.isEmpty)!)) {
            // Call alert
            showAlert(message: GlobalConst.CONTENT00025)
        } else {
            print("Save successfully")
        }
    }
    
    /**
     * Handle tap on Change password button
     * - parameter sender:AnyObject
     */
    @IBAction func changePasswordTapped(_ sender: AnyObject) {
        let changePasswordVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G00_CHANGE_PASS_VIEW_CTRL)
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    /**
     * Handle tap on Logout button
     * - parameter sender:AnyObject
     */
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        RequestAPI.requestLogout(view: self.view)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /**
     * View did appear
     */
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(super.gasServiceItemTapped(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(super.issueItemTapped(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(super.configItemTap(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_ACCOUNTVIEW),
                                               object: nil)
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Background
        self.view.backgroundColor   = GlobalConst.BACKGROUND_COLOR_GRAY
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        imgAvatar.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.ACCOUNT_AVATAR_W) / 2,
                                 y: heigh + GlobalConst.MARGIN,
                                 width: GlobalConst.ACCOUNT_AVATAR_W,
                                 height: GlobalConst.ACCOUNT_AVATAR_H)
        imgAvatar.image = UIImage(named: GlobalConst.CONTACT_IMG_NAME)
        imgAvatar.translatesAutoresizingMaskIntoConstraints = true
        imgAvatar.isUserInteractionEnabled = true
        
        // Image name
        imgName.frame = CGRect(x: GlobalConst.MARGIN,
                               y: imgAvatar.frame.maxY + GlobalConst.MARGIN,
                               width: GlobalConst.ACCOUNT_ICON_SIZE,
                               height: GlobalConst.ACCOUNT_ICON_SIZE)
        imgName.image = UIImage(named: GlobalConst.CONTACT_IMG_NAME)
        imgName.translatesAutoresizingMaskIntoConstraints = true
        
        // Image phone
        imgPhone.frame = CGRect(x: GlobalConst.MARGIN,
                                y: imgName.frame.maxY + GlobalConst.MARGIN,
                                width: GlobalConst.ACCOUNT_ICON_SIZE,
                                height: GlobalConst.ACCOUNT_ICON_SIZE)
        imgName.image = UIImage(named: GlobalConst.CONTACT_IMG_NAME)
        imgPhone.image = UIImage(named: GlobalConst.PHONE_IMG_NAME)
        imgPhone.translatesAutoresizingMaskIntoConstraints = true
        
        // Image address
        imgAddress.frame = CGRect(x: GlobalConst.MARGIN,
                                  y: imgPhone.frame.maxY + GlobalConst.MARGIN,
                                  width: GlobalConst.ACCOUNT_ICON_SIZE,
                                  height: GlobalConst.ACCOUNT_ICON_SIZE)
        imgAddress.image = UIImage(named: GlobalConst.ADDRESS_IMG_NAME)
        imgAddress.translatesAutoresizingMaskIntoConstraints = true
        
        // Name Textfield customize
        txtName.frame = CGRect(x: imgName.frame.maxX + GlobalConst.MARGIN,
                               y: imgAvatar.frame.maxY + GlobalConst.MARGIN,
                               width: GlobalConst.SCREEN_WIDTH - (GlobalConst.MARGIN * 3 + GlobalConst.ACCOUNT_ICON_SIZE),
                               height: GlobalConst.ACCOUNT_ICON_SIZE)
        txtName.placeholder = GlobalConst.CONTENT00055
        txtName.translatesAutoresizingMaskIntoConstraints = true
        txtName.delegate = self
        
        // Phone textfield
        txtPhone.frame = CGRect(x: txtName.frame.minX,
                                y: txtName.frame.maxY + GlobalConst.MARGIN,
                                width: GlobalConst.SCREEN_WIDTH - (GlobalConst.MARGIN * 3 + GlobalConst.ACCOUNT_ICON_SIZE),
                                height: GlobalConst.ACCOUNT_ICON_SIZE)
        txtPhone.placeholder = GlobalConst.CONTENT00054
        txtPhone.translatesAutoresizingMaskIntoConstraints = true
        txtPhone.delegate = self
        
        // Address textfield
        txtAddress.frame = CGRect(x: txtName.frame.minX,
                                  y: txtPhone.frame.maxY + GlobalConst.MARGIN,
                                  width: GlobalConst.SCREEN_WIDTH - (GlobalConst.MARGIN * 3 + GlobalConst.ACCOUNT_ICON_SIZE),
                                  height: GlobalConst.ACCOUNT_ICON_SIZE)
        txtAddress.placeholder = GlobalConst.CONTENT00088
        txtAddress.translatesAutoresizingMaskIntoConstraints = true
        txtAddress.delegate = self
        
        // Save Button customize
        saveButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                  y: txtAddress.frame.maxY + GlobalConst.MARGIN,
                                  width: GlobalConst.BUTTON_W,
                                  height: GlobalConst.BUTTON_H)
        saveButton.setTitle(GlobalConst.CONTENT00086, for: UIControlState())
        saveButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        saveButton.setTitleColor(UIColor.white, for: UIControlState())
        saveButton.translatesAutoresizingMaskIntoConstraints = true
        saveButton.layer.cornerRadius = 6
        
        // Change password button
        changePasswordButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                            y: saveButton.frame.maxY + GlobalConst.MARGIN,
                                            width: GlobalConst.BUTTON_W,
                                            height: GlobalConst.BUTTON_H)
        changePasswordButton.setTitle(GlobalConst.CONTENT00089, for: UIControlState())
        changePasswordButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        changePasswordButton.setTitleColor(UIColor.white, for: UIControlState())
        changePasswordButton.layer.cornerRadius = 6
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = true
        
        // Logout button
        logoutButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                    y: changePasswordButton.frame.maxY + GlobalConst.MARGIN,
                                    width: GlobalConst.BUTTON_W,
                                    height: GlobalConst.BUTTON_H)
        logoutButton.setTitle(GlobalConst.CONTENT00090, for: UIControlState())
        logoutButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        logoutButton.setTitleColor(UIColor.white, for: UIControlState())
        logoutButton.layer.cornerRadius = 6
        logoutButton.translatesAutoresizingMaskIntoConstraints = true
        
        // Navigation Bar customize
        setupNavigationBar(title: GlobalConst.CONTENT00100, isNotifyEnable: true)

        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(G00AccountVC.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        
        // Notify set data
        NotificationCenter.default.addObserver(self, selector: #selector(G00AccountVC.setData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_ACCOUNTVIEW), object: nil)
        
        // Load data from server?
        if BaseModel.shared.user_info == nil {
            // User information does not exist
            RequestAPI.requestUserProfile(view: self)
        } else {
            txtName.text    = BaseModel.shared.user_info?.getName()
            txtPhone.text   = BaseModel.shared.user_info?.getPhone()
            txtAddress.text = BaseModel.shared.user_info?.getAddress()
            if let url      = NSURL(string: String(BaseModel.shared.getServerURL() + (BaseModel.shared.user_info?.getAvatarImage())!)!) {
                if let data = NSData(contentsOf: url as URL) {
                    imgAvatar.image = UIImage(data: data as Data)
                }
            }
        }

    }
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        txtName.text    = BaseModel.shared.user_info?.getName()
        txtPhone.text   = BaseModel.shared.user_info?.getPhone()
        txtAddress.text = BaseModel.shared.user_info?.getAddress()
        // Load image
        if let url = NSURL(string: String(BaseModel.shared.getServerURL() + (BaseModel.shared.user_info?.getAvatarImage())!)!) {
            if let data = NSData(contentsOf: url as URL) {
                imgAvatar.image = UIImage(data: data as Data)
            }        
        }
    }

    /**
     * Memory warning handler
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GlobalConst.POPOVER_MENU_IDENTIFIER {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    /**
     * ...
     */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if isKeyboardShow == false {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y - 100, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }) 
            isKeyboardShow = true
        }
        return true
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) 
        isKeyboardShow = false
    }
    
    /**
     * Handle when leave focus edittext
     * - parameter textField: Textfield is focusing
     */
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
