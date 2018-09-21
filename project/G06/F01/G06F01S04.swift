//
//  G06F01S04.swift
//  project
//
//  Created by SPJ on 4/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F01S04: StepContent, UITextFieldDelegate, AddressPickerViewDelegate {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: (serial: String, brand: String, competitor: String, timeUse: ConfigBean, ccsCode: String)
        = (DomainConst.BLANK, DomainConst.BLANK, DomainConst.BLANK, ConfigBean(id: "", name: ""), DomainConst.BLANK)
    /** Time use */
    public static var _timeUse: [ConfigBean] = [ConfigBean]()
    /** Serial textfield */
    var _tbxSerial = UITextField()
    /** Brand textfield */
    var _tbxBrand = UITextField()
    /** Competitor textfield */
    var _tbxCompetitor = UITextField()
    /** Time use Picker */
    private var _pkrTimeUse = AddressPickerView()
    //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
    /** CCS code textfield */
    var _tbxCCSCode = UITextField()
    private var _pkrCCSCode = AddressPickerView()
    public static var _CCSCodeList: [ConfigBean] = [ConfigBean]()
    //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
    /** Flag show keyboard */
    var _isKeyboardShow: Bool = false

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = 0
        let contentView     = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Serial textfield
        _tbxSerial.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                y: GlobalConst.MARGIN,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H)
        _tbxSerial.font               = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxSerial.borderStyle        = .roundedRect
        _tbxSerial.autocorrectionType = .no
        _tbxSerial.clearButtonMode    = .whileEditing
        _tbxSerial.placeholder        = DomainConst.CONTENT00109
        _tbxSerial.translatesAutoresizingMaskIntoConstraints = true
        _tbxSerial.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        _tbxSerial.returnKeyType      = .next
        _tbxSerial.tag = 0
        //_tbxName.becomeFirstResponder()
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxSerial)
        
        // Brand textfield
        _tbxBrand.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                 y: GlobalConst.MARGIN + offset,
                                 width: GlobalConst.EDITTEXT_W,
                                 height: GlobalConst.EDITTEXT_H)
        _tbxBrand.font                  = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxBrand.borderStyle           = .roundedRect
        _tbxBrand.autocorrectionType    = .no
        _tbxBrand.clearButtonMode       = .whileEditing
        _tbxBrand.placeholder           = DomainConst.CONTENT00115
        _tbxBrand.translatesAutoresizingMaskIntoConstraints = true
        _tbxBrand.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        _tbxBrand.returnKeyType         = .next
        _tbxBrand.tag = 1
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxBrand)
        
        // Competitor textfield
        _tbxCompetitor.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                 y: GlobalConst.MARGIN + offset,
                                 width: GlobalConst.EDITTEXT_W,
                                 height: GlobalConst.EDITTEXT_H)
        _tbxCompetitor.font                  = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxCompetitor.borderStyle           = .roundedRect
        _tbxCompetitor.autocorrectionType    = .no
        _tbxCompetitor.clearButtonMode       = .whileEditing
        _tbxCompetitor.placeholder           = DomainConst.CONTENT00116
        _tbxCompetitor.translatesAutoresizingMaskIntoConstraints = true
        _tbxCompetitor.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        _tbxCompetitor.returnKeyType         = .done
        _tbxCompetitor.tag = 2
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_tbxCompetitor)
        
        // Time use
        if G06F01S04._timeUse.count == 0 {
            for i in 0..<90 {
                G06F01S04._timeUse.append(ConfigBean(id: String(i+1),
                                       name: String.init(format: "%d ngày", i + 1)))
            }
        }
        
        _pkrTimeUse.setup(frame: CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                        y: GlobalConst.MARGIN + offset,
                                         width: GlobalConst.EDITTEXT_W,
                                         height: GlobalConst.EDITTEXT_H),
                           lbl: DomainConst.CONTENT00304,
                           data: G06F01S04._timeUse)
        _pkrTimeUse.layer.borderWidth = 0.5
        _pkrTimeUse.layer.borderColor = GlobalConst.BORDER_TEXTFIELD_COLOR.cgColor
        _pkrTimeUse.layer.cornerRadius = 5
        _pkrTimeUse.delegate = self
        G06F01S04._selectedValue.timeUse = ConfigBean(id: "", name: "")
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_pkrTimeUse)
        
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        // CCS Code textfield
        _tbxCCSCode.frame = CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                      y: GlobalConst.MARGIN + offset,
                                      width: GlobalConst.EDITTEXT_W,
                                      height: GlobalConst.EDITTEXT_H)
        _tbxCCSCode.font                  = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        _tbxCCSCode.borderStyle           = .roundedRect
        _tbxCCSCode.autocorrectionType    = .no
        _tbxCCSCode.clearButtonMode       = .whileEditing
        _tbxCCSCode.autocapitalizationType  = .allCharacters
        _tbxCCSCode.placeholder           = DomainConst.CONTENT00445
        _tbxCCSCode.translatesAutoresizingMaskIntoConstraints = true
        _tbxCCSCode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        _tbxCCSCode.returnKeyType         = .done
        _tbxCCSCode.tag = 3
        //offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        //contentView.addSubview(_tbxCCSCode)
        _pkrCCSCode.setup(frame: CGRect(x: (w - GlobalConst.EDITTEXT_W) / 2,
                                        y: GlobalConst.MARGIN + offset,
                                        width: GlobalConst.EDITTEXT_W,
                                        height: GlobalConst.EDITTEXT_H),
                          lbl: DomainConst.CONTENT00445,
                          data: G06F01S04._CCSCodeList,
                          isPicker: true, isStreet: true)
        _pkrCCSCode.layer.borderWidth = 0.5
        _pkrCCSCode.layer.borderColor = GlobalConst.BORDER_TEXTFIELD_COLOR.cgColor
        _pkrCCSCode.layer.cornerRadius = 5
        _pkrCCSCode.delegate = self
        G06F01S04._selectedValue.ccsCode = DomainConst.BLANK
        offset += GlobalConst.EDITTEXT_H + GlobalConst.MARGIN
        contentView.addSubview(_pkrCCSCode)
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00302,
                   contentHeight: offset,
                   width: w, height: h)
        // Set data
        if !G06F01S04._selectedValue.serial.isEmpty {
            _tbxSerial.text = G06F01S04._selectedValue.serial
        }
        if !G06F01S04._selectedValue.brand.isEmpty {
            _tbxBrand.text = G06F01S04._selectedValue.brand
        }
        if !G06F01S04._selectedValue.competitor.isEmpty {
            _tbxCompetitor.text = G06F01S04._selectedValue.competitor
        }
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        if !G06F01S04._selectedValue.ccsCode.isEmpty {
            _tbxCCSCode.text = G06F01S04._selectedValue.ccsCode
        }
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.addGestureRecognizer(gesture)
        _tbxSerial.delegate     = self
        _tbxBrand.delegate      = self
        _tbxCompetitor.delegate = self
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        _tbxCCSCode.delegate    = self
        //++ BUG0205-SPJ (KhoiVT 20180827) Gasservice - Change param page = 0 when request CCS Code and Add Button Done for Address Picker View
        /*CCSCodeListRequest.requestCCSCode(action: #selector(finishRequestCCSCode(_:)),
                                          view: self, page: "1")*/
        CCSCodeListRequest.requestCCSCode(action: #selector(finishRequestCCSCode(_:)),
                                          view: self, page: "0")
        //-- BUG0205-SPJ (KhoiVT 20180827) Gasservice - Change param page = 0 when request CCS Code and Add Button Done for Address Picker View
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        return
    }
    
    internal func finishRequestCCSCode(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CCSCodeListRespModel(jsonString: data)
        if model.isSuccess() {
            // Update data
            for item in model.getRecord() {
                let code = item
                code.data.append(ConfigBean(id: DomainConst.BLANK, name: item.name.removeSign().lowercased()))
                G06F01S04._CCSCodeList.append(code)
            }
            _pkrCCSCode.setData(data: G06F01S04._CCSCodeList)
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle text field name did change event
     * - parameter textField: Textfield
     */
    func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case _tbxSerial:
            G06F01S04._selectedValue.serial = textField.text!
        case _tbxBrand:
            G06F01S04._selectedValue.brand = textField.text!
        case _tbxCompetitor:
            G06F01S04._selectedValue.competitor = textField.text!
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        case _tbxCCSCode:
            G06F01S04._selectedValue.ccsCode = textField.text!
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        default:
            break
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            hideKeyboard()
        }
        return true
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.endEditing(true)
        _isKeyboardShow = false
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if _isKeyboardShow == false {
            _isKeyboardShow = true
        }
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
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if _pkrCCSCode.getSelectedValue().isBlank {
            G06F01S04._selectedValue.ccsCode = _pkrCCSCode.getTextValue()
        } else {
            G06F01S04._selectedValue.ccsCode = _pkrCCSCode.getSelectedValue()
        }
        return true
    }
    
    /**
     * Handle when change address value
     */
    func valueChanged(_ sender: AnyObject) {
        if (sender as! AddressPickerView) == _pkrCCSCode {
            G06F01S04._selectedValue.ccsCode = _pkrCCSCode.getSelectedValue()
            return
        }
        G06F01S04._selectedValue.timeUse
            = ConfigBean(id: _pkrTimeUse.getSelectedID(),
                         name: _pkrTimeUse.getSelectedValue())
    }
}
