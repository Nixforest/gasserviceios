//
//  G06F00S02VC.swift
//  project
//
//  Created by SPJ on 3/29/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F00S02VC: ChildViewController {
    // MARK: Properties
    /** Id */
    public static var _id:          String               = DomainConst.BLANK
    //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
    /** Current data */
    private var _data:              CustomerFamilyViewRespModel      = CustomerFamilyViewRespModel()
    /** Bottom view */
    private var _bottomView:        UIView                      = UIView()
    /** Height of bottom view */
    private var bottomHeight:       CGFloat                     = (GlobalConst.BUTTON_H + GlobalConst.MARGIN)
    /** Update button */
    private var btnUpdate:          UIButton             = UIButton()
    //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code

    override func viewDidLoad() {
        super.viewDidLoad()

        //++ BUG0049-SPJ (NguyenPT 20170622) Handle notification
        if G06F00S02VC._id.isEmpty {
            G06F00S02VC._id = BaseModel.shared.sharedString
        }
        //-- BUG0049-SPJ (NguyenPT 20170622) Handle notification
        
        // Do any additional setup after loading the view.
        // Navigation
        createNavigationBar(title: DomainConst.CONTENT00288)
        
        // Request data from server
        if !G06F00S02VC._id.isEmpty {
            CustomerFamilyViewRequest.request(action: #selector(setData(_:)),
                                              view: self,
                                              customer_id: G06F00S02VC._id)
        }
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        // Bottom view
        _bottomView.frame = CGRect(x: 0, y: GlobalConst.SCREEN_HEIGHT - bottomHeight,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: bottomHeight)
        //_bottomView.isHidden = true
        self.view.addSubview(_bottomView)
        createBottomView()
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Set data after finish request server
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as? String)
        let model = CustomerFamilyViewRespModel(jsonString: data!)
        if model.isSuccess() {
            _data = model
            let offset = getTopHeight() + GlobalConst.MARGIN_CELL_Y
            let detailView: DetailInformationColumnView = DetailInformationColumnView()
            detailView.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                        y: offset,
                                      width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                      height: GlobalConst.SCREEN_HEIGHT - offset - bottomHeight)
            var listValues = [(String, String)]()
            listValues.append((DomainConst.CONTENT00079, model.record.name))
            listValues.append((DomainConst.CONTENT00152, model.record.phone))
            listValues.append((DomainConst.CONTENT00289, model.record.customer_type))
            listValues.append((DomainConst.CONTENT00088, model.record.address))
            listValues.append((DomainConst.CONTENT00290, model.record.latitude_longitude))
            listValues.append((DomainConst.CONTENT00291, model.record.hgd_type))
            listValues.append((DomainConst.CONTENT00292, model.record.hgd_time_use))
            listValues.append((DomainConst.CONTENT00293, model.record.hgd_thuong_hieu))
            listValues.append((DomainConst.CONTENT00294, model.record.hgd_doi_thu))
            listValues.append((DomainConst.CONTENT00109, model.record.serial))
            //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
            listValues.append((DomainConst.CONTENT00445, model.record.ccsCode))
            //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
            listValues.append((DomainConst.CONTENT00163, model.record.list_hgd_invest_text))
            listValues.append((DomainConst.CONTENT00095, model.record.created_by))
            listValues.append((DomainConst.CONTENT00096, model.record.created_date))
            _ = detailView.setData(listValues: listValues)
            self.view.addSubview(detailView)
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
    
    //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
    /**
     * Create bottom view
     */
    private func createBottomView() {
        var botOffset: CGFloat = 0.0
        // Create update button
        CommonProcess.createButtonLayout(
            btn: btnUpdate,
            x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
            y: botOffset,
            text: DomainConst.CONTENT00141,
            action: #selector(btnUpdateTapped(_:)), target: self,
            img: DomainConst.RELOAD_IMG_NAME, tintedColor: UIColor.white)
        
        btnUpdate.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                 left: GlobalConst.MARGIN,
                                                 bottom: GlobalConst.MARGIN,
                                                 right: GlobalConst.MARGIN)
        botOffset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        _bottomView.addSubview(btnUpdate)
    }
    
    /**
     * Handle when tap on save button
     */
    internal func btnUpdateTapped(_ sender: AnyObject) {
        showAlert(message: DomainConst.CONTENT00362)
//        G06F01VC._fullAddress = FullAddressBean(
//            provinceId: _data.record.province_id,
//            districtId: _data.record.district_id,
//            wardId: _data.record.ward_id,
//            streetId: _data.record.street_id,
//            houseNumber: _data.record.house_numbers)
//        G06F01S01._selectedValue = (_data.record.name, _data.record.phone)
//        G06F01S02._selectedValue = ConfigBean(id: _data.record.agent_id,
//                                              name: DomainConst.BLANK)
//        G06F01S04._selectedValue = (_data.record.serial, _data.record.hgd_thuong_hieu,
//                                    _data.record.hgd_doi_thu, ConfigBean(id: _data.record.hgd_time_use, name: _data.record.hgd_time_use),
//                                    _data.record.ccsCode)
//        G06F01S05._selectedValue = ConfigBean(id: _data.record.hgd_type,
//                                              name: DomainConst.BLANK)
//        G06F01VC._id = _data.record.id
//        self.pushToView(name: G06F01VC.theClassName)
    }
    //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
}
