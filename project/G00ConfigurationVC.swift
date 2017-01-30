//
//  ConfigurationViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00ConfigurationVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Search bar */
    @IBOutlet weak var searchBar: UISearchBar!
    /** Config view */
    @IBOutlet weak var configView: UIView!
    /** Config table view */
    @IBOutlet weak var configTableView: UITableView!
    
    // MARK: Actions
    /**
     * View did appear
     */
    override func viewDidAppear(_ animated: Bool) {
        //notification button enable/disable
        self.updateNotificationStatus()
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.gasServiceItemTapped(_:)),
                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(issueItemTapped(_:)),
                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_ISSUE_ITEM),
                                               object: nil)
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        asignNotifyForMenuItem()
        
        // Config view
        configView.translatesAutoresizingMaskIntoConstraints = true
        configView.frame = CGRect(
            x: 0,
            y: configView.frame.minY,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height)
        
        // Config table view
        configTableView.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        configTableView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height)
        //configTableView.translatesAutoresizingMaskIntoConstraints = true
//        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
//        configTableView.register(UINib(nibName: "ConfigurationTableViewCell", bundle: frameworkBundle), forCellReuseIdentifier: "ConfigurationTableViewCell")
//        configTableView.delegate = self
//        configTableView.dataSource = self
//        configView.addSubview(configTableView)
        searchBar.placeholder = DomainConst.CONTENT00128
        
        // Search bar
        searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchBar.frame = CGRect(
            x: 0,
            y: searchBar.frame.minY,
            width: self.view.frame.size.width,
            height: searchBar.frame.size.height)
        
        // Setup navigation
        setupNavigationBar(title: DomainConst.CONTENT00128, isNotifyEnable: true)
    }

    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    /**
     * Handle tap on cell.
     */
    func cellAction(_ sender: UIButton) {
        switch sender.tag {
            case 0:     // Information view
                self.pushToView(name: DomainConst.G00_INFORMATION_VIEW_CTRL)
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DomainConst.CONFIGURATION_TABLE_VIEW_CELL, for: indexPath) as! ConfigurationTableViewCell
        // Custom cell
        switch (indexPath as NSIndexPath).row {
            case 1:             // Training mode
                cell.setData(leftImg: DomainConst.TRAINING_MODE_IMG_NAME,
                             name: DomainConst.CONTENT00138,
                             switchValue: BaseModel.shared.checkTrainningMode(),
                             action: #selector(updateTrainingMode(_:)),
                             target: self)
            case 0:             // Information
                cell.setData(leftImg: DomainConst.INFORMATION_IMG_NAME,
                             name: DomainConst.CONTENT00139,
                             value: DomainConst.VERSION_CODE)
            default:
                break
            
        }
        
        return cell //ConfigurationTableViewCell
    }
    
    
    /**
     * Handle tap on cell.
     */
    public func updateTrainingMode(_ sender: UISwitch) {
        if sender.isOn {
            BaseModel.shared.setTrainningMode(true)
        } else {
            BaseModel.shared.setTrainningMode(false)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.pushToView(name: DomainConst.G00_INFORMATION_VIEW_CTRL)
        default:
            break
        }
    }
}
