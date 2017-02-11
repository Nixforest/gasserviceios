//
//  RegisterViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00RegisterVC: BaseViewController, UITextFieldDelegate {
    // MARK: Properties
    /** Logo image */
    @IBOutlet weak var imgCenter: UIImageView!
    /** Name edit text */
    @IBOutlet weak var txtName: UITextField!
    /** Phone edit text */
    @IBOutlet weak var txtPhone: UITextField!
    /** Register button */
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: Actions
    /**
     * Handle tap on register button
     * - parameter sender:AnyObject
     */
    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        // Check the value of text field
        if (((txtName.text?.isEmpty)! || (txtPhone.text?.isEmpty)!)){
            // Call alert
            showAlert(message: DomainConst.CONTENT00025)
        } else {
            RequestAPI.requestRegister(name: txtName.text!, phone: txtPhone.text!, view: self)
        }
    }
    
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(super.configItemTap(_:)),
                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_COFIG_ITEM_REGISTERVIEW),
                                               object: nil)
    }
    
    override func viewDidLoad() {
        setBackground(bkg: DomainConst.TYPE_1_BKG_IMG_NAME)
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        imgCenter.image = ImageManager.getImage(named: DomainConst.LOGO_IMG_NAME)
        imgCenter.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W) / 2,
                               y: heigh + GlobalConst.MARGIN,
                               width: GlobalConst.LOGIN_LOGO_W,
                               height: GlobalConst.LOGIN_LOGO_H)
        imgCenter.translatesAutoresizingMaskIntoConstraints = true
        imgCenter.isUserInteractionEnabled = true
        
        // Name text field
        txtName.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                  y: imgCenter.frame.maxY + GlobalConst.MARGIN,
                                  width: GlobalConst.EDITTEXT_W,
                                  height: GlobalConst.EDITTEXT_H)
        txtName.placeholder = DomainConst.CONTENT00055
        txtName.autocapitalizationType = .words
        txtName.translatesAutoresizingMaskIntoConstraints = true
        // Set icon
        setLeftViewForTextField(textField: txtName, named: DomainConst.USERNAME_IMG_NAME)
        txtName.delegate = self
        
        // Phone text field
        txtPhone.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                               y: txtName.frame.maxY + GlobalConst.MARGIN,
                               width: GlobalConst.EDITTEXT_W,
                               height: GlobalConst.EDITTEXT_H)
        txtPhone.placeholder = DomainConst.CONTENT00054
        txtPhone.translatesAutoresizingMaskIntoConstraints = true
        // Set icon
        setLeftViewForTextField(textField: txtPhone, named: DomainConst.PHONE_IMG_NAME)
        txtPhone.delegate = self
        
        // Register button
        registerButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                y: txtPhone.frame.maxY + GlobalConst.MARGIN * 2 + GlobalConst.CHECKBOX_H,
                                width: GlobalConst.BUTTON_W,
                                height: GlobalConst.BUTTON_H)
        registerButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        registerButton.setTitle(DomainConst.CONTENT00052.uppercased(), for: UIControlState())
        registerButton.setTitleColor(UIColor.white, for: UIControlState())
        registerButton.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        //self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = true
        registerButton.setImage(ImageManager.getImage(named: DomainConst.SAVE_INFO_IMG_NAME), for: UIControlState())
        registerButton.imageView?.contentMode = .scaleAspectFit
                
        //Navigation Bar customize
        setupNavigationBar(title: DomainConst.CONTENT00052, isNotifyEnable: false)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(G00RegisterVC.hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        
        
    }
    
    /**
     * Set left image for text field
     * - parameter textField:   Text field object
     * - parameter named:       Image name
     */
    func setLeftViewForTextField(textField: UITextField, named: String) {
        textField.leftViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                width: GlobalConst.EDITTEXT_H - GlobalConst.MARGIN_CELL_X,
                                                height: GlobalConst.EDITTEXT_H - GlobalConst.MARGIN_CELL_X))
        let img = ImageManager.getImage(named: named)
        imgView.image = img
        textField.leftView = imgView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if isKeyboardShow == false {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y - self.keyboardTopY, width: self.view.frame.size.width, height: self.view.frame.size.height)
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
