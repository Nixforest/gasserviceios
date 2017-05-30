//
//  G05F01S02VC.swift
//  project
//
//  Created by SPJ on 2/16/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

//++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
//class G05F01S02VC: BaseViewController, UITextViewDelegate {
class G05F01S02VC: ChildViewController, UITextViewDelegate, UITextFieldDelegate {
//-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
    /** List of selector */
    private var _lstSelector:       [OrderVIPSelectorView]  = [OrderVIPSelectorView]()
    /** Label */
    private var _lblTitle:          UILabel                 = UILabel()
    /** Title view */
    private var _viewTitle:         UIView                  = UIView()
    /** Label */
    private var _lblType:           UILabel                 = UILabel()
    /** Label */
    private var _lblQuantity:       UILabel                 = UILabel()
    /** Button confirm */
    private var _btnConfirm:        UIButton                = UIButton()
    /** Button cancel */
    private var _btnCancel:         UIButton                = UIButton()
    /** Note textfield */
    private var _tbxNote:           UITextView              = UITextView()
    //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
    /** Width of quantity colum */
    private let qtyColWidth: CGFloat                        = GlobalConst.SCREEN_WIDTH / 7 + GlobalConst.STEPPER_LAYOUT_WIDTH + GlobalConst.MARGIN
    //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
    /** Textfield */
    private var _txtPhone:          UITextField             = UITextField()

    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        let orderInfo = BaseModel.shared.getOrderVipDescription()

        // Do any additional setup after loading the view.
        //++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        //setupNavigationBar(title: DomainConst.CONTENT00130, isNotifyEnable: true)
        createNavigationBar(title: DomainConst.CONTENT00130)
        //-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        var offset = getTopHeight()
        let width = GlobalConst.SCREEN_WIDTH /*- 2 * GlobalConst.MARGIN*/
        // Title
//        _lblTitle.frame = CGRect(x: GlobalConst.MARGIN,
//                                 y: offset,
//                                 width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN,
//                                 height: GlobalConst.BUTTON_H)
//        _lblTitle.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//        _lblTitle.textColor = UIColor.black
//        _lblTitle.textAlignment = .center
//        _lblTitle.text = DomainConst.CONTENT00253
//        self.view.addSubview(_lblTitle)
//        offset = offset + _lblTitle.frame.height + GlobalConst.MARGIN_CELL_X
        
        // Title view
        _viewTitle.frame = CGRect(x: 0, y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.BUTTON_H)
        _viewTitle.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        self.view.addSubview(_viewTitle)
        
        // Type label
        _lblType.frame = CGRect(x: GlobalConst.MARGIN,
                                y: offset,
                                width: width / 2,
                                height: GlobalConst.BUTTON_H)
        _lblType.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _lblType.textColor = UIColor.black
        _lblType.textAlignment = .center
        _lblType.text = DomainConst.CONTENT00254
        _lblType.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        self.view.addSubview(_lblType)
        
        // Quantity label
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
        //_lblQuantity.frame = CGRect(x: width * 2 / 3,
        _lblQuantity.frame = CGRect(x: width - qtyColWidth,
                                    y: offset,
                                    //width: width / 3,
                                    width: qtyColWidth,
                                    height: GlobalConst.BUTTON_H)
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
        _lblQuantity.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _lblQuantity.textColor = UIColor.black
        _lblQuantity.textAlignment = .center
        _lblQuantity.text = DomainConst.CONTENT00255
        _lblQuantity.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        self.view.addSubview(_lblQuantity)
        offset = offset + _lblType.frame.height + GlobalConst.MARGIN_CELL_X
        
        let selector = OrderVIPSelectorView()
        selector.setup(frame: CGRect(x: 0, y: offset,
                                     width: width,
                                     height: GlobalConst.BUTTON_H),
                       checkboxLabel: "Bình gas 50Kg",
                       config: ConfigBean(id: DomainConst.KEY_B50, name: orderInfo.0))
        _lstSelector.append(selector)
        self.view.addSubview(selector)
        offset = offset + selector.frame.height + GlobalConst.MARGIN_CELL_X
        
        let selector45 = OrderVIPSelectorView()
        selector45.setup(frame: CGRect(x: 0, y: offset,
                                     width: width,
                                     height: GlobalConst.BUTTON_H),
                         checkboxLabel: "Bình gas 45Kg",
                         config: ConfigBean(id: DomainConst.KEY_B45, name: orderInfo.1))
        _lstSelector.append(selector45)
        self.view.addSubview(selector45)
        offset = offset + selector45.frame.height + GlobalConst.MARGIN_CELL_X
        
