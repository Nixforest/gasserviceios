//
//  G01F00S02VC.swift
//  project
//
//  Created by Lâm Phạm on 9/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F00S02VC: BaseViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
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
        self.pushToView(name: DomainConst.G01_F02_VIEW_CTRL)
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.gasServiceItemTapped(_:)),
            name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(super.issueItemTapped(_:)),
            name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_ISSUE_ITEM),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(super.configItemTap(_:)),
            name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_COFIG_ITEM_ACCOUNTVIEW),
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
        sgmScrollViewChange.setTitle(DomainConst.CONTENT00072, forSegmentAt: 0)
        sgmScrollViewChange.setTitle(DomainConst.CONTENT00071, forSegmentAt: 1)
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
        Bundle.main.loadNibNamed(DomainConst.G01_F00_S02_INFO_VIEW, owner: self, options: nil)
        scrViewInformation.addSubview(viewInformation)

        // Create reply button
        btnCreateReply.translatesAutoresizingMaskIntoConstraints = true
        btnCreateReply.frame = CGRect(
            x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
            y: sgmScrollViewChange.frame.maxY + GlobalConst.MARGIN_CELL_Y,
            width: GlobalConst.BUTTON_W,
            height: GlobalConst.BUTTON_H)
        btnCreateReply.setTitle(DomainConst.CONTENT00065, for: .normal)
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
            UINib(nibName: DomainConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL, bundle: nil),
            forCellReuseIdentifier: DomainConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL)
        tblViewHistory.dataSource   = self
        tblViewHistory.delegate     = self
        
        // MARK: - NavBar
        setupNavigationBar(title: DomainConst.CONTENT00143, isNotifyEnable: true)
        
        // MARK: - Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S02VC.setData(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_UPHOLD_DETAIL_VIEW), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S02VC.reloadData(_:)), name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_RELOAD_DATA_UPHOLD_DETAIL_VIEW), object: nil)
        
        // Set data
        if BaseModel.shared.sharedInt != -1 {
            // Check data is existed
            if BaseModel.shared.upholdList.getRecord().count > BaseModel.shared.sharedInt {
                RequestAPI.requestUpholdDetail(upholdId: BaseModel.shared.upholdList.getRecord()[BaseModel.shared.sharedInt].id, replyId: BaseModel.shared.upholdList.getRecord()[BaseModel.shared.sharedInt].reply_id, view: self)
            }
        }
        // Notification
        if BaseModel.shared.checkNotificationExist() {
            BaseModel.shared.clearNotificationData()
        }
    }
    
    /**
     * Reload data after done any action
     * - parameter notification: Notification
     */
    func reloadData(_ notification: Notification) {
        // Set data
        if BaseModel.shared.sharedInt != -1 {
            // Check data is existed
            if BaseModel.shared.upholdList.getRecord().count > BaseModel.shared.sharedInt {
                RequestAPI.requestUpholdDetail(upholdId: BaseModel.shared.upholdList.getRecord()[BaseModel.shared.sharedInt].id, replyId: BaseModel.shared.upholdList.getRecord()[BaseModel.shared.sharedInt].reply_id, view: self)
            }
        }
    }
    
    /**
     * Set data for controls
     * - parameter notification: Notification
     */
    override func setData(_ notification: Notification) {
        viewInformation.setData(model: BaseModel.shared.currentUpholdDetail)
        
        tblViewHistory.reloadData()
        self.updateNotificationStatus()
    }
    
    /**
     * Clear data
     */
    override func clearData() {
        BaseModel.shared.currentUpholdDetail.reply_item.removeAll()
        tblViewHistory.reloadData()
        // Notification
        if BaseModel.shared.checkNotificationExist() {
            BaseModel.shared.clearNotificationData()
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
        let count:Int = BaseModel.shared.currentUpholdDetail.reply_item.count
        return count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                DomainConst.UPHOLD_DETAIL_EMPLOYEE_HISTORY_TABLE_VIEW_CELL) as! G01F00S02HistoryCell
            
            // Set cell data
            if BaseModel.shared.currentUpholdDetail.reply_item.count > indexPath.row {
                cell.setData(model: BaseModel.shared.currentUpholdDetail.reply_item[indexPath.row],
                             row: indexPath.row, view: self)
            }
            // Set data source for image collection
            if BaseModel.shared.currentUpholdDetail.reply_item.count > indexPath.row {
                if (BaseModel.shared.currentUpholdDetail.reply_item[indexPath.row].images.count > 0) {
                    cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self,
                                                             forRow: indexPath.row)
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
        return G01F00S02HistoryCell.getTableCellHeight(model: BaseModel.shared.currentUpholdDetail.reply_item[indexPath.row])
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
        return BaseModel.shared.currentUpholdDetail.reply_item[collectionView.tag].images.count
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get current cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        
        cell.imageView.frame  = CGRect(x: 0,  y: 0,  width: GlobalConst.ACCOUNT_AVATAR_H / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        cell.imageView.getImgFromUrl(link: BaseModel.shared.currentUpholdDetail.reply_item[collectionView.tag].images[indexPath.row].thumb, contentMode: cell.imageView.contentMode)
        return cell
    }
    
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = cell.imageView.image
        zoomIMGViewController.imageView.getImgFromUrl(link: BaseModel.shared.currentUpholdDetail.reply_item[collectionView.tag].images[indexPath.row].large, contentMode: cell.imageView.contentMode)
        // Move to rating view
        self.pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)
    }
}

