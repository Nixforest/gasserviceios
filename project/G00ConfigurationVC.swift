//
//  ConfigurationViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G00ConfigurationVC: CommonViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
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
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(issueItemTapped(_:)),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM),
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
        configTableView.translatesAutoresizingMaskIntoConstraints = true
        searchBar.placeholder = GlobalConst.CONTENT00128
        
        // Search bar
        searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchBar.frame = CGRect(
            x: 0,
            y: searchBar.frame.minY,
            width: self.view.frame.size.width,
            height: searchBar.frame.size.height)
        
        // Setup navigation
        setupNavigationBar(title: GlobalConst.CONTENT00128, isNotifyEnable: true)
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
                let InfoVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G00_INFORMATION_VIEW_CTRL)
                self.navigationController?.pushViewController(InfoVC, animated: true)
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConst.G00_CONFIGURATION_TABLE_VIEW_CELL, for: indexPath) as! G00ConfigurationCell
        
        // Custom cell
        switch (indexPath as NSIndexPath).row {
            case 1:             // Training mode
                cell.rightImg.isHidden  = true
                cell.mySw.isHidden      = false
                cell.leftImg.image      = UIImage(named: "trainingMode.png")
                cell.nameLbl.text       = GlobalConst.CONTENT00138
            case 0:             // Information
                cell.rightImg.isHidden  = false
                cell.mySw.isHidden      = true
                cell.leftImg.image      = UIImage(named: "information")
                cell.rightImg.image     = UIImage(named: "back.png")
                cell.rightImg.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                cell.nameLbl.text       = GlobalConst.CONTENT00139
                let cellButton:UIButton = UIButton()
                cellButton.frame        = CGRect(
                    x: 0, y: 0,
                    width: cell.contentView.frame.size.width,
                    height: cell.contentView.frame.size.height)
                cellButton.tag          = (indexPath as NSIndexPath).row
                cellButton.addTarget(self, action: #selector(cellAction(_ :)), for: UIControlEvents.touchUpInside)
                cell.contentView.addSubview(cellButton)
            default:
                break
            
        }
        
        return cell //ConfigurationTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    /**
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GlobalConst.POPOVER_MENU_IDENTIFIER {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    /**
     * ...
     */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