        let selector12 = OrderVIPSelectorView()
        selector12.setup(frame: CGRect(x: 0, y: offset,
                                     width: width,
                                     height: GlobalConst.BUTTON_H),
                         checkboxLabel: "Bình gas 12Kg",
                         config: ConfigBean(id: DomainConst.KEY_B12, name: orderInfo.2))
        _lstSelector.append(selector12)
        self.view.addSubview(selector12)
        offset = offset + selector12.frame.height + GlobalConst.MARGIN
        
        let selector6 = OrderVIPSelectorView()
        selector6.setup(frame: CGRect(x: 0, y: offset,
                                     width: width,
                                     height: GlobalConst.BUTTON_H),
                        checkboxLabel: "Bình gas 6Kg",
                        config: ConfigBean(id: DomainConst.KEY_B6, name: orderInfo.3))
        _lstSelector.append(selector6)
        self.view.addSubview(selector6)
        offset = offset + selector6.frame.height + GlobalConst.MARGIN
        
        //++ BUG0086-SPJ (NguyenPT 20170530) Add phone
        // Phone number input
        _txtPhone.frame = CGRect(x: (width - GlobalConst.EDITTEXT_W) / 2,
                               y: offset,
                               width: GlobalConst.EDITTEXT_W,
                               height: GlobalConst.EDITTEXT_H)
        _txtPhone.font = UIFont.boldSystemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        _txtPhone.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        _txtPhone.placeholder = DomainConst.CONTENT00054
        _txtPhone.textAlignment = .center
        _txtPhone.layer.borderWidth = 1
        _txtPhone.layer.borderColor = GlobalConst.MAIN_COLOR.cgColor
        _txtPhone.textColor = GlobalConst.MAIN_COLOR
        _txtPhone.returnKeyType = .default
        _txtPhone.keyboardType = .numberPad
        _txtPhone.delegate       = self
        if !orderInfo.4.isEmpty {
            _txtPhone.text = orderInfo.4
        }
        self.view.addSubview(_txtPhone)
        offset = offset + _txtPhone.frame.height + GlobalConst.MARGIN
        //-- BUG0086-SPJ (NguyenPT 20170530) Add phone
        
