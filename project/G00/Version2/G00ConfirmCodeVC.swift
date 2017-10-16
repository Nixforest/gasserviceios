//
//  G00ConfirmCodeVC.swift
//  project
//
//  Created by SPJ on 9/19/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00ConfirmCodeVC: ChildExtViewController {
    // MARK: Properties
    /** Logo */
    var imgLogo:        UIImageView = UIImageView()
    /** Input code label */
    var lblInput:       UILabel     = UILabel()
    /** Code textfield */
    var txtCode:        UITextField = UITextField()
    /** Button next */
    var btnNext:        UIButton    = UIButton(type: .custom)
    /** Input code label */
    var lbl1:           UILabel     = UILabel()
    /** Input code label */
    var lbl2:           UILabel     = UILabel()
    /** Input code label */
    var lbl3:           UILabel     = UILabel()
    /** Input code label */
    var lbl4:           UILabel     = UILabel()
    /** Input code label */
    var lbl5:           UILabel     = UILabel()
    /** Input code label */
    var lbl6:           UILabel     = UILabel()
    /** Button resend */
    var btnResend:      UIButton    = UIButton()
    /** Wrong phone label */
    var lblWrongPhone:  UILabel     = UILabel()
    /** Button back */
    var btnBack:        UIButton    = UIButton()
    // MARK: Data
    /** Phone number */
    private var _phone: String      = DomainConst.BLANK
    /** Token */
    private var _token: String      = DomainConst.BLANK
    
    // MARK: Constant
    // Logo
    var LOGIN_LOGO_REAL_WIDTH_HD        = GlobalConst.LOGIN_LOGO_WIDTH * BaseViewController.W_RATE_HD
    var LOGIN_LOGO_REAL_HEIGHT_HD       = GlobalConst.LOGIN_LOGO_HEIGHT * BaseViewController.H_RATE_HD
    var LOGIN_LOGO_REAL_Y_POS_HD        = GlobalConst.LOGIN_LOGO_Y_POS * BaseViewController.H_RATE_HD
    
    var LOGIN_LOGO_REAL_WIDTH_FHD       = GlobalConst.LOGIN_LOGO_WIDTH * BaseViewController.W_RATE_FHD
    var LOGIN_LOGO_REAL_HEIGHT_FHD      = GlobalConst.LOGIN_LOGO_HEIGHT * BaseViewController.H_RATE_FHD
    var LOGIN_LOGO_REAL_Y_POS_FHD       = GlobalConst.LOGIN_LOGO_Y_POS_FHD * BaseViewController.H_RATE_FHD
    
    var LOGIN_LOGO_REAL_WIDTH_FHD_L     = GlobalConst.LOGIN_LOGO_WIDTH * BaseViewController.W_RATE_FHD_L
    var LOGIN_LOGO_REAL_HEIGHT_FHD_L    = GlobalConst.LOGIN_LOGO_HEIGHT * BaseViewController.H_RATE_FHD_L
    var LOGIN_LOGO_REAL_Y_POS_FHD_L     = GlobalConst.LOGIN_LOGO_Y_POS_FHD_LAND * BaseViewController.H_RATE_FHD_L
    
    // Phone
    var CONFIRM_CODE_REAL_WIDTH_HD       = GlobalConst.LOGIN_TEXTFIELD_WIDTH * BaseViewController.W_RATE_HD
    var CONFIRM_CODE_REAL_HEIGHT_HD      = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * BaseViewController.H_RATE_HD
    var CONFIRM_CODE_REAL_WIDTH_FHD      = GlobalConst.LOGIN_TEXTFIELD_WIDTH * BaseViewController.W_RATE_FHD
    var CONFIRM_CODE_REAL_HEIGHT_FHD     = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * BaseViewController.H_RATE_FHD
    var CONFIRM_CODE_REAL_WIDTH_FHD_L    = GlobalConst.LOGIN_TEXTFIELD_WIDTH * BaseViewController.W_RATE_FHD_L
    var CONFIRM_CODE_REAL_HEIGHT_FHD_L   = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * BaseViewController.H_RATE_FHD_L
    // Next button
    var CONFIRM_NEXT_BUTTON_REAL_SIZE_HD      = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * BaseViewController.H_RATE_HD
    var CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD     = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * BaseViewController.H_RATE_FHD
    var CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD_L   = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * BaseViewController.H_RATE_FHD_L
    
    // Resend
    var RESEND_BTN_REAL_WIDTH_HD        = GlobalConst.RESEND_BUTTON_WIDTH * BaseViewController.W_RATE_HD
    var RESEND_BTN_REAL_WIDTH_FHD       = GlobalConst.RESEND_BUTTON_WIDTH * BaseViewController.W_RATE_FHD
    var RESEND_BTN_REAL_WIDTH_FHD_L     = GlobalConst.RESEND_BUTTON_WIDTH * BaseViewController.W_RATE_FHD_L
    
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /**
     * Handle update constants
     */
    override func updateConst() {
        super.updateConst()
        
        // Login
        LOGIN_LOGO_REAL_WIDTH_HD        = GlobalConst.LOGIN_LOGO_WIDTH * BaseViewController.W_RATE_HD
        LOGIN_LOGO_REAL_HEIGHT_HD       = GlobalConst.LOGIN_LOGO_HEIGHT * BaseViewController.H_RATE_HD
        LOGIN_LOGO_REAL_Y_POS_HD        = GlobalConst.LOGIN_LOGO_Y_POS * BaseViewController.H_RATE_HD
        
        LOGIN_LOGO_REAL_WIDTH_FHD       = GlobalConst.LOGIN_LOGO_WIDTH * BaseViewController.W_RATE_FHD
        LOGIN_LOGO_REAL_HEIGHT_FHD      = GlobalConst.LOGIN_LOGO_HEIGHT * BaseViewController.H_RATE_FHD
        LOGIN_LOGO_REAL_Y_POS_FHD       = GlobalConst.LOGIN_LOGO_Y_POS_FHD * BaseViewController.H_RATE_FHD
        
        LOGIN_LOGO_REAL_WIDTH_FHD_L     = GlobalConst.LOGIN_LOGO_WIDTH * BaseViewController.W_RATE_FHD_L
        LOGIN_LOGO_REAL_HEIGHT_FHD_L    = GlobalConst.LOGIN_LOGO_HEIGHT * BaseViewController.H_RATE_FHD_L
        LOGIN_LOGO_REAL_Y_POS_FHD_L     = GlobalConst.LOGIN_LOGO_Y_POS_FHD_LAND * BaseViewController.H_RATE_FHD_L
        
        // Phone
        CONFIRM_CODE_REAL_WIDTH_HD       = GlobalConst.LOGIN_TEXTFIELD_WIDTH * BaseViewController.W_RATE_HD
        CONFIRM_CODE_REAL_HEIGHT_HD      = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * BaseViewController.H_RATE_HD
        
        CONFIRM_CODE_REAL_WIDTH_FHD      = GlobalConst.LOGIN_TEXTFIELD_WIDTH * BaseViewController.W_RATE_FHD
        CONFIRM_CODE_REAL_HEIGHT_FHD     = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * BaseViewController.H_RATE_FHD
        
        CONFIRM_CODE_REAL_WIDTH_FHD_L    = GlobalConst.LOGIN_TEXTFIELD_WIDTH * BaseViewController.W_RATE_FHD
        CONFIRM_CODE_REAL_HEIGHT_FHD_L   = GlobalConst.LOGIN_TEXTFIELD_HEIGHT * BaseViewController.H_RATE_FHD
        
        // Next button
        CONFIRM_NEXT_BUTTON_REAL_SIZE_HD      = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * BaseViewController.H_RATE_HD
        CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD     = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * BaseViewController.H_RATE_FHD
        CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD_L   = GlobalConst.LOGIN_NEXT_BUTTON_SIZE * BaseViewController.H_RATE_FHD_L
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
        super.createChildrenViews()
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            self.createLogoImgHD()
            self.createInputCodeLabel()
            self.createCodeTextFieldHD()
            self.createNextBtnHD()
            self.createGroupLabel()
            self.createResendLabelHD()
            self.createResendBtnHD()
            self.createWrongPhoneLabelHD()
            self.createBackBtnHD()
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                self.createLogoImgFHD()
                self.createInputCodeLabel()
                self.createCodeTextFieldFHD()
                self.createNextBtnFHD()
                self.createGroupLabel()
                self.createResendLabelFHD()
                self.createResendBtnFHD()
                self.createWrongPhoneLabelFHD()
                self.createBackBtnFHD()
            case .landscapeLeft, .landscapeRight:       // Landscape
                self.createLogoImgFHD_L()
                self.createInputCodeLabel()
                self.createCodeTextFieldFHD_L()
                self.createNextBtnFHD_L()
                self.createGroupLabel()
                self.createResendLabelFHD_L()
                self.createResendBtnFHD_L()
                self.createWrongPhoneLabelFHD_L()
                self.createBackBtnFHD_L()
            default:
                break
            }
            
            break
        default:
            break
        }
        
        imgLogo.image = ImageManager.getImage(named: DomainConst.LOGO_LOGIN_ICON_IMG_NAME)
        
