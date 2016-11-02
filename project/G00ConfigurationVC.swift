//
//  ConfigurationViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G00ConfigurationVC: CommonViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var configView: UIView!
    @IBOutlet weak var configTableView: UITableView!
    
    /**
     * View did appear
     */
    override func viewDidAppear(_ animated: Bool) {
        //training mode enable/disable
        if Singleton.sharedInstance.checkTrainningMode() {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_YELLOW.cgColor
        } else {
            self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        }
        
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
        
        configView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        configView.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        
        configView.translatesAutoresizingMaskIntoConstraints = true
        
        configTableView.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        configTableView.frame = CGRect(
            x: GlobalConst.PARENT_BORDER_WIDTH,
            y: GlobalConst.PARENT_BORDER_WIDTH,
            width: configView.frame.size.width,
            height: configView.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH)
        configTableView.translatesAutoresizingMaskIntoConstraints = true
        searchBar.placeholder = GlobalConst.CONTENT00128
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
            case 1:     // Information view
                let InfoVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G00_INFORMATION_VIEW_CTRL)
                self.navigationController?.pushViewController(InfoVC, animated: true)
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConst.G00_CONFIGURATION_TABLE_VIEW_CELL, for: indexPath) as! G00ConfigurationCell
        
        //custom cell
        switch (indexPath as NSIndexPath).row {
            case 0:
                cell.rightImg.isHidden  = true
                cell.mySw.isHidden      = false
                cell.leftImg.image      = UIImage(named: "TrainingModeIcon.png")
                cell.nameLbl.text       = GlobalConst.CONTENT00138
            case 1:
                cell.rightImg.isHidden  = false
                cell.mySw.isHidden      = true
                cell.leftImg.image      = UIImage(named: "InfoIcon.png")
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
