//
//  G06F01VC.swift
//  project
//
//  Created by SPJ on 3/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework
import GoogleMaps

class G06F01VC: StepVC, StepDoneDelegate, CLLocationManagerDelegate {
    // MARK: Properties
    /** Manager location */
    private let _location               =  CLLocationManager()
    /** Current position of map view */
    public static var _currentPos       = CLLocationCoordinate2D.init()
    //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
    /** Full address */
    public static var _fullAddress:     FullAddressBean = FullAddressBean()
    /** Mode: 0 - Create, 1 - Update */
    public static var _mode:        String  = DomainConst.NUMBER_ZERO_VALUE
    /** Id of store card updating */
    public static var _id:          String = DomainConst.BLANK
    //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code

    // MARK: Method
    /**
     * Tells the delegate that new location data is available.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //++ BUG0059-SPJ (NguyenPT 20170420) Check if user move with distance > 100m
        if manager.location != nil {
            let position = CLLocation(latitude: G06F01VC._currentPos.latitude, longitude: G06F01VC._currentPos.longitude)
            let distance: CLLocationDistance = manager.location!.distance(from: position)
            if distance / 100 < 1 {
                return
            }
        }
        //-- BUG0059-SPJ (NguyenPT 20170420) Check if user move with distance > 100m
        G06F01VC._currentPos = (manager.location?.coordinate)!
        let loca: CLLocation = manager.location!
        CLGeocoder().reverseGeocodeLocation(loca, completionHandler: {
            (placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            let placeList: [CLPlacemark] = placemarks!
            if placeList.count > 0 {
                let pm = placeList[0]
                print("---------------")
                print(pm.locality ?? DomainConst.BLANK)                 // City
                print(pm.subAdministrativeArea ?? DomainConst.BLANK)    // District
                print(pm.subLocality ?? DomainConst.BLANK)              // Ward
                print(pm.thoroughfare ?? DomainConst.BLANK)             // Street
                print(pm.subThoroughfare ?? DomainConst.BLANK)          // Detail
//                let model = (pm.locality ?? DomainConst.BLANK,
//                             pm.subAdministrativeArea ?? DomainConst.BLANK,
//                             pm.subLocality ?? DomainConst.BLANK,
//                             pm.thoroughfare ?? DomainConst.BLANK,
//                             pm.subThoroughfare ?? DomainConst.BLANK)
                //self.updateData(name: G06F01S03.theClassName, model: model as AnyObject)
            }
            
        })
    }
    
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        //++ BUG0059-SPJ (NguyenPT 20170420) Use location service when app is openned, not background
        //_location.requestAlwaysAuthorization()
        //-- BUG0059-SPJ (NguyenPT 20170420) Use location service when app is openned, not background
        _location.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            _location.delegate = self
            _location.desiredAccuracy = kCLLocationAccuracyKilometer
            //++ BUG0059-SPJ (NguyenPT 20170420) Use location service when app is openned, not background
            _location.startUpdatingLocation()
            //_location.startMonitoringSignificantLocationChanges()
            //-- BUG0059-SPJ (NguyenPT 20170420) Use location service when app is openned, not background
        }
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G06F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G06F01S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step3 = G06F01S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step4 = G06F01S04(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step5 = G06F01S05(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step6 = G06F01S06(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G06F01Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        step3.stepDoneDelegate = self
        self.appendContent(stepContent: step3)
        step4.stepDoneDelegate = self
        self.appendContent(stepContent: step4)
        step5.stepDoneDelegate = self
        self.appendContent(stepContent: step5)
        step6.stepDoneDelegate = self
        self.appendContent(stepContent: step6)
        appendSummary(summary: summary)
        step3.setAddress(address: G06F01VC._fullAddress)
        // Set title
        //self.setTitle(title: DomainConst.CONTENT00122)
        if G06F01VC._mode == DomainConst.NUMBER_ZERO_VALUE {
            self.setTitle(title: DomainConst.CONTENT00122)
        } else {
            self.setTitle(title: DomainConst.CONTENT00154)
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Request server
        if BaseModel.shared.getListProvinces().count == 0 {
            ProvincesListRequest.request(action: #selector(requestProvincesListFinish(_:)),
                                         view: self)
        } else {
            updateData(name: G06F01S03.theClassName)
        }
    }
    
    /**
     * Finish request list provinces
     * - parameter notification: Notification object
     */
    internal func requestProvincesListFinish(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = ProvincesListRespModel(jsonString: dataStr)
        if model.isSuccess() {
            BaseModel.shared.setListProvinces(data: model.getRecord())
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
        updateData(name: G06F01S03.theClassName)
    }
    
    /**
     * Finish request list districts
     * - parameter notification: Notification object
     */
    public func requestDistrictsListFinish(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = DistrictsListRespModel(jsonString: dataStr)
        if model.isSuccess() {
            BaseModel.shared.setListDistricts(provinceId: G06F01S03._provinceId, data: model.getRecord())
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
        updateData(name: G06F01S03.theClassName)
    }
    
    /**
     * Finish request list wards
     * - parameter notification: Notification object
     */
    public func requestWardsListFinish(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = WardsListRespModel(jsonString: dataStr)
        if model.isSuccess() {
            BaseModel.shared.setListWards(districtId: G06F01S03._districtId, data: model.getRecord())
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
        updateData(name: G06F01S03.theClassName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Clear data before close view
     */
    override func clearData() {
        G06F01S01._selectedValue = (DomainConst.BLANK, DomainConst.BLANK)
        G06F01S02._selectedValue = ConfigBean.init()
        G06F01S04._selectedValue = (DomainConst.BLANK, DomainConst.BLANK, DomainConst.BLANK, ConfigBean.init(), DomainConst.BLANK)
        G06F01S06._selectedValue.removeAll()
        G06F01VC._fullAddress = FullAddressBean.init()
        G06F01S03._address = DomainConst.BLANK
        G06F01S05._selectedValue = ConfigBean.init()
        //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        G06F01VC._id = DomainConst.BLANK
        G06F01VC._mode = DomainConst.NUMBER_ZERO_VALUE
        G06F01VC._currentPos    = CLLocationCoordinate2D.init()
        G06F01S03._provinceId   = DomainConst.BLANK
        G06F01S03._districtId   = DomainConst.BLANK
        G06F01S03._wardId       = DomainConst.BLANK
        G06F01S03._streetId     = DomainConst.BLANK
        G06F01S03._houseNumber  = DomainConst.BLANK
        G06F01S04._timeUse.removeAll()
        G06F01S04._CCSCodeList.removeAll()
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
    }
    
    /**
     * Handle send request create uphold
     */
    override func btnSendTapped() {
        // Disable action handle notification from server
//        BaseModel.shared.enableHandleNotificationFlag(isEnabled: false)
        // Create list investment
        var invest: [String] = [String]()
        for item in G06F01S06._selectedValue {
            invest.append(String.init(format: "\"%@\"", item.id))
        }
        
        // Create new
        if G06F01VC._mode == DomainConst.NUMBER_ZERO_VALUE {
        CustomerFamilyCreateRequest.request(
            action:         #selector(finishCreateCustomer(_:)),
            view:           self,
            phone:          G06F01S01._selectedValue.phone,
            customerBrand:  G06F01S04._selectedValue.brand,
            province_id:    G06F01VC._fullAddress.provinceId,
            hgd_type:       G06F01S05._selectedValue.id,
            district_id:    G06F01VC._fullAddress.districtId,
            ward_id:        G06F01VC._fullAddress.wardId,
            agent_id:       G06F01S02._selectedValue.id,
            hgd_time_use:   G06F01S04._selectedValue.timeUse.id,
            //++ BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
            //version_code:   DomainConst.VERSION_CODE_STR,
            //-- BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
            street_id:      G06F01VC._fullAddress.streetId,
            first_name:     G06F01S01._selectedValue.name,
            house_numbers:  G06F01VC._fullAddress.houseNumber,
            list_hgd_invest: invest.joined(separator: DomainConst.ADDRESS_SPLITER),
            longitude:      String(G06F01VC._currentPos.latitude),
            latitude:       String(G06F01VC._currentPos.longitude),
            serial:         G06F01S04._selectedValue.serial,
            hgd_doi_thu:    G06F01S04._selectedValue.competitor,
            ccsCode:        G06F01S04._selectedValue.ccsCode.uppercased())
        } else {    // Update
            CustomerFamilyUpdateRequest.requestCustomerFamilyUpdate(
                action:         #selector(finishCreateCustomer(_:)),
                view: self,
                phone: G06F01S01._selectedValue.phone,
                customerBrand: G06F01S04._selectedValue.brand,
                province_id: G06F01VC._fullAddress.provinceId,
                hgd_type: G06F01S05._selectedValue.id,
                district_id:    G06F01VC._fullAddress.districtId,
                ward_id:        G06F01VC._fullAddress.wardId,
                agent_id:       G06F01S02._selectedValue.id,
                hgd_time_use:   G06F01S04._selectedValue.timeUse.id,
                //++ BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
                //version_code:   DomainConst.VERSION_CODE_STR,
                //-- BUG0119-SPJ (NguyenPT 20170704) Handle update customer in Order Family
                street_id:      G06F01VC._fullAddress.streetId,
                first_name:     G06F01S01._selectedValue.name,
                house_numbers:  G06F01VC._fullAddress.houseNumber,
                list_hgd_invest: invest.joined(separator: DomainConst.ADDRESS_SPLITER),
                longitude:      String(G06F01VC._currentPos.latitude),
                latitude:       String(G06F01VC._currentPos.longitude),
                serial:         G06F01S04._selectedValue.serial,
                hgd_doi_thu:    G06F01S04._selectedValue.competitor,
                customer_id:    G06F01VC._id,
                ccsCode:        G06F01S04._selectedValue.ccsCode.uppercased())
        }
    }
    
    /**
     * Finish create customer
     * - parameter notification: Notification object
     */
    internal func finishCreateCustomer(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerFamilyCreateRespModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            self.clearData()
            self.showAlert(message: model.message,
                           okHandler: {
                            (alert: UIAlertAction!) in
                            //self.backButtonTapped(self)
                            self.pushToView(name: G06F00S01VC.theClassName)
            })
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
}