//        createNextBtn()
        
        self.view.addSubview(imgLogo)
        self.view.addSubview(lblInput)
        self.view.addSubview(txtCode)
        self.view.addSubview(lbl1)
        self.view.addSubview(lbl2)
        self.view.addSubview(lbl3)
        self.view.addSubview(lbl4)
        self.view.addSubview(lbl5)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(GlobalConst.RESEND_BTN_TIME_WAIT),
                                      execute: {
                                        self.view.addSubview(self.lbl6)
                                        self.view.addSubview(self.btnResend)
        })
//        self.view.addSubview(btnResend)
        self.view.addSubview(lblWrongPhone)
        self.view.addSubview(btnBack)
    }
    
    /**
     * Update children views
     */
    override func updateChildrenViews() {
        super.updateChildrenViews()
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            self.createLogoImgHD()
            self.updateInputCodeLabel()
            self.updateCodeTextFieldHD()
            self.updateGroupLabel()
            self.updateResendLabelHD()
            self.updateResendBtnHD()
            self.updateWrongPhoneLabelHD()
            self.updateBackBtnHD()
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                self.createLogoImgFHD()
                self.updateInputCodeLabel()
                self.updateCodeTextFieldFHD()
                self.updateGroupLabel()
                self.updateResendLabelFHD()
                self.updateResendBtnFHD()
                self.updateWrongPhoneLabelFHD()
                self.updateBackBtnFHD()
            case .landscapeLeft, .landscapeRight:       // Landscape
                self.createLogoImgFHD_L()
                self.updateInputCodeLabel()
                self.updateCodeTextFieldFHD_L()
                self.updateGroupLabel()
                self.updateResendLabelFHD_L()
                self.updateResendBtnFHD_L()
                self.updateWrongPhoneLabelFHD_L()
                self.updateBackBtnFHD_L()
            default:
                break
            }
            
            break
        default:
            break
        }
    }
    
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = LoginRespModel(jsonString: data)
        if model.isSuccess() {
            BaseModel.shared.loginSuccess(model.token)
            BaseModel.shared.saveTempData(loginModel: model)
            UpdateConfigurationRequest.requestUpdateConfiguration(
                action: #selector(finishUpdateConfigRequest(_:)),
                view: self)
        } else {
            showAlert(message: model.message)
        }
    }
    
    // MARK: Event handler
    /**
     * Finish request update config
     */
    func finishUpdateConfigRequest(_ notification: Notification) {
        LoadingView.shared.showOverlay(view: self.view, className: self.theClassName)
        let data = (notification.object as! String)
        let model = LoginRespModel(jsonString: data)
        LoadingView.shared.hideOverlayView(className: self.theClassName)
        if model.isSuccess() {
            BaseModel.shared.saveTempData(loginModel: model)
            self.dismiss(animated: true, completion: finishDismissConfirm)
        } else {
            showAlert(message: model.message)
        }
    }
    
    func finishRequestGenerateOTP(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            self._token = model.token
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when tap on next button
     */
    func btnNextTapped(_ sender: AnyObject) {
        // Get value from text field
        if let codeValue = txtCode.text {
            // Check if value is empty or not
            if !codeValue.isEmpty {
                // Hide keyboard
                self.view.endEditing(true)
                // Start request login
                LoginRequest.requestLogin(
                    action: #selector(setData(_:)),
                    view: self,
                    username: self._phone,
                    password: codeValue,
                    token: self._token)
                return
            }
        }
        showAlert(message: DomainConst.CONTENT00494)
    }
    
    internal func finishDismissConfirm() -> Void {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: G12Const.NOTIFY_NAME_G12_REQUEST_TRANSACTION_START),
                object: nil)
            // Remove observer
            NotificationCenter.default.removeObserver(
                self.view,
                name: Notification.Name(
                    rawValue: G12Const.NOTIFY_NAME_G12_REQUEST_TRANSACTION_START),
                object: nil)
        }
        print("finishDismissConfirm")
    }
    /**
     * Handle when tap on resend button
     */
    func btnResendTapped(_ sender: AnyObject) {
        if !_phone.isEmpty {
            // Hide keyboard
            self.view.endEditing(true)
            GenerateOTPRequest.request(
                action: #selector(finishRequestGenerateOTP),
                view: self,
                phone: _phone)
        }
    }
    
    /**
     * Handle when tap on resend button
     */
    func btnBackTapped(_ sender: AnyObject) {
        // Back to login view
        self.dismiss(animated: true, completion: backToLogin)
    }
    
    internal func backToLogin() -> Void {
        print("backToLogin")
        let view = G00LoginExtVC(nibName: G00LoginExtVC.theClassName, bundle: nil)
        if let controller = BaseViewController.getCurrentViewController() {
            controller.present(view, animated: true, completion: finishOpenLogin)
        }
    }
    
    internal func finishOpenLogin() -> Void {
        print("finishOpenLogin")
    }
    
    // MARK: Utilities
    
    // MARK: Logo image
    /**
     * Create logo image (in HD mode)
     */
    private func createLogoImgHD() {
        CommonProcess.updateViewPos(view: imgLogo,
                      x: (UIScreen.main.bounds.width - LOGIN_LOGO_REAL_WIDTH_HD) / 2,
                      y: LOGIN_LOGO_REAL_Y_POS_HD,
                      w: LOGIN_LOGO_REAL_WIDTH_HD,
                      h: LOGIN_LOGO_REAL_HEIGHT_HD)
    }
    
    /**
     * Create logo image (in Full HD mode)
     */
    private func createLogoImgFHD() {
        CommonProcess.updateViewPos(view: imgLogo,
                      x: (UIScreen.main.bounds.width - LOGIN_LOGO_REAL_WIDTH_FHD) / 2,
                      y: LOGIN_LOGO_REAL_Y_POS_FHD,
                      w: LOGIN_LOGO_REAL_WIDTH_FHD,
                      h: LOGIN_LOGO_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create logo image (in Full HD Landscape mode)
     */
    private func createLogoImgFHD_L() {
        CommonProcess.updateViewPos(view: imgLogo,
                      x: (UIScreen.main.bounds.width  - LOGIN_LOGO_REAL_WIDTH_FHD_L) / 2,
                      y: LOGIN_LOGO_REAL_Y_POS_FHD_L,
                      w: LOGIN_LOGO_REAL_WIDTH_FHD_L,
                      h: LOGIN_LOGO_REAL_HEIGHT_FHD_L)
    }
    
    // MARK: Input code label
    /**
     * Create login label
     */
    private func createInputCodeLabel() {
        lblInput.frame = CGRect(x: 0,
                                y: imgLogo.frame.maxY + GlobalConst.MARGIN,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H)
        lblInput.text           = DomainConst.CONTENT00475.uppercased()
        lblInput.textColor      = UIColor.black
        lblInput.font           = GlobalConst.BASE_FONT
        lblInput.textAlignment  = .center
    }
    
    /**
     * Update login label
     */
    private func updateInputCodeLabel() {
        CommonProcess.updateViewPos(view: lblInput,
                      x: 0,
                      y: imgLogo.frame.maxY + GlobalConst.MARGIN,
                      w: UIScreen.main.bounds.width,
                      h: GlobalConst.LABEL_H)
    }
    
    // MARK: Input code textfield
    /**
     * Create code text field
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createCodeTextField(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        txtCode.frame              = CGRect(x: x, y: y, width: w, height: h)
        txtCode.placeholder        = DomainConst.BLANK
        txtCode.backgroundColor    = UIColor.white
        txtCode.textAlignment      = .center
        txtCode.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS_NEW
        txtCode.keyboardType       = .numberPad
        txtCode.returnKeyType      = .done
    }
    
    /**
     * Create code text field (in HD mode)
     */
    private func createCodeTextFieldHD() {
        self.createCodeTextField(
            x: (UIScreen.main.bounds.width - CONFIRM_CODE_REAL_WIDTH_HD) / 2,
            y: lblInput.frame.maxY + GlobalConst.MARGIN,
            w: CONFIRM_CODE_REAL_WIDTH_HD,
            h: CONFIRM_CODE_REAL_HEIGHT_HD)
    }
    
    /**
     * Create code text field (in Full HD mode)
     */
    private func createCodeTextFieldFHD() {
        self.createCodeTextField(
            x: (UIScreen.main.bounds.width - CONFIRM_CODE_REAL_WIDTH_FHD) / 2,
            y: lblInput.frame.maxY + GlobalConst.MARGIN,
            w: CONFIRM_CODE_REAL_WIDTH_FHD,
            h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create code text field (in Full HD Landscape mode)
     */
    private func createCodeTextFieldFHD_L() {
        self.createCodeTextField(
            x: (UIScreen.main.bounds.width - CONFIRM_CODE_REAL_WIDTH_FHD_L) / 2,
            y: lblInput.frame.maxY + GlobalConst.MARGIN,
            w: CONFIRM_CODE_REAL_WIDTH_FHD_L,
            h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Update code text field (in HD mode)
     */
    private func updateCodeTextFieldHD() {
        CommonProcess.updateViewPos(view: txtCode,
                      x: (UIScreen.main.bounds.width - CONFIRM_CODE_REAL_WIDTH_HD) / 2,
                      y: lblInput.frame.maxY + GlobalConst.MARGIN,
                      w: CONFIRM_CODE_REAL_WIDTH_HD,
                      h: CONFIRM_CODE_REAL_HEIGHT_HD)
    }
    
    /**
     * Update code text field (in Full HD mode)
     */
    private func updateCodeTextFieldFHD() {
        CommonProcess.updateViewPos(view: txtCode,
                      x: (UIScreen.main.bounds.width - CONFIRM_CODE_REAL_WIDTH_FHD) / 2,
                      y: lblInput.frame.maxY + GlobalConst.MARGIN,
                      w: CONFIRM_CODE_REAL_WIDTH_FHD,
                      h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Update code text field (in Full HD Landscape mode)
     */
    private func updateCodeTextFieldFHD_L() {
        CommonProcess.updateViewPos(view: txtCode,
                      x: (UIScreen.main.bounds.width - CONFIRM_CODE_REAL_WIDTH_FHD_L) / 2,
                      y: lblInput.frame.maxY + GlobalConst.MARGIN,
                      w: CONFIRM_CODE_REAL_WIDTH_FHD_L,
                      h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
    }
    
    // MARK: Next button
    /**
     * Create next button
     */
    private func createNextBtn() {
        btnNext.setImage(ImageManager.getImage(named: DomainConst.NEXT_BUTTON_ICON_IMG_NAME),
                         for: .normal)
        btnNext.addTarget(self, action: #selector(btnNextTapped(_:)), for: .touchUpInside)
        txtCode.rightView = btnNext
        txtCode.rightViewMode = .always
    }
    
    /**
     * Create next button (in HD mode)
     */
    private func createNextBtnHD() {
        createNextBtn()
        CommonProcess.updateViewPos(view: btnNext,
                      x: CGFloat(txtCode.frame.width - CONFIRM_NEXT_BUTTON_REAL_SIZE_HD * 2),
                      y: (txtCode.frame.height - CONFIRM_NEXT_BUTTON_REAL_SIZE_HD ) / 2,
                      w: CONFIRM_NEXT_BUTTON_REAL_SIZE_HD,
                      h: CONFIRM_NEXT_BUTTON_REAL_SIZE_HD)
    }
    
    /**
     * Create next button (in Full HD mode)
     */
    private func createNextBtnFHD() {
        createNextBtn()
        CommonProcess.updateViewPos(view: btnNext,
                      x: CGFloat(txtCode.frame.width - CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD * 2),
                      y: (txtCode.frame.height - CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD ) / 2,
                      w: CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD,
                      h: CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD)
    }
    
    /**
     * Create next button (in Full HD Landscape mode)
     */
    private func createNextBtnFHD_L() {
        createNextBtn()
        CommonProcess.updateViewPos(view: btnNext,
                      x: CGFloat(txtCode.frame.width - CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD_L * 2),
                      y: (txtCode.frame.height - CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD_L ) / 2,
                      w: CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD_L,
                      h: CONFIRM_NEXT_BUTTON_REAL_SIZE_FHD_L)
    }
    
    // MARK: Group labels
    /**
     * Create label
     * - parameter label:   Lable view
     * - parameter offset:  Y offset
     * - parameter text:    Lable content
     * - parameter color:   Color of text
     * - parameter isBold:  Flag is bold or not
     */
    private func createLabel(label: UILabel, offset: CGFloat, text: String, color: UIColor = UIColor.black, isBold: Bool = false) {
        label.frame = CGRect(x: 0,
                                y: offset,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H)
        label.text          = text
        label.textColor     = color
        if isBold {
            label.font      = GlobalConst.BASE_BOLD_FONT
        } else {
            label.font      = UIFont.italicSystemFont(ofSize: GlobalConst.BASE_FONT_SIZE)
        }
        label.textAlignment  = .center
    }
    
    /**
     * Create label
     * - parameter label:   Lable view
     * - parameter x:       X offset
     * - parameter y:       Y offset
     * - parameter w:       Width of view
     * - parameter h:       height of view
     * - parameter text:    Lable content
     * - parameter color:   Color of text
     * - parameter isBold:  Flag is bold or not
     */
    private func createLabel(label: UILabel,
                             x: CGFloat, y: CGFloat,
                             w: CGFloat, h: CGFloat,
                             text: String,
                             color: UIColor = UIColor.black,
                             isBold: Bool = false) {
        label.frame = CGRect(x: x, y: y,
                             width: w,
                             height: h)
        label.text          = text
        label.textColor     = color
        if isBold {
            label.font      = GlobalConst.BASE_BOLD_FONT
        } else {
            label.font      = UIFont.italicSystemFont(ofSize: GlobalConst.BASE_FONT_SIZE)
        }
        label.textAlignment  = .center
    }
    
    /**
     * Update label
     * - parameter label:   Lable view
     * - parameter offset:  Y offset
     */
    private func updateLabel(label: UILabel, offset: CGFloat) {
        CommonProcess.updateViewPos(view: label,
                                    x: 0,
                                    y: offset,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H)
    }
    
    /**
     * Create group label
     */
    private func createGroupLabel() {
        self.createLabel(label: lbl1,
                         offset: txtCode.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00477)
        self.createLabel(label: lbl2,
                         offset: lbl1.frame.maxY + GlobalConst.MARGIN,
                         text: _phone, color: GlobalConst.MAIN_COLOR_GAS_24H, isBold: true)
        self.createLabel(label: lbl3,
                         offset: lbl2.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00478)
        self.createLabel(label: lbl4,
                         offset: lbl3.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00479)
        self.createLabel(label: lbl5,
                         offset: lbl4.frame.maxY + GlobalConst.MARGIN,
                         text: DomainConst.CONTENT00480)
//        self.createLabel(label: lbl6,
//                         offset: lbl5.frame.maxY + GlobalConst.MARGIN,
//                         text: DomainConst.CONTENT00481, color: GlobalConst.MAIN_COLOR_GAS_24H)
        
    }
    
    /**
     * Update group label
     */
    private func updateGroupLabel() {
        self.updateLabel(label: lbl1,
                         offset: txtCode.frame.maxY + GlobalConst.MARGIN)
        self.updateLabel(label: lbl2,
                         offset: lbl1.frame.maxY + GlobalConst.MARGIN)
        self.updateLabel(label: lbl3,
                         offset: lbl2.frame.maxY + GlobalConst.MARGIN)
        self.updateLabel(label: lbl4,
                         offset: lbl3.frame.maxY + GlobalConst.MARGIN)
        self.updateLabel(label: lbl5,
                         offset: lbl4.frame.maxY + GlobalConst.MARGIN)
        self.updateLabel(label: lbl6,
                         offset: lbl5.frame.maxY + GlobalConst.MARGIN)
        
    }
    
    // MARK: Resend label
    private func createResendLabel(w: CGFloat, h: CGFloat) {
        self.createLabel(label: lbl6,
                         x: txtCode.frame.minX,
                         y: lbl5.frame.maxY + GlobalConst.MARGIN,
                         w: w,
                         h: h,
                         text: DomainConst.CONTENT00481,
                         color: GlobalConst.MAIN_COLOR_GAS_24H)
    }
    
    private func createResendLabelHD() {
        createResendLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_HD,
                          h: CONFIRM_CODE_REAL_HEIGHT_HD)
        
    }
    
    private func createResendLabelFHD() {
        createResendLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD)
        
    }
    
    private func createResendLabelFHD_L() {
        createResendLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD_L,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
        
    }
    
    private func updateResendLabel(w: CGFloat, h: CGFloat) {
        CommonProcess.updateViewPos(
            view: lbl6,
            x: txtCode.frame.minX,
            y: lbl5.frame.maxY + GlobalConst.MARGIN,
            w: w, h: h)
    }
    
    private func updateResendLabelHD() {
        updateResendLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    private func updateResendLabelFHD() {
        updateResendLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    private func updateResendLabelFHD_L() {
        updateResendLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD_L,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
    }
    
    // MARK: Resend button
    /**
     * Create resend button
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createResendBtn(w: CGFloat, h: CGFloat) {
        btnResend.frame = CGRect(x: txtCode.frame.maxX - w,
                                 y: lbl5.frame.maxY + GlobalConst.MARGIN,
                                 width: w, height: h)
        btnResend.setTitle(DomainConst.CONTENT00482.uppercased(), for: UIControlState())
        btnResend.setTitleColor(GlobalConst.MAIN_COLOR_GAS_24H, for: UIControlState())
        btnResend.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
        btnResend.backgroundColor = UIColor.clear
        btnResend.layer.borderColor = GlobalConst.MAIN_COLOR_GAS_24H.cgColor
        btnResend.layer.borderWidth = 1
        btnResend.addTarget(self, action: #selector(btnResendTapped(_:)), for: .touchUpInside)
    }
    
    /**
     * Create resend button (in HD mode)
     */
    private func createResendBtnHD() {
        self.createResendBtn(
            w: RESEND_BTN_REAL_WIDTH_HD,
            h: CONFIRM_CODE_REAL_HEIGHT_HD)
    }
    
    /**
     * Create resend button (in Full HD mode)
     */
    private func createResendBtnFHD() {
        self.createResendBtn(
            w: RESEND_BTN_REAL_WIDTH_FHD,
            h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create resend button (in Full HD Landscape mode)
     */
    private func createResendBtnFHD_L() {
        self.createResendBtn(w: RESEND_BTN_REAL_WIDTH_FHD_L,
            h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
    }
    
    private func updateResendBtn(w: CGFloat, h: CGFloat) {
        CommonProcess.updateViewPos(
            view: btnResend,
            x: txtCode.frame.maxX - w,
            y: lbl5.frame.maxY + GlobalConst.MARGIN,
            w: w, h: h)
    }
    
    /**
     * Update resend button (in HD mode)
     */
    private func updateResendBtnHD() {
        updateResendBtn(w: RESEND_BTN_REAL_WIDTH_HD,
                        h: CONFIRM_CODE_REAL_HEIGHT_HD)
    }
    
    /**
     * Update resend button (in Full HD mode)
     */
    private func updateResendBtnFHD() {
        updateResendBtn(w: RESEND_BTN_REAL_WIDTH_FHD,
            h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Update resend button (in Full HD Landscape mode)
     */
    private func updateResendBtnFHD_L() {
        updateResendBtn(w: RESEND_BTN_REAL_WIDTH_FHD_L,
            h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
    }
    
    // MARK: Wrong phone label
    private func createWrongPhoneLabel(w: CGFloat, h: CGFloat) {
        self.createLabel(label: lblWrongPhone,
                         x: txtCode.frame.minX,
                         y: lbl6.frame.maxY + GlobalConst.MARGIN,
                         w: w,
                         h: h,
                         text: DomainConst.CONTENT00508,
                         color: GlobalConst.MAIN_COLOR_GAS_24H)
    }
    
    private func createWrongPhoneLabelHD() {
        createWrongPhoneLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_HD,
                          h: CONFIRM_CODE_REAL_HEIGHT_HD)
        
    }
    
    private func createWrongPhoneLabelFHD() {
        createWrongPhoneLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD)
        
    }
    
    private func createWrongPhoneLabelFHD_L() {
        createWrongPhoneLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD_L,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
        
    }
    
    private func updateWrongPhoneLabel(w: CGFloat, h: CGFloat) {
        CommonProcess.updateViewPos(
            view: lblWrongPhone,
            x: txtCode.frame.minX,
            y: lbl6.frame.maxY + GlobalConst.MARGIN,
            w: w, h: h)
    }
    
    private func updateWrongPhoneLabelHD() {
        updateWrongPhoneLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    private func updateWrongPhoneLabelFHD() {
        updateWrongPhoneLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    private func updateWrongPhoneLabelFHD_L() {
        updateWrongPhoneLabel(w: txtCode.frame.width - RESEND_BTN_REAL_WIDTH_FHD_L,
                          h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
    }
    
    // MARK: Back button
    /**
     * Create back button
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createBackBtn(w: CGFloat, h: CGFloat) {
        btnBack.frame = CGRect(x: txtCode.frame.maxX - w,
                                 y: lbl6.frame.maxY + GlobalConst.MARGIN,
                                 width: w, height: h)
        btnBack.setTitle(DomainConst.CONTENT00509.uppercased(), for: UIControlState())
        btnBack.setTitleColor(GlobalConst.MAIN_COLOR_GAS_24H, for: UIControlState())
        btnBack.titleLabel?.font = UIFont.boldSystemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
        btnBack.backgroundColor = UIColor.clear
        btnBack.layer.borderColor = GlobalConst.MAIN_COLOR_GAS_24H.cgColor
        btnBack.layer.borderWidth = 1
        btnBack.addTarget(self, action: #selector(btnBackTapped(_:)), for: .touchUpInside)
    }
    
    /**
     * Create resend button (in HD mode)
     */
    private func createBackBtnHD() {
        self.createBackBtn(
            w: RESEND_BTN_REAL_WIDTH_HD,
            h: CONFIRM_CODE_REAL_HEIGHT_HD)
    }
    
    /**
     * Create resend button (in Full HD mode)
     */
    private func createBackBtnFHD() {
        self.createBackBtn(
            w: RESEND_BTN_REAL_WIDTH_FHD,
            h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Create resend button (in Full HD Landscape mode)
     */
    private func createBackBtnFHD_L() {
        self.createBackBtn(w: RESEND_BTN_REAL_WIDTH_FHD_L,
                             h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
    }
    
    private func updateBackBtn(w: CGFloat, h: CGFloat) {
        CommonProcess.updateViewPos(
            view: btnBack,
            x: txtCode.frame.maxX - w,
            y: lbl6.frame.maxY + GlobalConst.MARGIN,
            w: w, h: h)
    }
    
    /**
     * Update resend button (in HD mode)
     */
    private func updateBackBtnHD() {
        updateBackBtn(w: RESEND_BTN_REAL_WIDTH_HD,
                        h: CONFIRM_CODE_REAL_HEIGHT_HD)
    }
    
    /**
     * Update resend button (in Full HD mode)
     */
    private func updateBackBtnFHD() {
        updateBackBtn(w: RESEND_BTN_REAL_WIDTH_FHD,
                        h: CONFIRM_CODE_REAL_HEIGHT_FHD)
    }
    
    /**
     * Update resend button (in Full HD Landscape mode)
     */
    private func updateBackBtnFHD_L() {
        updateBackBtn(w: RESEND_BTN_REAL_WIDTH_FHD_L,
                        h: CONFIRM_CODE_REAL_HEIGHT_FHD_L)
    }
    
    /**
     * Set data
     * - parameter phone: Phone value
     * - parameter token: Token value
     */
    public func setData(phone: String, token: String) {
        self._phone = phone
        self._token = token
    }
}
