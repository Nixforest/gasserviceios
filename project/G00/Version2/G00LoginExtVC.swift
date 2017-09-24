//
//  G00LoginExtVC.swift
//  project
//
//  Created by SPJ on 9/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00LoginExtVC: ChildExtViewController {
    // MARK: Properties
    /** Logo */
    var imgLogo:        UIImageView = UIImageView()
    /** Login label */
    var lblLogin:       UILabel     = UILabel()
    /** Phone textfield */
    var txtPhone:       UITextField = UITextField()
    /** Button next */
    var btnNext:        UIButton    = UIButton(type: .custom)
    /** Label OR */
    var lblOr:          UILabel     = UILabel()
    /** Button facebook */
    var btnFacebook:    CustomButton    = CustomButton(type: UIButtonType.custom)
    /** Button Zalo */
    var btnZalo:        CustomButton    = CustomButton(type: .custom)
    
    // MARK: Constant
    // Logo
    var LOGIN_LOGO_REAL_WIDTH_HD        = GlobalConst.LOGIN_LOGO_WIDTH * G00LoginExtVC.W_RATE_HD
    var LOGIN_LOGO_REAL_HEIGHT_HD       = GlobalConst.LOGIN_LOGO_HEIGHT * G00LoginExtVC.H_RATE_HD
    var LOGIN_LOGO_REAL_Y_POS_HD        = GlobalConst.LOGIN_LOGO_Y_POS * G00LoginExtVC.H_RATE_HD
    
    var LOGIN_LOGO_REAL_WIDTH_FHD       = GlobalConst.LOGIN_LOGO_WIDTH * G00LoginExtVC.W_RATE_FHD
    var LOGIN_LOGO_REAL_HEIGHT_FHD      = GlobalConst.LOGIN_LOGO_HEIGHT * G00LoginExtVC.H_RATE_FHD
    var LOGIN_LOGO_REAL_Y_POS_FHD       = GlobalConst.LOGIN_LOGO_Y_POS_FHD * G00LoginExtVC.H_RATE_FHD
    
    var LOGIN_LOGO_REAL_WIDTH_FHD_L     = GlobalConst.LOGIN_LOGO_WIDTH * G00LoginExtVC.W_RATE_FHD_L
    var LOGIN_LOGO_REAL_HEIGHT_FHD_L    = GlobalConst.LOGIN_LOGO_HEIGHT * G00LoginExtVC.H_RATE_FHD_L
    var LOGIN_LOGO_REAL_Y_POS_FHD_L     = GlobalConst.LOGIN_LOGO_Y_POS_FHD_LAND * G00LoginExtVC.H_RATE_FHD_L
    
    // Phone
    var LOGIN_PHONE_REAL_WIDTH_HD       = GlobalConst.LOGIN_TEXTFIELD_WIDTH * G00LoginExtVC.W_RATE_HD
    var LOGIN_PHONE_REAL_HEIGHT_HD      = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * G00LoginExtVC.H_RATE_HD
    var LOGIN_PHONE_REAL_WIDTH_FHD      = GlobalConst.LOGIN_TEXTFIELD_WIDTH * G00LoginExtVC.W_RATE_FHD
    var LOGIN_PHONE_REAL_HEIGHT_FHD     = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * G00LoginExtVC.H_RATE_FHD
    var LOGIN_PHONE_REAL_WIDTH_FHD_L    = GlobalConst.LOGIN_TEXTFIELD_WIDTH * G00LoginExtVC.W_RATE_FHD_L
    var LOGIN_PHONE_REAL_HEIGHT_FHD_L   = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * G00LoginExtVC.H_RATE_FHD_L
    // Next button
    var LOGIN_NEXT_BUTTON_REAL_SIZE_HD      = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * G00LoginExtVC.H_RATE_HD
    var LOGIN_NEXT_BUTTON_REAL_SIZE_FHD     = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * G00LoginExtVC.H_RATE_FHD
    var LOGIN_NEXT_BUTTON_REAL_SIZE_FHD_L   = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * G00LoginExtVC.H_RATE_FHD_L
    
    

    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.makeComponentsColor()
    }
    
    /**
     * Handle update constants
     */
    override func updateConst() {
        G00LoginExtVC.W_RATE_HD    = UIScreen.main.bounds.width / GlobalConst.HD_SCREEN_BOUND.w
        G00LoginExtVC.H_RATE_HD    = UIScreen.main.bounds.height / GlobalConst.HD_SCREEN_BOUND.h
        G00LoginExtVC.W_RATE_FHD   = UIScreen.main.bounds.width / GlobalConst.FULL_HD_SCREEN_BOUND.w
        G00LoginExtVC.H_RATE_FHD   = UIScreen.main.bounds.height / GlobalConst.FULL_HD_SCREEN_BOUND.h
        G00LoginExtVC.W_RATE_FHD_L = UIScreen.main.bounds.width / GlobalConst.FULL_HD_SCREEN_BOUND.h
        G00LoginExtVC.H_RATE_FHD_L = UIScreen.main.bounds.height / GlobalConst.FULL_HD_SCREEN_BOUND.w
        
        // Login
        LOGIN_LOGO_REAL_WIDTH_HD        = GlobalConst.LOGIN_LOGO_WIDTH * G00LoginExtVC.W_RATE_HD
        LOGIN_LOGO_REAL_HEIGHT_HD       = GlobalConst.LOGIN_LOGO_HEIGHT * G00LoginExtVC.H_RATE_HD
        LOGIN_LOGO_REAL_Y_POS_HD        = GlobalConst.LOGIN_LOGO_Y_POS * G00LoginExtVC.H_RATE_HD
        
        LOGIN_LOGO_REAL_WIDTH_FHD       = GlobalConst.LOGIN_LOGO_WIDTH * G00LoginExtVC.W_RATE_FHD
        LOGIN_LOGO_REAL_HEIGHT_FHD      = GlobalConst.LOGIN_LOGO_HEIGHT * G00LoginExtVC.H_RATE_FHD
        LOGIN_LOGO_REAL_Y_POS_FHD       = GlobalConst.LOGIN_LOGO_Y_POS_FHD * G00LoginExtVC.H_RATE_FHD
        
        LOGIN_LOGO_REAL_WIDTH_FHD_L     = GlobalConst.LOGIN_LOGO_WIDTH * G00LoginExtVC.W_RATE_FHD_L
        LOGIN_LOGO_REAL_HEIGHT_FHD_L    = GlobalConst.LOGIN_LOGO_HEIGHT * G00LoginExtVC.H_RATE_FHD_L
        LOGIN_LOGO_REAL_Y_POS_FHD_L     = GlobalConst.LOGIN_LOGO_Y_POS_FHD_LAND * G00LoginExtVC.H_RATE_FHD_L
        
        // Phone
        LOGIN_PHONE_REAL_WIDTH_HD       = GlobalConst.LOGIN_TEXTFIELD_WIDTH * G00LoginExtVC.W_RATE_HD
        LOGIN_PHONE_REAL_HEIGHT_HD      = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * G00LoginExtVC.H_RATE_HD
        
        LOGIN_PHONE_REAL_WIDTH_FHD      = GlobalConst.LOGIN_TEXTFIELD_WIDTH * G00LoginExtVC.W_RATE_FHD
        LOGIN_PHONE_REAL_HEIGHT_FHD     = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * G00LoginExtVC.H_RATE_FHD
        
        LOGIN_PHONE_REAL_WIDTH_FHD_L    = GlobalConst.LOGIN_TEXTFIELD_WIDTH * G00LoginExtVC.W_RATE_FHD
        LOGIN_PHONE_REAL_HEIGHT_FHD_L   = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * G00LoginExtVC.H_RATE_FHD
        
        // Next button
        LOGIN_NEXT_BUTTON_REAL_SIZE_HD      = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * G00LoginExtVC.H_RATE_HD
        LOGIN_NEXT_BUTTON_REAL_SIZE_FHD     = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * G00LoginExtVC.H_RATE_FHD
        LOGIN_NEXT_BUTTON_REAL_SIZE_FHD_L   = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * G00LoginExtVC.H_RATE_FHD_L
    }
    
    /**
     * Handle set background image
     */
    override func setBackgroundImage() {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPHONE_IMG_NAME)
            break
        case .pad:
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
            case .landscapeLeft, .landscapeRight:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_LANDSCAPE_IMG_NAME)
            default:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
            }
            break
        default:
            self.setBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
        }
    }
    
    /**
     * Create children views
     */
    override func createChildrenViews() {
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            self.createLogoImg()
            self.createLoginLabel()
            self.createPhoneTextFieldHD()
            self.createNextBtnHD()
            self.createORLabel()
            self.createFBBtnHD()
            self.createZLBtnHD()
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                self.createLogoImgFHD()
                self.createLoginLabel()
                self.createPhoneTextFieldFHD()
                self.createNextBtnFHD()
                self.createORLabel()
                self.createFBBtnFHD()
                self.createZLBtnFHD()
            case .landscapeLeft, .landscapeRight:       // Landscape
                self.createLogoImgFHD_L()
                self.createLoginLabel()
                self.createPhoneTextFieldFHD_L()
                self.createNextBtnFHD_L()
                self.createORLabel()
                self.createFBBtnFHD_L()
                self.createZLBtnFHD_L()
            default:
                break
            }
            
            break
        default:
            break
        }
        
        imgLogo.image = ImageManager.getImage(named: DomainConst.LOGO_LOGIN_ICON_IMG_NAME)
        
        createNextBtn()
        
        self.view.addSubview(imgLogo)
        self.view.addSubview(lblLogin)
        self.view.addSubview(txtPhone)
        self.view.addSubview(lblOr)
        self.view.addSubview(btnFacebook)
        self.view.addSubview(btnZalo)
    }
    
    /**
     * Update children views
     */
    override func updateChildrenViews() {
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            self.createLogoImg()
            self.updateLoginLabel()
            self.updatePhoneTextFieldHD()
            self.updateORLabel()
            self.updateFBBtnHD()
            self.updateZLBtnHD()
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                self.createLogoImgFHD()
                self.updateLoginLabel()
                self.updatePhoneTextFieldFHD()
                self.updateORLabel()
                self.updateFBBtnFHD()
                self.updateZLBtnFHD()
            case .landscapeLeft, .landscapeRight:       // Landscape
                self.createLogoImgFHD_L()
                self.updateLoginLabel()
                self.updatePhoneTextFieldFHD_L()
                self.updateORLabel()
                self.updateFBBtnFHD_L()
                self.updateZLBtnFHD_L()
            default:
                break
            }
            
            break
        default:
            break
        }
    }
    
    // MARK: Event handler
    /**
     * Handle when tap on next button
     */
    func btnNextTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: finishDismissLogin)
    }
    
    internal func finishOpenConfirm() -> Void {
        print("finishOpenConfirm")
    }
    
    internal func finishDismissLogin() -> Void {
        print("finishDismissLogin")
        let confirmCode = G00ConfirmCodeVC(nibName: G00ConfirmCodeVC.theClassName, bundle: nil)
        if let controller = BaseViewController.getCurrentViewController() {
            controller.present(confirmCode, animated: true, completion: finishOpenConfirm)
        }
    }
    
    /**
     * Handle when tap on facebook button
     */
    func btnFacebookTapped(_ sender: AnyObject) {
        showAlert(message: "btnFacebookTapped")
    }
    
    /**
     * Handle when tap on zalo button
     */
    func btnZaloTapped(_ sender: AnyObject) {
        showAlert(message: "btnZaloTapped")
    }
    
    // MARK: Utilities
    /**
     * Update view position
     * - parameter view: View need to update
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func updateViewPos(view: UIView, x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        view.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    /**
     * Create logo image (in HD mode)
     */
    private func createLogoImg() {
        updateViewPos(view: imgLogo,
                      x: (UIScreen.main.bounds.width - LOGIN_LOGO_REAL_WIDTH_HD) / 2,
                      y: LOGIN_LOGO_REAL_Y_POS_HD,
                      w: LOGIN_LOGO_REAL_WIDTH_HD,
                      h: LOGIN_LOGO_REAL_HEIGHT_HD)
    }
    
    /**
     * Create logo image (in Full HD mode)
     */
    private func createLogoImgFHD() {
        updateViewPos(view: imgLogo,
                      x: (UIScreen.main.bounds.width - LOGIN_LOGO_REAL_WIDTH_FHD) / 2,
                      y: LOGIN_LOGO_REAL_Y_POS_FHD,
                      w: LOGIN_LOGO_REAL_WIDTH_FHD,
                      h: LOGIN_LOGO_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create logo image (in Full HD Landscape mode)
     */
    private func createLogoImgFHD_L() {
        updateViewPos(view: imgLogo,
                      x: (UIScreen.main.bounds.width  - LOGIN_LOGO_REAL_WIDTH_FHD_L) / 2,
                      y: LOGIN_LOGO_REAL_Y_POS_FHD_L,
                      w: LOGIN_LOGO_REAL_WIDTH_FHD_L,
                      h: LOGIN_LOGO_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Create login label
     */
    private func createLoginLabel() {
        lblLogin.frame = CGRect(x: 0,
                                y: imgLogo.frame.maxY + GlobalConst.MARGIN,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H)
        lblLogin.text           = DomainConst.CONTENT00051.uppercased()
        lblLogin.textColor      = UIColor.black
        lblLogin.font           = GlobalConst.BASE_FONT
        lblLogin.textAlignment  = .center
    }
    
    /**
     * Update login label
     */
    private func updateLoginLabel() {
        updateViewPos(view: lblLogin,
                      x: 0,
                      y: imgLogo.frame.maxY + GlobalConst.MARGIN,
                      w: UIScreen.main.bounds.width,
                      h: GlobalConst.LABEL_H)
    }
    
    /**
     * Create phone text field (in HD mode)
     */
    private func createPhoneTextFieldHD() {
        self.createPhoneTextField(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_HD) / 2,
            y: lblLogin.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_HD,
            h: LOGIN_PHONE_REAL_HEIGHT_HD)
    }
    
    /**
     * Create phone text field (in Full HD mode)
     */
    private func createPhoneTextFieldFHD() {
        self.createPhoneTextField(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD) / 2,
            y: lblLogin.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_FHD,
            h: LOGIN_PHONE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create phone text field (in Full HD Landscape mode)
     */
    private func createPhoneTextFieldFHD_L() {
        self.createPhoneTextField(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD_L) / 2,
            y: lblLogin.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_FHD_L,
            h: LOGIN_PHONE_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Create phone text field
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createPhoneTextField(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        txtPhone.frame              = CGRect(x: x, y: y, width: w, height: h)
        txtPhone.placeholder        = DomainConst.CONTENT00054
        txtPhone.backgroundColor    = UIColor.white
        txtPhone.textAlignment      = .center
        txtPhone.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS_NEW
        txtPhone.keyboardType       = .numberPad
        txtPhone.returnKeyType      = .done
    }
    
    /**
     * Update phone text field (in HD mode)
     */
    private func updatePhoneTextFieldHD() {
        updateViewPos(view: txtPhone,
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_HD) / 2,
            y: lblLogin.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_HD,
            h: LOGIN_PHONE_REAL_HEIGHT_HD)
    }
    
    /**
     * Update phone text field (in Full HD mode)
     */
    private func updatePhoneTextFieldFHD() {
        updateViewPos(view: txtPhone,
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD) / 2,
            y: lblLogin.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_FHD,
            h: LOGIN_PHONE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Update phone text field (in Full HD Landscape mode)
     */
    private func updatePhoneTextFieldFHD_L() {
        updateViewPos(view: txtPhone,
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD_L) / 2,
            y: lblLogin.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_FHD_L,
            h: LOGIN_PHONE_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Create next button
     */
    private func createNextBtn() {
        btnNext.setImage(ImageManager.getImage(named: DomainConst.NEXT_BUTTON_ICON_IMG_NAME),
                         for: .normal)
        btnNext.addTarget(self, action: #selector(btnNextTapped(_:)), for: .touchUpInside)
        txtPhone.rightView = btnNext
        txtPhone.rightViewMode = .always
    }
    
    /**
     * Create next button (in HD mode)
     */
    private func createNextBtnHD() {
        createNextBtn()
        updateViewPos(view: btnNext,
                      x: CGFloat(txtPhone.frame.width - LOGIN_NEXT_BUTTON_REAL_SIZE_HD * 2),
                      y: (txtPhone.frame.height - LOGIN_NEXT_BUTTON_REAL_SIZE_HD ) / 2,
                      w: LOGIN_NEXT_BUTTON_REAL_SIZE_HD,
                      h: LOGIN_NEXT_BUTTON_REAL_SIZE_HD)
    }
    
    /**
     * Create next button (in Full HD mode)
     */
    private func createNextBtnFHD() {
        createNextBtn()
        updateViewPos(view: btnNext,
                      x: CGFloat(txtPhone.frame.width - LOGIN_NEXT_BUTTON_REAL_SIZE_FHD * 2),
                      y: (txtPhone.frame.height - LOGIN_NEXT_BUTTON_REAL_SIZE_FHD ) / 2,
                      w: LOGIN_NEXT_BUTTON_REAL_SIZE_FHD,
                      h: LOGIN_NEXT_BUTTON_REAL_SIZE_FHD)
    }
    
    /**
     * Create next button (in Full HD Landscape mode)
     */
    private func createNextBtnFHD_L() {
        createNextBtn()
        updateViewPos(view: btnNext,
                      x: CGFloat(txtPhone.frame.width - LOGIN_NEXT_BUTTON_REAL_SIZE_FHD_L * 2),
                      y: (txtPhone.frame.height - LOGIN_NEXT_BUTTON_REAL_SIZE_FHD_L ) / 2,
                      w: LOGIN_NEXT_BUTTON_REAL_SIZE_FHD_L,
                      h: LOGIN_NEXT_BUTTON_REAL_SIZE_FHD_L)
    }
    
    /**
     * Create login label
     */
    private func createORLabel() {
        lblOr.frame = CGRect(x: 0,
                                y: txtPhone.frame.maxY + GlobalConst.MARGIN,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H)
        lblOr.text              = DomainConst.CONTENT00472
        lblOr.textColor      = UIColor.black
        lblOr.font           = GlobalConst.BASE_FONT
        lblOr.textAlignment  = .center
    }
    
    /**
     * Update login label
     */
    private func updateORLabel() {
        updateViewPos(view: lblOr,
                      x: 0,
                      y: txtPhone.frame.maxY + GlobalConst.MARGIN,
                      w: UIScreen.main.bounds.width,
                      h: GlobalConst.LABEL_H)
    }
    
    /**
     * Create facebook button
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createFBBtn(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        btnFacebook.frame = CGRect(x: x, y: y, width: w, height: h)
        btnFacebook.setTitle(DomainConst.CONTENT00473, for: UIControlState())
        btnFacebook.setTitleColor(UIColor.white, for: UIControlState())
        btnFacebook.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
        btnFacebook.backgroundColor = GlobalConst.FACEBOOK_BKG_COLOR
        btnFacebook.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS_NEW
        btnFacebook.addTarget(self, action: #selector(btnFacebookTapped(_:)), for: .touchUpInside)
        btnFacebook.leftImage(image: ImageManager.getImage(named: DomainConst.LOGO_FACEBOOK_ICON_IMG_NAME)!)
        btnFacebook.imageView?.contentMode = .scaleAspectFit
        btnFacebook.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    /**
     * Create facebook button (in HD mode)
     */
    private func createFBBtnHD() {
        self.createFBBtn(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_HD) / 2,
            y: lblOr.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_HD,
            h: LOGIN_PHONE_REAL_HEIGHT_HD)
    }
    
    /**
     * Create facebook button (in Full HD mode)
     */
    private func createFBBtnFHD() {
        self.createFBBtn(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD) / 2,
            y: lblOr.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_FHD,
            h: LOGIN_PHONE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create facebook button (in Full HD Landscape mode)
     */
    private func createFBBtnFHD_L() {
        self.createFBBtn(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD_L) / 2,
            y: lblOr.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_FHD_L,
            h: LOGIN_PHONE_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Update facebook button (in HD mode)
     */
    private func updateFBBtnHD() {
        updateViewPos(view: btnFacebook,
                      x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_HD) / 2,
                      y: lblOr.frame.maxY + GlobalConst.MARGIN,
                      w: LOGIN_PHONE_REAL_WIDTH_HD,
                      h: LOGIN_PHONE_REAL_HEIGHT_HD)
    }
    
    /**
     * Update facebook button (in Full HD mode)
     */
    private func updateFBBtnFHD() {
        updateViewPos(view: btnFacebook,
                      x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD) / 2,
                      y: lblOr.frame.maxY + GlobalConst.MARGIN,
                      w: LOGIN_PHONE_REAL_WIDTH_FHD,
                      h: LOGIN_PHONE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Update facebook button (in Full HD Landscape mode)
     */
    private func updateFBBtnFHD_L() {
        updateViewPos(view: btnFacebook,
                      x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD_L) / 2,
                      y: lblOr.frame.maxY + GlobalConst.MARGIN,
                      w: LOGIN_PHONE_REAL_WIDTH_FHD_L,
                      h: LOGIN_PHONE_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Create zalo button
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createZLBtn(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        btnZalo.frame = CGRect(x: x, y: y, width: w, height: h)
        btnZalo.setTitle(DomainConst.CONTENT00474, for: UIControlState())
        btnZalo.setTitleColor(UIColor.white, for: UIControlState())
        btnZalo.titleLabel?.font = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
        btnZalo.backgroundColor = GlobalConst.ZALO_BKG_COLOR
        btnZalo.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS_NEW
        btnZalo.addTarget(self, action: #selector(btnZaloTapped(_:)), for: .touchUpInside)
        btnZalo.leftImage(image: ImageManager.getImage(named: DomainConst.LOGO_ZALO_ICON_IMG_NAME)!)
        btnZalo.imageView?.contentMode = .scaleAspectFit
        btnZalo.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    /**
     * Create zalo button (in HD mode)
     */
    private func createZLBtnHD() {
        self.createZLBtn(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_HD) / 2,
            y: btnFacebook.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_HD,
            h: LOGIN_PHONE_REAL_HEIGHT_HD)
    }
    
    /**
     * Create zalo button (in Full HD mode)
     */
    private func createZLBtnFHD() {
        self.createZLBtn(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD) / 2,
            y: btnFacebook.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_FHD,
            h: LOGIN_PHONE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create zalo button (in Full HD Landscape mode)
     */
    private func createZLBtnFHD_L() {
        self.createZLBtn(
            x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD_L) / 2,
            y: btnFacebook.frame.maxY + GlobalConst.MARGIN,
            w: LOGIN_PHONE_REAL_WIDTH_FHD_L,
            h: LOGIN_PHONE_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Update zalo button (in HD mode)
     */
    private func updateZLBtnHD() {
        updateViewPos(view: btnZalo,
                      x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_HD) / 2,
                      y: btnFacebook.frame.maxY + GlobalConst.MARGIN,
                      w: LOGIN_PHONE_REAL_WIDTH_HD,
                      h: LOGIN_PHONE_REAL_HEIGHT_HD)
    }
    
    /**
     * Update zalo button (in Full HD mode)
     */
    private func updateZLBtnFHD() {
        updateViewPos(view: btnZalo,
                      x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD) / 2,
                      y: btnFacebook.frame.maxY + GlobalConst.MARGIN,
                      w: LOGIN_PHONE_REAL_WIDTH_FHD,
                      h: LOGIN_PHONE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Update zalo button (in Full HD Landscape mode)
     */
    private func updateZLBtnFHD_L() {
        updateViewPos(view: btnZalo,
                      x: (UIScreen.main.bounds.width - LOGIN_PHONE_REAL_WIDTH_FHD_L) / 2,
                      y: btnFacebook.frame.maxY + GlobalConst.MARGIN,
                      w: LOGIN_PHONE_REAL_WIDTH_FHD_L,
                      h: LOGIN_PHONE_REAL_HEIGHT_FHD_L)
    }
    
    private func gotoNextStep() {
        let g12F01S01 = G12F01S01VC(nibName: G12F01S01VC.theClassName, bundle: nil)
        let rootNav: UINavigationController = UINavigationController(rootViewController: g12F01S01)
        rootNav.isNavigationBarHidden = false
        let slide = BaseSlideMenuViewController(mainViewController: rootNav,
                                                leftMenuViewController: mainStoryboard.instantiateViewController(withIdentifier: "BaseMenuViewController"))
        slide.delegate = g12F01S01
        self.present(g12F01S01, animated: true, completion: nil)
    }
}