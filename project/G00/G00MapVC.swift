//
//  G00MapVC.swift
//  project
//
//  Created by SPJ on 1/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework
import GoogleMaps

class G00MapVC: BaseViewController {
    /** Top view */
    private var _topView    = UIView()
    /** Address textfield */
    private var _txtAddress = UITextField()
    /** Bottom view */
    private var _bottomView = UIView()
    /** Order button */
    private var _btnOrder           = UIButton()
    /** Material selector view */
    private var _materialSelect     = UIView()
    /** Type view */
    private var _categoryView       = UIView()
    /** List of category button */
    private var _listButton         = [UIButton]()
    
    private var _isShowChildren = true
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let lat: CLLocationDegrees = 10.7964088
        let long: CLLocationDegrees = 106.705768
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0,
                                                       y: self.getTopHeight(),
                                                       width:GlobalConst.SCREEN_WIDTH,
                                                       height:GlobalConst.SCREEN_HEIGHT - self.getTopHeight()),
                                     camera: camera)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "Công ty Cổ Phần Dầu Khí Miền Nam"
        marker.snippet = "86 Nguyễn Cửu Vân - Bình Thạnh - TP HCM"
        marker.map = mapView
        self.view.addSubview(mapView)
        var offset = getTopHeight()
        offset = setupTopView(offset: offset)
        setupBottomView()
        
        let gesture = UITapGestureRecognizer(target: mapView, action: #selector(showChildren(_:)))
        mapView.addGestureRecognizer(gesture)
        
        // NavBar setup
//        setupNavigationBar(title: DomainConst.CONTENT00108, isNotifyEnable: BaseModel.shared.checkIsLogin(), isHiddenBackBtn: true)
//        
//        // Notify set data
//        NotificationCenter.default.addObserver(self, selector: #selector(G00HomeVC.setData(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_HOMEVIEW), object: nil)
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
    
    
    
    /**
     * Hide keyboard
     */
    func showChildren(_ sender:UITapGestureRecognizer) {
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
        _txtAddress.placeholder = "Nhập địa chỉ"
        _txtAddress.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        _txtAddress.backgroundColor = UIColor.white
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
    
    func setupBottomView() {
        self._btnOrder.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                      y: 0,
                                      width: GlobalConst.BUTTON_W,
                                      height: GlobalConst.BUTTON_H)
        self._btnOrder.setTitle("MUA HÀNG", for: UIControlState())
        self._btnOrder.setTitleColor(UIColor.white, for: UIControlState())
        self._btnOrder.backgroundColor = GlobalConst.MAIN_COLOR
        self._btnOrder.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._btnOrder.addTarget(self, action: #selector(btnOrderTapped), for: .touchUpInside)
        setupMaterialSelector()
        setupCategoryView()
        // Bottom view
        let btmHeight = GlobalConst.BUTTON_CATEGORY_SIZE * 2.5 + GlobalConst.BUTTON_H + GlobalConst.MARGIN
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
                                   width: (GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN) / 2,
                                   height: GlobalConst.BUTTON_CATEGORY_SIZE * 1.5)
        promote.frame = CGRect(x: GlobalConst.SCREEN_WIDTH / 2,
                               y: 0,
                               width: (GlobalConst.SCREEN_WIDTH - GlobalConst.MARGIN) / 2,
                               height: GlobalConst.BUTTON_CATEGORY_SIZE * 1.5)
        self._materialSelect.addSubview(promote)
        
        self._materialSelect.frame = CGRect(x: 0,
                                            y: GlobalConst.BUTTON_H + GlobalConst.MARGIN,
                                            width: GlobalConst.SCREEN_WIDTH,
                                            height: GlobalConst.BUTTON_CATEGORY_SIZE * 1.5)
        self._materialSelect.backgroundColor = UIColor.white
    }
    
    func setupCategoryView() {
        // Attemp list config
        var listConfig = [ConfigBean]()
        listConfig.append(ConfigBean(id: "1", name: "VIP"))
        listConfig.append(ConfigBean(id: "2", name: "GAS"))
        listConfig.append(ConfigBean(id: "3", name: "PHỤ KIỆN"))
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
            var frame = CGRect(x: margin + CGFloat(i) * btnSpace, y: margin / 2,
                                  width: btnWidth,
                                  height: btnWidth)
            let btn = CategoryButton(frame: frame, icon: listImg[i].0, iconActive: listImg[i].1, title: listConfig[i].name, id: listConfig[i].id)
            
            btn.addTarget(self, action: #selector(enableButton), for: .touchUpInside)
            _listButton.append(btn)
            self._categoryView.addSubview(btn)
        }
        self._categoryView.frame = CGRect(x: 0,
                                          y: _materialSelect.frame.maxY,
                                          width: GlobalConst.SCREEN_WIDTH,
                                          height: btnWidth)
        self._categoryView.backgroundColor = UIColor.white
    }
    
    func enableButton(_ sender: AnyObject) {
        for btn in self._listButton {
            btn.isSelected = false
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
