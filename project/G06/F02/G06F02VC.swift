//
//  G06F02VC.swift
//  project
//
//  Created by SPJ on 4/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework
import GoogleMaps

class G06F02VC: StepVC, StepDoneDelegate, CLLocationManagerDelegate {
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
        //++ BUG0059-SPJ (NguyenPT 20170420) Check if user move with distance > 100m
        if manager.location != nil {
            let position = CLLocation(latitude: G06F02VC._currentPos.latitude, longitude: G06F02VC._currentPos.longitude)
            let distance: CLLocationDistance = manager.location!.distance(from: position)
            if distance / 100 < 1 {
                return
            }
        }
        //-- BUG0059-SPJ (NguyenPT 20170420) Check if user move with distance > 100m
        G06F02VC._currentPos = (manager.location?.coordinate)!
    }

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
        let step1 = G06F02S01(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        let step2 = G06F02S02(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        
        //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
        let step3 = G06F02S03(w: GlobalConst.SCREEN_WIDTH,
                              h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
        
        let summary = G06F02Sum(w: GlobalConst.SCREEN_WIDTH,
                                h: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.SCROLL_BUTTON_LIST_HEIGHT), parent: self)
        step1.stepDoneDelegate = self
        self.appendContent(stepContent: step1)
        //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
        step3.stepDoneDelegate = self
        self.appendContent(stepContent: step3)
        //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
        step2.stepDoneDelegate = self
        self.appendContent(stepContent: step2)
        appendSummary(summary: summary)
        // Set title
        self.setTitle(title: DomainConst.CONTENT00307)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        G06F02S01._selectedValue = DomainConst.BLANK
        G06F02S02._selectedValue.removeAll()
        //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        G06F02VC._currentPos = CLLocationCoordinate2D.init()
        //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
        //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
        G06F02S03._target        = CustomerBean.init()
        //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
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
     * Handle send button tapped
     */
    override func btnSendTapped() {
        WorkingReportCreateRequest.request(
            action: #selector(finishRequestCreateWorkingReport(_:)),
            view: self,
            content: G06F02S01._selectedValue,
            longitude: String(G06F02VC._currentPos.latitude),
            latitude: String(G06F02VC._currentPos.longitude),
            version_code: DomainConst.VERSION_CODE_STR,
            listImage: G06F02S02._selectedValue,
            //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
            user_id: G06F02S03._target.id)
            //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
    }
    
    /**
     * Finish request create working report
     * - parameter notification: Notification object
     */
    internal func finishRequestCreateWorkingReport(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerFamilyCreateRespModel(jsonString: data)
        if model.isSuccess() {
            //++ BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
            // Clear data at steps
            self.clearData()
            //-- BUG0179-SPJ (NguyenPT 20171217) Fix bug clear data
            self.showAlert(message: model.message,
                           okHandler: {
                            (alert: UIAlertAction!) in
                            self.backButtonTapped(self)
            })
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
}
