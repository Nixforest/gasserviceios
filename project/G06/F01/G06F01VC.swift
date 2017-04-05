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

    // MARK: Method
    
    /**
     * Tells the delegate that new location data is available.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
                let model = (pm.locality ?? DomainConst.BLANK,
                             pm.subAdministrativeArea ?? DomainConst.BLANK,
                             pm.subLocality ?? DomainConst.BLANK,
                             pm.thoroughfare ?? DomainConst.BLANK,
                             pm.subThoroughfare ?? DomainConst.BLANK)
                self.updateData(name: G06F01S03.theClassName, model: model as AnyObject)
            }
            
        })
//        GMSGeocoder().reverseGeocodeCoordinate(G06F01VC._currentPos, completionHandler: { (response, error) in
//            if error != nil {
//                return
//            }
//            // Get address
//            let gmsAddress: GMSAddress = response!.firstResult()!
//            
//            let address = response?.firstResult()?.lines?.joined(separator: DomainConst.ADDRESS_SPLITER)
//            G06F01S03._address = address!
//            //self.updateData(name: G06F01S03.theClassName)
//            let model = (gmsAddress.locality, gmsAddress.subLocality, gmsAddress.administrativeArea, gmsAddress.thoroughfare)
//            self.updateData(name: G06F01S03.theClassName, model: model as AnyObject)
//        })
    }
    
    override func viewDidLoad() {
        _location.requestAlwaysAuthorization()
        _location.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            _location.delegate = self
            _location.desiredAccuracy = kCLLocationAccuracyKilometer
            //_location.startUpdatingLocation()
            _location.startMonitoringSignificantLocationChanges()
        }
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        let step1 = G06F01S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G06F01S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step3 = G06F01S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let summary = G06F01Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        step3.stepDoneDelegate = self
        self.appendContent(stepContent: step3)
        appendSummary(summary: summary)
        // Set title
        self.setTitle(title: DomainConst.CONTENT00122)
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
    
    internal func requestProvincesListFinish(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = ProvincesListRespModel(jsonString: dataStr)
        if model.isSuccess() {
            BaseModel.shared.setListProvinces(data: model.getRecord())
        }
        updateData(name: G06F01S03.theClassName)
    }
    
    public func requestDistrictsListFinish(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = DistrictsListRespModel(jsonString: dataStr)
        if model.isSuccess() {
            BaseModel.shared.setListDistricts(provinceId: G06F01S03._provinceId, data: model.getRecord())
        }
        updateData(name: G06F01S03.theClassName)
    }
    
    public func requestWardsListFinish(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = WardsListRespModel(jsonString: dataStr)
        if model.isSuccess() {
            BaseModel.shared.setListWards(districtId: G06F01S03._districtId, data: model.getRecord())
        }
        updateData(name: G06F01S03.theClassName)
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
     * Update data in step content
     * - parameter name: Name of notification
     */
    private func updateData(name: String) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil)
    }
    private func updateData(name: String, model: AnyObject) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: model)
    }
}