        // Note textfield
        _tbxNote.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                y: offset,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H * 5)
        _tbxNote.font               = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _tbxNote.backgroundColor    = UIColor.white
        _tbxNote.autocorrectionType = .no
        _tbxNote.translatesAutoresizingMaskIntoConstraints = true
        _tbxNote.returnKeyType      = .done
        _tbxNote.tag                = 0
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
        //_tbxNote.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
        _tbxNote.text = orderInfo.5
        //++ BUG0063-SPJ (NguyenPT 20170421) Use stepper
        //CommonProcess.setBorder(view: _tbxNote)
        CommonProcess.setBorder(view: _tbxNote, radius: GlobalConst.BUTTON_CORNER_RADIUS)
        //-- BUG0063-SPJ (NguyenPT 20170421) Use stepper
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.view.addGestureRecognizer(gesture)
        _tbxNote.delegate = self
        self.view.addSubview(_tbxNote)
        offset = offset + _tbxNote.frame.height + GlobalConst.MARGIN_CELL_X
        
        // Button Confirm
        self._btnConfirm.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                        y: offset,
                                        width: GlobalConst.BUTTON_W / 2,
                                        height: GlobalConst.BUTTON_H)
        self._btnConfirm.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self._btnConfirm.setTitle(DomainConst.CONTENT00217.uppercased(), for: UIControlState())
        self._btnConfirm.setTitleColor(UIColor.white, for: UIControlState())
        self._btnConfirm.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self._btnConfirm.addTarget(self, action: #selector(btnConfirmTapped), for: .touchUpInside)
        self._btnConfirm.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._btnConfirm.setImage(ImageManager.getImage(named: DomainConst.CONFIRM_IMG_NAME), for: UIControlState())
        self._btnConfirm.imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(_btnConfirm)
        
        // Button Cancel
        self._btnCancel.frame = CGRect(x: GlobalConst.SCREEN_WIDTH / 2,
                                       y: offset,
                                       width: GlobalConst.BUTTON_W / 2,
                                       height: GlobalConst.BUTTON_H)
        self._btnCancel.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        self._btnCancel.setTitle(DomainConst.CONTENT00220.uppercased(), for: UIControlState())
        self._btnCancel.setTitleColor(UIColor.white, for: UIControlState())
        self._btnCancel.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self._btnCancel.addTarget(self, action: #selector(btnCancelTapped(_:)), for: .touchUpInside)
        self._btnCancel.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._btnCancel.setImage(ImageManager.getImage(named: DomainConst.CANCEL_IMG_NAME), for: UIControlState())
        self._btnCancel.imageView?.contentMode = .scaleAspectFit
        offset = offset + self._btnCancel.frame.height + GlobalConst.MARGIN_CELL_X
        self.view.addSubview(_btnCancel)
        
        self.view.makeComponentsColor()
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
    // hides text views
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == DomainConst.LINE_FEED) {
            textView.resignFirstResponder()
            hideKeyboard()
            return false
        }
        return true
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
        isKeyboardShow = false
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        if isKeyboardShow == false {
            isKeyboardShow = true
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    /**
     * Hide keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        hideKeyboard()
    }
    
    /**
     * Handle move textfield when keyboard overloading
     */
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        let delta = self._tbxNote.frame.maxY - self.keyboardTopY
        if delta > 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y - delta, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
        }
    }
    
    /**
     * Handle when tap cancel button
     */
    func btnCancelTapped(_ sender: AnyObject) {
        self.showAlert(message: DomainConst.CONTENT00256,
                       okHandler: {
                        (alert: UIAlertAction!) in
                        self.backButtonTapped(self)
                    },
                       cancelHandler: {
                        (alert: UIAlertAction!) in
                        
        })
    }
    
    /**
     * Handle when tap confirm button
     */
    func btnConfirmTapped(_ sender: AnyObject) {
        var b50 = DomainConst.NUMBER_ZERO_VALUE
        var b45 = DomainConst.NUMBER_ZERO_VALUE
        var b12 = DomainConst.NUMBER_ZERO_VALUE
        var b6 = DomainConst.NUMBER_ZERO_VALUE
        for item in self._lstSelector {
            switch item.getSelectorValue().id {
            case DomainConst.KEY_B50:
                if item.getCheckValue() {
                    b50 = item.getSelectorValue().name
                }
                break
            case DomainConst.KEY_B45:
                if item.getCheckValue() {
                    b45 = item.getSelectorValue().name
                }
                break
            case DomainConst.KEY_B12:
                if item.getCheckValue() {
                    b12 = item.getSelectorValue().name
                }
                break
            case DomainConst.KEY_B6:
                if item.getCheckValue() {
                    b6 = item.getSelectorValue().name
                }
                break
            default:
                break
            }
        }
        OrderVIPCreateRequest.requestOrderVIPCreate(
            action: #selector(finishCreateRequest(_:)),
            view: self,
            b50: b50, b45: b45, b12: b12, b6: b6,
            customerPhone: _txtPhone.text!,
            note: self._tbxNote.text)
        BaseModel.shared.setOrderVipDescription(b50: b50, b45: b45, b12: b12, b6: b6, customerPhone: _txtPhone.text!, note: self._tbxNote.text)
    }
    
    /**
     * Handle when finish request create
     */
    func finishCreateRequest(_ notification: Notification) {
        let object = (notification.object as! OrderVIPCreateRespModel)
        self.showAlert(message: object.message,
                       okHandler: {
                        (alert: UIAlertAction!) in
//                        // Back to previous view
//                        self.backButtonTapped(self)
                        G05F00S02VC._id = object.getRecord().id
                        self.pushToView(name: G05Const.G05_F00_S02_VIEW_CTRL)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /**
     * Add a done button when keyboard show
     */
    func addDoneButtonOnKeyboardTextField() {
        // Create toolbar
        let doneToolbar = createDoneToolbar()
        // Add toolbar to keyboard
        _txtPhone.inputAccessoryView = doneToolbar
        self.keyboardTopY -= doneToolbar.frame.height
    }
    
    /**
     * Create done toolbar
     * - returns: Done toolbar
     */
    private func createDoneToolbar() -> UIToolbar {
        // Create toolbar
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(hideKeyboard(_:)))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        return doneToolbar
    }
}
