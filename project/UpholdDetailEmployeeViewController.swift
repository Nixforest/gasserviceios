//
//  UpholdDetailEmployeeViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdDetailEmployeeViewController: CommonViewController, UIPopoverPresentationControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Segment ScrollView Control */
    @IBOutlet weak var sgmScrollViewChange: UISegmentedControl!
    /** Information ScrollView */
    @IBOutlet weak var scrViewInformation: UIScrollView!
    /** View informatino */
    @IBOutlet var viewInformation: UpholdDetailEmployeeInfoView!
    /** Uphold History TableView */
    @IBOutlet weak var tblViewHistory: UITableView!
    /** Create reply button */
    @IBOutlet weak var btnCreateReply: UIButton!
    
    // MARK: Actions
    /**
     * Segment ScrollView Control Action
     */
    @IBAction func sgmScrollViewChangeAction(_ sender: AnyObject) {
        switch sgmScrollViewChange.selectedSegmentIndex {
        case 0:     // Information tab
            tblViewHistory.isHidden     = true
            scrViewInformation.isHidden = false
            btnCreateReply.isHidden     = true
            
        case 1:     // History tab
            scrViewInformation.isHidden = true
            tblViewHistory.isHidden     = false
            btnCreateReply.isHidden     = false
        default:
            break
        }

    }
    
    /**
     * Handle tap create uphold reply button.
     */
    @IBAction func btnCreateUpholdReplyTapped(_ sender: AnyObject) {
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.REPLY_UPHOLD_VIEW_CTRL)
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    
    
    /**
     * Handle when tap on Issue menu item
     */
    func issueButtonInAccountVCTapped(_ notification: Notification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
         self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.gasServiceItemTapped(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AccountViewController.issueButtonInAccountVCTapped(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(super.configItemTap(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_ACCOUNTVIEW),
            object: nil)
    }
    
    /**
     * MARK: View did load.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Tab button
        let marginX = GlobalConst.PARENT_BORDER_WIDTH
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        sgmScrollViewChange.translatesAutoresizingMaskIntoConstraints = true
        sgmScrollViewChange.frame = CGRect(x: marginX, y: height,
            width: GlobalConst.SCREEN_WIDTH - marginX * 2,
            height: GlobalConst.BUTTON_H)
        sgmScrollViewChange.setTitle(GlobalConst.CONTENT00072, forSegmentAt: 0)
        sgmScrollViewChange.setTitle(GlobalConst.CONTENT00071, forSegmentAt: 1)
        sgmScrollViewChange.tintColor = GlobalConst.BUTTON_COLOR_RED
        
        // Information view
        scrViewInformation.translatesAutoresizingMaskIntoConstraints = true
        scrViewInformation.frame = CGRect(
            x: marginX + GlobalConst.MARGIN_CELL_X,
            y: sgmScrollViewChange.frame.maxY + GlobalConst.MARGIN_CELL_Y,
            width: GlobalConst.SCREEN_WIDTH - (marginX + GlobalConst.MARGIN_CELL_X) * 2,
            height: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H + GlobalConst.MARGIN_CELL_Y * 2))
        // Draw border
        CommonProcess.setBorder(view: scrViewInformation)
        scrViewInformation.delegate = self
        // Load content
        Bundle.main.loadNibNamed(GlobalConst.UPHOLD_DETAIL_EMPLOYEE_VIEW_CTRL, owner: self, options: nil)
        scrViewInformation.addSubview(viewInformation)

        // Create reply button
        btnCreateReply.translatesAutoresizingMaskIntoConstraints = true
        btnCreateReply.frame = CGRect(
            x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
            y: sgmScrollViewChange.frame.maxY + GlobalConst.MARGIN_CELL_Y,
            width: GlobalConst.BUTTON_W,
            height: GlobalConst.BUTTON_H)
        btnCreateReply.isHidden = true
        btnCreateReply.setTitle(GlobalConst.CONTENT00065, for: .normal)
        btnCreateReply.setTitleColor(UIColor.white, for: .normal)
        btnCreateReply.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnCreateReply.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        // History view
        tblViewHistory.translatesAutoresizingMaskIntoConstraints = true
        tblViewHistory.frame = CGRect(
            x: marginX,
            y: btnCreateReply.frame.maxY + GlobalConst.MARGIN_CELL_Y,
            width: GlobalConst.SCREEN_WIDTH - marginX * 2,
            height: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H * 2 + GlobalConst.MARGIN_CELL_Y * 2))
        tblViewHistory.isHidden = true
        tblViewHistory.separatorStyle = .none
        
        self.tblViewHistory.register(
            UINib(nibName: GlobalConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL, bundle: nil),
            forCellReuseIdentifier: GlobalConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL)
        tblViewHistory.dataSource = self
        tblViewHistory.delegate = self
        
        // MARK: - NavBar
        setupNavigationBar(title: GlobalConst.CONTENT00143, isNotifyEnable: true)
        
        // MARK: - Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdDetailEmployeeViewController.setData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_UPHOLD_DETAIL_VIEW), object: nil)
        // Set data
        if Singleton.sharedInstance.sharedInt != -1 {
            // Check data is existed
            if Singleton.sharedInstance.upholdList.record.count > Singleton.sharedInstance.sharedInt {
                
                CommonProcess.requestUpholdDetail(upholdId: Singleton.sharedInstance.upholdList.record[Singleton.sharedInstance.sharedInt].id, replyId: Singleton.sharedInstance.upholdList.record[Singleton.sharedInstance.sharedInt].reply_id, view: self)
            }
        }
    }
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        viewInformation.setData(model: Singleton.sharedInstance.currentUpholdDetail)
        
        tblViewHistory.reloadData()
    }

    /**
     * Display sub view.
     */
    override func viewDidLayoutSubviews() {
        // Set content of Information view
        viewInformation.frame = CGRect(
            x: GlobalConst.MARGIN_CELL_X,
            y: GlobalConst.MARGIN_CELL_Y,
            width: scrViewInformation.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X) * 2,
            height: UpholdDetailEmployeeInfoView.VIEW_HEIGHT)
        // Set size of content
        scrViewInformation.contentSize = CGSize(
            width: viewInformation.frame.size.width,
            height: viewInformation.frame.size.height)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let count:Int = Singleton.sharedInstance.currentUpholdDetail.reply_item.count
        return count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell:UpholdDetailEmployeeHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: GlobalConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL) as! UpholdDetailEmployeeHistoryTableViewCell
            if Singleton.sharedInstance.currentUpholdDetail.reply_item.count > indexPath.row {
                cell.setData(model: Singleton.sharedInstance.currentUpholdDetail.reply_item[indexPath.row])
            }
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height:CGFloat = UpholdDetailEmployeeHistoryTableViewCell.VIEW_HEIGHT
        return height
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
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverMenu" {
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
