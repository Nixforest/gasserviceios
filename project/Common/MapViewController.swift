//
//  MapViewController.swift
//  project
//
//  Created by SPJ on 1/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework
import GoogleMaps
import GooglePlaces

class MapViewController: BaseViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate {
    /** Top view */
    private var _topView            = UIView()
    /** Address textfield */
    private var _txtAddress         = UITextField()
    /** Bottom view */
    private var _bottomView         = UIView()
    /** Order button */
    private var _btnOrder           = UIButton()
    /** Material selector view */
    private var _materialSelect     = UIView()
    /** Type view */
    private var _categoryView       = UIView()
    /** List of category button */
    private var _listButton         = [UIButton]()
    /** Manager location */
    private let _location           =  CLLocationManager()
    /** Center mark */
    private var _centerMark         = UIImageView()
    /** Agent information */
    private static var _agentInfo   = [AgentInfoBean]()
    /** Map view */
    private var _mapView: GMSMapView?            = nil
    /**  */
    private var _isShowChildren = true
    public let _zoomValue: CGFloat  = 15.0
    
    /***/
    public func saveAgentInfo(data: [AgentInfoBean]) {
        MapViewController._agentInfo.append(contentsOf: data)
    }
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _location.requestAlwaysAuthorization()
        _location.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            _location.delegate = self
            _location.desiredAccuracy = kCLLocationAccuracyKilometer
            //_location.startUpdatingLocation()
            _location.startMonitoringSignificantLocationChanges()
        }
        
        var offset = getTopHeight()
        offset = setupTopView(offset: offset)
        setupCenterMark()
        setupBottomView()
        
