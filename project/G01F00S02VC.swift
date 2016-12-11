//
//  G01F00S02VC.swift
//  project
//
//  Created by Lâm Phạm on 9/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F00S02VC: CommonViewController, UIPopoverPresentationControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Segment ScrollView Control */
    @IBOutlet weak var sgmScrollViewChange: UISegmentedControl!
    /** Information ScrollView */
    @IBOutlet weak var scrViewInformation: UIScrollView!
    /** View informatino */
    @IBOutlet var viewInformation: G01F00S02InfoView!
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
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.G01_F02_VIEW_CTRL)
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
            selector: #selector(super.issueItemTapped(_:)),
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
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        sgmScrollViewChange.translatesAutoresizingMaskIntoConstraints = true
        sgmScrollViewChange.frame = CGRect(
            x: marginX, y: height,
            width: GlobalConst.SCREEN_WIDTH - marginX * 2,
            height: GlobalConst.BUTTON_H)
        sgmScrollViewChange.setTitle(GlobalConst.CONTENT00072, forSegmentAt: 0)
        sgmScrollViewChange.setTitle(GlobalConst.CONTENT00071, forSegmentAt: 1)
        sgmScrollViewChange.tintColor = GlobalConst.BUTTON_COLOR_RED
        
        //----- Information view -----
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
        Bundle.main.loadNibNamed(GlobalConst.G01_F00_S02_INFO_VIEW, owner: self, options: nil)
        scrViewInformation.addSubview(viewInformation)

        // Create reply button
        btnCreateReply.translatesAutoresizingMaskIntoConstraints = true
        btnCreateReply.frame = CGRect(
            x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
            y: sgmScrollViewChange.frame.maxY + GlobalConst.MARGIN_CELL_Y,
            width: GlobalConst.BUTTON_W,
            height: GlobalConst.BUTTON_H)
        btnCreateReply.setTitle(GlobalConst.CONTENT00065, for: .normal)
        btnCreateReply.setTitleColor(UIColor.white, for: .normal)
        btnCreateReply.isHidden             = true
        btnCreateReply.backgroundColor      = GlobalConst.BUTTON_COLOR_RED
        btnCreateReply.layer.cornerRadius   = GlobalConst.BUTTON_CORNER_RADIUS
        
        //-----  History view -----
        tblViewHistory.translatesAutoresizingMaskIntoConstraints = true
        tblViewHistory.frame = CGRect(
            x: marginX,
            y: btnCreateReply.frame.maxY + GlobalConst.MARGIN_CELL_Y,
            width: GlobalConst.SCREEN_WIDTH - marginX * 2,
            height: GlobalConst.SCREEN_HEIGHT - (height + GlobalConst.BUTTON_H * 2 + GlobalConst.MARGIN_CELL_Y * 2))
        tblViewHistory.isHidden         = true
        tblViewHistory.separatorStyle   = .none
        
        self.tblViewHistory.register(
            UINib(nibName: GlobalConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL, bundle: nil),
            forCellReuseIdentifier: GlobalConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL)
        tblViewHistory.dataSource   = self
        tblViewHistory.delegate     = self
        
        // MARK: - NavBar
        setupNavigationBar(title: GlobalConst.CONTENT00143, isNotifyEnable: true)
        
        // MARK: - Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S02VC.setData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_UPHOLD_DETAIL_VIEW), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S02VC.reloadData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_RELOAD_DATA_UPHOLD_DETAIL_VIEW), object: nil)
        
        // Set data
        if Singleton.shared.sharedInt != -1 {
            // Check data is existed
            if Singleton.shared.upholdList.record.count > Singleton.shared.sharedInt {
                CommonProcess.requestUpholdDetail(upholdId: Singleton.shared.upholdList.record[Singleton.shared.sharedInt].id, replyId: Singleton.shared.upholdList.record[Singleton.shared.sharedInt].reply_id, view: self)
            }
        }
    }
    
    /**
     * Reload data after done any action
     * - parameter notification: Notification
     */
    func reloadData(_ notification: Notification) {
        // Set data
        if Singleton.shared.sharedInt != -1 {
            // Check data is existed
            if Singleton.shared.upholdList.record.count > Singleton.shared.sharedInt {
                CommonProcess.requestUpholdDetail(upholdId: Singleton.shared.upholdList.record[Singleton.shared.sharedInt].id, replyId: Singleton.shared.upholdList.record[Singleton.shared.sharedInt].reply_id, view: self)
            }
        }
    }
    
    /**
     * Set data for controls
     * - parameter notification: Notification
     */
    override func setData(_ notification: Notification) {
        viewInformation.setData(model: Singleton.shared.currentUpholdDetail)
        
        tblViewHistory.reloadData()
        self.updateNotificationStatus()
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        Singleton.shared.currentUpholdDetail.reply_item.removeAll()
        tblViewHistory.reloadData()
        // Notification
        if Singleton.shared.checkNotificationExist() {
            Singleton.shared.clearNotificationData()
        }
    }

    /**
     * Display sub view.
     */
    override func viewDidLayoutSubviews() {
        // Set content of Information view
        viewInformation.frame = CGRect(
            x: GlobalConst.MARGIN_CELL_X, y: GlobalConst.MARGIN_CELL_Y,
            width: scrViewInformation.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X) * 2,
            height: G01F00S02InfoView.VIEW_HEIGHT)
        // Set size of content
        scrViewInformation.contentSize = CGSize(
            width: viewInformation.frame.size.width,
            height: viewInformation.frame.size.height)
    }
    
    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let count:Int = Singleton.shared.currentUpholdDetail.reply_item.count
        return count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL) as! G01F00S02HistoryCell
            
            // Set cell data
            if Singleton.shared.currentUpholdDetail.reply_item.count > indexPath.row {
                cell.setData(model: Singleton.shared.currentUpholdDetail.reply_item[indexPath.row], row: indexPath.row, view: self)
            }
            // Set data source for image collection
            if Singleton.shared.currentUpholdDetail.reply_item.count > indexPath.row {
                if (Singleton.shared.currentUpholdDetail.reply_item[indexPath.row].images.count > 0) {
                    cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                } else {
                    cell.hideImageCollection()
                }
            }
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return G01F00S02HistoryCell.getTableCellHeight(model: Singleton.shared.currentUpholdDetail.reply_item[indexPath.row])
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
    
    /**
     * View did appear
     */
    override func viewDidAppear(_ animated: Bool) {
        self.updateNotificationStatus()
    }
}

/**
 * Apply add a image collection view to history cell
 */
extension G01F00S02VC: UICollectionViewDelegate, UICollectionViewDataSource {
    /**
     * Asks your data source object for the number of items in the specified section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Singleton.shared.currentUpholdDetail.reply_item[collectionView.tag].images.count
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get current cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        
        cell.imageView1.frame  = CGRect(x: 0,  y: 0,  width: GlobalConst.ACCOUNT_AVATAR_H / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        cell.imageView1.getImgFromUrl(link: Singleton.shared.currentUpholdDetail.reply_item[collectionView.tag].images[indexPath.row].thumb, contentMode: cell.imageView1.contentMode)
        return cell
    }
    
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = cell.imageView1.image
        zoomIMGViewController.imageView.getImgFromUrl(link: Singleton.shared.currentUpholdDetail.reply_item[collectionView.tag].images[indexPath.row].large, contentMode: cell.imageView1.contentMode)
        let IMGVC = self.mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.ZOOM_IMAGE_VIEW_CTRL)
        self.navigationController?.pushViewController(IMGVC, animated: true)
    }
}

