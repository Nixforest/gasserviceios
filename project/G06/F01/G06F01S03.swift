 //
//  G06F01S03.swift
//  project
//
//  Created by SPJ on 4/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F01S03: StepContent, AddressPickerViewDelegate {
    /** Full address */
    public static var _address:         String = DomainConst.BLANK
    /** Province Id */
    public static var _provinceId:      String = DomainConst.BLANK
    /** District Id */
    public static var _districtId:      String = DomainConst.BLANK
    /** Ward Id */
    public static var _wardId:          String = DomainConst.BLANK
    /** Street Id */
    public static var _streetId:        String = DomainConst.BLANK
    /** House number */
    public static var _houseNumber:     String = DomainConst.BLANK
    /** Name textfield */
    private var _tbxName:               UITextField = UITextField()
    /** Province Picker */
    private var _pkrProvince:           AddressPickerView = AddressPickerView()
    /** District Picker */
    private var _pkrDistrict:           AddressPickerView = AddressPickerView()
    /** Ward Picker */
    private var _pkrWard:               AddressPickerView = AddressPickerView()
    /** Street Picker */
    private var _pkrStreet:             AddressPickerView = AddressPickerView()
    /** House number */
    private var _pkrHouseNum:           AddressPickerView = AddressPickerView()
    let contentView     = UIView()
    private var fullAddress:            FullAddressPicker = FullAddressPicker()

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
        var offset: CGFloat = GlobalConst.MARGIN
        contentView.translatesAutoresizingMaskIntoConstraints = true
        fullAddress.setup()
        offset += fullAddress.frame.height
        contentView.addSubview(fullAddress)
        // Province control
//        offset = addAddressControl(control: _pkrProvince, offset: offset,
//                                   label: DomainConst.CONTENT00298,
//                                   data: BaseModel.shared.getListProvinces())
//        // District control
//        offset = addAddressControl(control: _pkrDistrict, offset: offset,
//                                   label: DomainConst.CONTENT00299,
//                                   data: [ConfigBean]())
//        // Ward control
//        offset = addAddressControl(control: _pkrWard, offset: offset,
//                                   label: DomainConst.CONTENT00300,
//                                   data: [ConfigBean]())
//        // Street control
//        offset = addAddressControl(control: _pkrStreet, offset: offset,
//                                   label: DomainConst.CONTENT00058,
//                                   data: BaseModel.shared.getListStreets())
//        _pkrHouseNum.setup(frame: CGRect(x: 0, y: offset,
//                                    width: GlobalConst.SCREEN_WIDTH,
//                                    height: GlobalConst.BUTTON_H),
//                      lbl: DomainConst.CONTENT00057,
//                      data: [ConfigBean](), isPicker: false)
//        _pkrHouseNum.delegate = self
//        contentView.addSubview(_pkrHouseNum)
//        offset += GlobalConst.BUTTON_H
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00301,
                   contentHeight: offset,
                   width: w, height: h)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name:NSNotification.Name(rawValue: G06F01S03.theClassName),
                                               object: nil)
        return
    }
    
    /**
     * Add address control to view
     * - parameter control: Control to add
     * - parameter offset:  Y offset
     * - parameter label:   Label of control
     * - parameter data:    Data
     * - returns: Offset after add control
     */
    private func addAddressControl(control: AddressPickerView, offset: CGFloat,
                                   label: String, data: [ConfigBean]) -> CGFloat {
        control.setup(frame: CGRect(x: 0, y: offset,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: GlobalConst.BUTTON_H),
                      lbl: label,
                      data: data)
        control.delegate = self
        contentView.addSubview(control)
        return (offset + GlobalConst.BUTTON_H)
    }
    
    /**
     * Update data for this view
     */
    internal func updateData(_ notification: Notification) {
        // Address
        //_tbxName.text = G06F01S03._address
        self._pkrProvince.setData(data: BaseModel.shared.getListProvinces())
        if let data = BaseModel.shared.getListDistricts(provinceId: G06F01S03._provinceId) {
            self._pkrDistrict.setData(data: data)
        }
        if let data = BaseModel.shared.getListWards(districtId: G06F01S03._districtId) {
            self._pkrWard.setData(data: data)
        }
        if notification.object != nil {
            let model: (String, String, String, String, String) = (notification.object as!
                (String, String, String, String, String))
            var bool = false
            bool = _pkrProvince.setValue(value: model.0.normalizeProvinceStr(), isRemoveSign: true)
            if bool {
                valueChanged(_pkrProvince)
            }
            bool = _pkrDistrict.setValue(value: model.1.normalizeDistrictStr())
            if bool {
                valueChanged(_pkrDistrict)
            }
            bool = _pkrWard.setValue(value: model.2.normalizeWardStr())
            if bool {
                valueChanged(_pkrWard)
            }
            bool = _pkrStreet.setValue(value: model.3.normalizeStreetStr(), isRemoveSign: true)
            if bool {
                valueChanged(_pkrStreet)
            }
            bool = _pkrHouseNum.setValue(value: model.4)
            if bool {
                valueChanged(_pkrHouseNum)
            }
        }
        let addressList = [_pkrHouseNum.getSelectedValue(),
                           _pkrStreet.getSelectedValue(),
                           _pkrWard.getSelectedValue(),
                           _pkrDistrict.getSelectedValue(),
                           _pkrProvince.getSelectedValue()]
        G06F01S03._address = addressList.joined(separator: DomainConst.ADDRESS_SPLITER_WITH_SPACE)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        G06F01S03._address = fullAddress.getData().getFullAddress()
        return true
    }
    
    /**
     * Handle when change address value
     */
    func valueChanged(_ sender: AnyObject) {
        if (sender as! AddressPickerView) == _pkrProvince {
            G06F01S03._provinceId = _pkrProvince.getSelectedID()
            DistrictsListRequest.request(action: #selector(G06F01VC.requestDistrictsListFinish(_:)),
                                         view: getParentView(),
                                         provinceId: G06F01S03._provinceId)
        } else if ((sender as! AddressPickerView) == _pkrDistrict) {
            G06F01S03._districtId = _pkrDistrict.getSelectedID()
            WardsListRequest.request(action: #selector(G06F01VC.requestWardsListFinish(_:)),
                                         view: getParentView(),
                                         provinceId: G06F01S03._provinceId,
                                         districtId: G06F01S03._districtId)
        }  else {
            //NotificationCenter.default.post(name: Notification.Name(rawValue: self.theClassName), object: nil)
            if ((sender as! AddressPickerView) == _pkrWard) {
                G06F01S03._wardId = _pkrWard.getSelectedID()
            } else  if ((sender as! AddressPickerView) == _pkrStreet) {
                G06F01S03._streetId = _pkrStreet.getSelectedID()
            } else {
                G06F01S03._houseNumber = _pkrHouseNum.getSelectedID()
            }
        }
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.endEditing(true)
        self.contentView.endEditing(true)
    }
    
    /**
     * Tells the responder when one or more fingers touch down in a view or window.
     */
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
}