//        let gesture = UITapGestureRecognizer(target: mapView, action: #selector(showChildren(_:)))
//        mapView.addGestureRecognizer(gesture)
        
        // NavBar setup
        setupNavigationBar(title: DomainConst.CONTENT00226, isNotifyEnable: BaseModel.shared.checkIsLogin(), isHiddenBackBtn: true)
        
        // Notify set data
        NotificationCenter.default.addObserver(self, selector: #selector(setData(_:)), name:NSNotification.Name(rawValue: G04Const.NOTIFY_NAME_G04_ADDRESS_VIEW_SET_DATA), object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(updateNotificationStatus(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_UPDATE_NOTIFY_HOMEVIEW), object: nil)
        //        // Get data from server
        //        if BaseModel.shared.checkIsLogin() {
        //            RequestAPI.requestUpdateConfiguration(view: self)
        //        }
        //
        //        // Handle waiting register code confirm
        //        if !BaseModel.shared.getTempToken().isEmpty {
        //            self.processInputConfirmCode(message: "")
        //        }
    }
    
    override func setData(_ notification: Notification) {
        for item in MapViewController._agentInfo {
            createMarker(info: item.info_agent)
        }
    }
    
    /**
     * Create all agent marker from agent information
     * - parameter info: Basic agent information
     */
    func createMarker(info: BaseAgentInfoBean) {
        let marker = GMSMarker()
        // Set icon
        marker.icon = ImageManager.getImage(named: DomainConst.LOGO_AGENT_IMG_NAME)
        // Get lat and long value from agent information
        let lat: CLLocationDegrees = (info.agent_latitude as NSString).doubleValue
        let long: CLLocationDegrees = (info.agent_longitude as NSString).doubleValue
        // Set marker position
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = info.agent_name
        marker.snippet = info.agent_address
        //marker.appearAnimation = kGMSMarkerAnimationPop
        //marker.infoWindowAnchor = CGPoint(x: 0.44, y: 0.45)
        // Insert marker into map view
        marker.map = self._mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue = manager.location?.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: (locValue?.latitude)!, longitude: (locValue?.longitude)!, zoom: Float(self._zoomValue))
        _mapView = GMSMapView.map(withFrame: CGRect(x: 0,
                                                       y: self.getTopHeight(),
                                                       width:GlobalConst.SCREEN_WIDTH,
                                                       height:GlobalConst.SCREEN_HEIGHT - self.getTopHeight()),
                                     camera: camera)
        _mapView?.settings.compassButton    = true
        _mapView?.isMyLocationEnabled       = true
        _mapView?.settings.myLocationButton = true
        _mapView?.delegate                  = self
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = locValue!
        marker.title = "Công ty Cổ Phần Dầu Khí Miền Nam"
        marker.snippet = "86 Nguyễn Cửu Vân - Bình Thạnh - TP HCM"
        //marker.map = mapView
        self.view.insertSubview(_mapView!, at: 0)
        OrderConfigRequest.requestOrderConfig(view: self)
    }
    
    func showHideChildrent(isHide: Bool) {
        _isShowChildren = isHide
        showChildren()
    }
    
    /**
     * Hide keyboard
     */
    func showChildren() {
        self.view.endEditing(true)
        if _isShowChildren {
            // Hide
            UIView.animate(withDuration: 0.3, animations: {
                self._topView.frame = CGRect(x: self._topView.frame.origin.x,
                                             y: self._topView.frame.origin.y - self._topView.frame.height,
                                             width: self._topView.frame.width,
                                             height: self._topView.frame.height)
                self._bottomView.frame = CGRect(x: self._bottomView.frame.origin.x,
                                                y: self._bottomView.frame.origin.y + self._bottomView.frame.height, width: self._bottomView.frame.width,
                                                height: self._bottomView.frame.height)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self._topView.frame = CGRect(x: self._topView.frame.origin.x,
                                             y: self._topView.frame.origin.y + self._topView.frame.height,
                                             width: self._topView.frame.width,
                                             height: self._topView.frame.height)
                self._bottomView.frame = CGRect(x: self._bottomView.frame.origin.x,
                                                y: self._bottomView.frame.origin.y - self._bottomView.frame.height, width: self._bottomView.frame.width,
                                                height: self._bottomView.frame.height)
            })
        }
        _isShowChildren =  !_isShowChildren
    }
    
    /**
     * Setup all components of top view
     * - parameter offset: Input offset
     * - returns: Output offset
     */
    func setupTopView(offset: CGFloat) -> CGFloat {
        // Address textfield
        _txtAddress.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                   y: GlobalConst.MARGIN,
                                   width: GlobalConst.BUTTON_W,
                                   height: GlobalConst.BUTTON_H)
        _txtAddress.placeholder         = DomainConst.BLANK
        _txtAddress.layer.cornerRadius  = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        _txtAddress.backgroundColor     = UIColor.white
        _txtAddress.font                = UIFont.systemFont(ofSize: GlobalConst.SMALL_FONT_SIZE)
        _txtAddress.delegate            = self
        setLeftViewForTextField(textField: _txtAddress, named: DomainConst.ADDRESS_IMG_NAME)
        
        // Top view
        self._topView.frame = CGRect(x: 0, y: offset,
                                     width: GlobalConst.SCREEN_WIDTH,
                                     height: GlobalConst.MARGIN * 2 + GlobalConst.EDITTEXT_H)
        self._topView.backgroundColor = UIColor(white: 0, alpha: 0.0)
        self._topView.addSubview(_txtAddress)
        
        self.view.addSubview(_topView)
        return offset
    }
    
    func setupCenterMark() {
        self._centerMark.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.CENTER_MARKER_SIZE_WIDTH) / 2,
                                        y: (GlobalConst.SCREEN_HEIGHT - getTopHeight() - GlobalConst.CENTER_MARKER_SIZE_HEIGHT) / 2 + getTopHeight() - GlobalConst.MARGIN,
                                        width: GlobalConst.CENTER_MARKER_SIZE_WIDTH,
                                        
                                        height: GlobalConst.CENTER_MARKER_SIZE_HEIGHT)
        self._centerMark.image = ImageManager.getImage(named: DomainConst.CENTER_MARKER_IMG_NAME)
        self._centerMark.contentMode = .scaleAspectFit
        self.view.addSubview(self._centerMark)
    }
    
    func setupBottomView() {
        let img = ImageManager.getImage(named: DomainConst.ORDER_START_ICON_IMG_NAME)
        let tintedImg = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self._btnOrder.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                      y: 0,
                                      width: GlobalConst.BUTTON_W,
                                      height: GlobalConst.BUTTON_H)
        self._btnOrder.setTitle(DomainConst.CONTENT00236.uppercased(), for: UIControlState())
        self._btnOrder.setTitleColor(UIColor.white, for: UIControlState())
        self._btnOrder.backgroundColor = GlobalConst.MAIN_COLOR
        self._btnOrder.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._btnOrder.addTarget(self, action: #selector(btnOrderTapped), for: .touchUpInside)
        self._btnOrder.tintColor = UIColor.white
        self._btnOrder.setImage(tintedImg, for: UIControlState())
        self._btnOrder.imageView?.contentMode = .scaleAspectFit
        self._btnOrder.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN_CELL_X,
                                                      left: GlobalConst.MARGIN_CELL_X,
                                                      bottom: GlobalConst.MARGIN_CELL_X,
                                                      right: GlobalConst.MARGIN_CELL_X)
        setupMaterialSelector()
        setupCategoryView()
        // Bottom view
        let btmHeight = GlobalConst.BUTTON_CATEGORY_SIZE * 2.5 + GlobalConst.BUTTON_H + GlobalConst.MARGIN + GlobalConst.MARGIN_CELL_X * 2
        self._bottomView.frame = CGRect(x: 0,
                                        y: GlobalConst.SCREEN_HEIGHT - btmHeight,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: btmHeight)
        self._bottomView.backgroundColor = UIColor(white: 0, alpha: 0.0)
        self._bottomView.addSubview(_btnOrder)
        self._bottomView.addSubview(_materialSelect)
        self._bottomView.addSubview(_categoryView)
        self.view.addSubview(_bottomView)
    }
    
    func btnOrderTapped(_ sender: AnyObject) {
        
    }
    
    /**
     * Setup material selector and its components
     */
    func setupMaterialSelector() {
        let gas = MaterialSelector(iconPath: DomainConst.CATEGORY_VIP_IMG_NAME,
                                   name: "Gas Origin xám 12",
                                   price: "328,000",
                                   width: (GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN) / 2,
                                   height: GlobalConst.BUTTON_CATEGORY_SIZE * 1.5)
        gas.frame = CGRect(x: GlobalConst.MARGIN,
                           y: 0,
                           width: (GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN) / 2,
                           height: GlobalConst.BUTTON_CATEGORY_SIZE * 1.5)
        self._materialSelect.addSubview(gas)
        
        let promote = MaterialSelector(iconPath: DomainConst.CATEGORY_VIP_IMG_NAME,
                                       name: "Chọn quà tặng",
                                       price: "",
                                       width: GlobalConst.SCREEN_WIDTH / 2 - GlobalConst.MARGIN ,
                                       height: GlobalConst.BUTTON_CATEGORY_SIZE * 1.5)
        promote.frame = CGRect(x: GlobalConst.SCREEN_WIDTH / 2,
                               y: 0,
                               width: (GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN) / 2,
                               height: GlobalConst.BUTTON_CATEGORY_SIZE * 1.5)
        self._materialSelect.addSubview(promote)
        
        self._materialSelect.frame = CGRect(x: GlobalConst.MARGIN,
                                            y: GlobalConst.BUTTON_H + GlobalConst.MARGIN,
                                            width: GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN * 2,
                                            height: GlobalConst.BUTTON_CATEGORY_SIZE * 1.5)
        self._materialSelect.backgroundColor = UIColor.white
    }
    
    /**
     * Setup category view and its components.
     */
    func setupCategoryView() {
        // Attemp list config
        var listConfig = [ConfigBean]()
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_VIP, name: "VIP"))
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_GAS, name: "GAS"))
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_UTILITY, name: "PHỤ KIỆN"))
        // Attemp list image
        var listImg = [(String, String)]()
        listImg.append((DomainConst.CATEGORY_VIP_IMG_NAME, DomainConst.CATEGORY_VIP_ACTIVE_IMG_NAME))
        listImg.append((DomainConst.CATEGORY_GAS_IMG_NAME, DomainConst.CATEGORY_GAS_ACTIVE_IMG_NAME))
        listImg.append((DomainConst.CATEGORY_UTILITY_IMG_NAME, DomainConst.CATEGORY_UTILITY_ACTIVE_IMG_NAME))
        // Calculate size
        let btnWidth    = GlobalConst.BUTTON_CATEGORY_SIZE
        let margin      = GlobalConst.MARGIN
        let count       = listConfig.count
        let btnSpace    = (GlobalConst.SCREEN_WIDTH - 2 * margin - btnWidth) / (CGFloat)(count - 1)
        for i in 0..<listConfig.count {
            // Calculate frame of button
            let frame = CGRect(x: margin + CGFloat(i) * btnSpace, y: margin / 2,
                               width: btnWidth,
                               height: btnWidth)
            let btn = CategoryButton(frame: frame, icon: listImg[i].0, iconActive: listImg[i].1, title: listConfig[i].name, id: listConfig[i].id)
            
            btn.addTarget(self, action: #selector(enableButton), for: .touchUpInside)
            // Select default button
            if listConfig[i].id == DomainConst.CATEGORY_TYPE_GAS {
                btn.isSelected = true
            }
            _listButton.append(btn)
            self._categoryView.addSubview(btn)
        }
        // Set size of category view
        self._categoryView.frame = CGRect(x: 0,
                                          y: _materialSelect.frame.maxY + GlobalConst.MARGIN_CELL_X,
                                          width: GlobalConst.SCREEN_WIDTH,
                                          height: btnWidth + GlobalConst.MARGIN_CELL_X)
        self._categoryView.backgroundColor = UIColor.white
    }
    
    /**
     * Handle when tap on category buttons
     * - parameter sender: Button object
     */
    func enableButton(_ sender: AnyObject) {
        // Handle by button identify
        switch ((sender as! UIButton).accessibilityIdentifier!) {
        case DomainConst.CATEGORY_TYPE_VIP, DomainConst.CATEGORY_TYPE_UTILITY:
            showAlert(message: DomainConst.CONTENT00197)
            return
        case DomainConst.CATEGORY_TYPE_GAS:
            break
        default:
            break
        }
        // Release selection from all button
        for btn in self._listButton {
            btn.isSelected = false
        }
        // Select current tapped button
        (sender as! UIButton).isSelected = true
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
        let img             = ImageManager.getImage(named: named)
        imgView.image       = img
        textField.leftView  = imgView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let center = position.target
        GMSGeocoder().reverseGeocodeCoordinate(center) { (response, error) in
            if error != nil {
                return
            }
            
            var address = response?.firstResult()?.lines?.joined(separator: ",")
            address = address?.appendingFormat(", %@", (response?.firstResult()?.country)!)
            self._txtAddress.text = address
        }
        if !self._isShowChildren {
            self.showHideChildrent(isHide: false)
        }
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        print("didChange: " + "\(position)")
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print("willMove: " + "\(gesture)")
        if self._isShowChildren {
            self.showHideChildrent(isHide: true)
        }
    }
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        let autocompleteController      = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    public func setAddressText(address: String) {
        self._txtAddress.text = address
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    public func moveCamera(position: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude: position.latitude, longitude: position.longitude, zoom: Float(self._zoomValue))
        let bounds = GMSCoordinateBounds.init()
        bounds.includingCoordinate(position)
        self._mapView?.camera = camera
    }
}
extension MapViewController: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        self.setAddressText(address: place.formattedAddress!)
        
        self.moveCamera(position: place.coordinate)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
