//
//  G00AccountEditVC.swift
//  project
//
//  Created by SPJ on 10/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00AccountEditVC: ChildExtViewController {
    // MARK: Properties
    /** Information table view */
    var tblInfo:            UITableView             = UITableView()
    /** Data */
    var _data:              [ConfigurationModel]    = [ConfigurationModel]()
    
    // MARK: Static values
    // MARK: Constant
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createNavigationBar(title: DomainConst.CONTENT00442)
    }
    
    /**
     * Handle update constants
     */
    override func updateConst() {
        super.updateConst()
    }
    
    /**
     * Create children views
     */
    override func createChildrenViews() {
        super.createChildrenViews()
        // Create information table view
        createInfoTableView()
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                break
            default:
                break
            }
            
            break
        default:
            break
        }
        self.view.addSubview(tblInfo)
    }
    
    /**
     * Update children views
     */
    override func updateChildrenViews() {
        super.updateChildrenViews()
        // Update information table view
        updateInfoTableView()
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                break
            default:
                break
            }
            
            break
        default:
            break
        }
    }
    
    // MARK: Event handler
    
    // MARK: Logic
    /**
     * Request data
     */
    internal func requestData() {
    }
    // MARK: Layout
    // MARK: Information table view
    private func createInfoTableView() {
        tblInfo.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height)
        tblInfo.dataSource = self
        tblInfo.delegate = self
//        tblInfo.separatorStyle = .none
        _data.append(ConfigurationModel(
            id: DomainConst.ACCOUNT_INFO_NAME_ID,
            name: DomainConst.CONTENT00079,
            iconPath: DomainConst.NAME_ICON_IMG_NAME,
            value: (BaseModel.shared.user_info?.getName())!))
        _data.append(ConfigurationModel(
            id: DomainConst.ACCOUNT_INFO_EMAIL_ID,
            name: DomainConst.CONTENT00443,
            iconPath: DomainConst.PHONE_ICON_NEW_IMG_NAME,
            value: (BaseModel.shared.user_info?.getEmail())!))
        _data.append(ConfigurationModel(
            id: DomainConst.ACCOUNT_INFO_HOUSE_NUMBER_ID,
            name: DomainConst.CONTENT00057,
            iconPath: DomainConst.ADDRESS_ICON_NEW_IMG_NAME,
            value: (BaseModel.shared.user_info?.getHouseNumber())!))
        _data.append(ConfigurationModel(
            id: DomainConst.ACCOUNT_INFO_STREET_ID,
            name: DomainConst.CONTENT00058,
            iconPath: DomainConst.ADDRESS_ICON_NEW_IMG_NAME,
            value: (BaseModel.shared.user_info?.getStreetId())!))
        _data.append(ConfigurationModel(
            id: DomainConst.ACCOUNT_INFO_CITY_ID,
            name: DomainConst.CONTENT00298,
            iconPath: DomainConst.ADDRESS_ICON_NEW_IMG_NAME,
            value: (BaseModel.shared.user_info?.getProvinceId())!))
        _data.append(ConfigurationModel(
            id: DomainConst.ACCOUNT_INFO_DISTRICT_ID,
            name: DomainConst.CONTENT00299,
            iconPath: DomainConst.ADDRESS_ICON_NEW_IMG_NAME,
            value: (BaseModel.shared.user_info?.getDistrictId())!))
        _data.append(ConfigurationModel(
            id: DomainConst.ACCOUNT_INFO_WARD_ID,
            name: DomainConst.CONTENT00300,
            iconPath: DomainConst.ADDRESS_ICON_NEW_IMG_NAME,
            value: (BaseModel.shared.user_info?.getWardId())!))
        tblInfo.reloadData()
    }
    
    private func updateInfoTableView() {
        CommonProcess.updateViewPos(
            view: tblInfo,
            x: 0, y: 0,
            w: UIScreen.main.bounds.width,
            h: UIScreen.main.bounds.height)
    }
}

// MARK: Protocol - UITableViewDataSource
extension G00AccountEditVC: UITableViewDataSource {
    /**
     * Asks the data source to return the number of sections in the table view.
     * - returns: 1 section
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     * - returns: List information count
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return _data.count
        }
        return 2
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            if indexPath.row < self._data.count {
                let data = self._data[indexPath.row]
                cell.textLabel?.text = data.name
                cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
                cell.detailTextLabel?.text = data.getValue()
                cell.detailTextLabel?.font = GlobalConst.BASE_BOLD_FONT
                cell.detailTextLabel?.lineBreakMode = .byWordWrapping
                cell.detailTextLabel?.numberOfLines = 0
            }
            return cell
        case 1:
            break
        default:
            break
        }
        return UITableViewCell()
    }
}

// MARK: Protocol - UITableViewDelegate
extension G00AccountEditVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
