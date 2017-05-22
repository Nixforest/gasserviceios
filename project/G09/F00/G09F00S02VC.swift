//
//  G09F00S02VC.swift
//  project
//
//  Created by SPJ on 5/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G09F00S02VC: ChildViewController, UITableViewDataSource, UITableViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: Properties
    /** Id */
    public static var _id:          String                      = DomainConst.BLANK
    /** Information table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** List of information data */
    private var _listInfo:          [ConfigurationModel]        = [ConfigurationModel]()
    /** Current data */
    private var _data:              EmployeeCashBookViewRespModel      = EmployeeCashBookViewRespModel()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Bottom view */
    private var _bottomView:        UIView                      = UIView()
    /** Height of bottom view */
    private var bottomHeight:       CGFloat                     = (GlobalConst.BUTTON_H + GlobalConst.MARGIN)
    /** Images collection */
    private var cltImg:             UICollectionView!           = nil
    /** Update button */
    private var btnUpdate:          UIButton                    = UIButton()
    private var images:             [(String, UIImage)]         = [(String, UIImage)]()
    
    // MARK: Methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        if !G09F00S02VC._id.isEmpty {
            EmployeeCashBookViewRequest.request(action: action,
                                         view: self,
                                         id: G09F00S02VC._id)
        }
    }
    
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    
    /**
     * Handle finish request data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = EmployeeCashBookViewRespModel(jsonString: data)
        if model.isSuccess() {
            self._data = model
            setupListInfo()
            btnUpdate.isHidden = (model.record.allow_update == DomainConst.NUMBER_ZERO_VALUE)
            hideImageCollection(isHidden: (_data.record.images.count == 0))
            self._tableView.reloadData()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Handle when tap on save button
     */
    internal func btnUpdateTapped(_ sender: AnyObject) {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheDataForUpdate(_:)),
                                     view: self)
        } else {
            openUpdateCashBookScreen()
        }
    }
    
    /**
     * Handle when finish request cache data for update cashbook
     */
    internal func finishRequestCacheDataForUpdate(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            openUpdateCashBookScreen()
        } else {
            showAlert(message: model.message)
        }
    }
    
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00399)
        _tableView.addSubview(refreshControl)
        _tableView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
        _tableView.delegate = self
        _tableView.dataSource = self
        
        // Bottom view
        _bottomView.frame = CGRect(x: 0, y: GlobalConst.SCREEN_HEIGHT - bottomHeight,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: bottomHeight)
        _bottomView.isHidden = true
        self.view.addSubview(_bottomView)
        createBottomView()
        requestData()
    }
    
    /**
     * Create bottom view
     */
    private func createBottomView() {
        var botOffset: CGFloat = 0.0
        // Create layout for image collection control
        let layout          = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize     = CGSize(width: GlobalConst.ACCOUNT_AVATAR_W / 2,
                                     height: GlobalConst.ACCOUNT_AVATAR_W / 2)
        
        // Create image collection controll
        self.cltImg         = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        self.cltImg.register(UINib(nibName: DomainConst.COLLECTION_IMAGE_VIEW_CELL,
                                   bundle: frameworkBundle),
                             forCellWithReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL)
        self.cltImg.alwaysBounceHorizontal = true
        self.cltImg.delegate    = self
        self.cltImg.dataSource  = self
        self.cltImg.bounces = true
        
        // Set scroll direction
        if let layout = self.cltImg.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        botOffset += GlobalConst.ACCOUNT_AVATAR_W / 2
        // Add image collection to main view
        _bottomView.addSubview(self.cltImg)
        
        // Create update button
        CommonProcess.createButtonLayout(
            btn: btnUpdate,
            x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
            y: botOffset,
            text: DomainConst.CONTENT00141.uppercased(),
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
     * Hide image collection.
     */
    private func hideImageCollection(isHidden: Bool) {
        var botOffset: CGFloat = 0.0
        
        if isHidden {
            bottomHeight = (GlobalConst.BUTTON_H + GlobalConst.MARGIN)
        } else {
            bottomHeight = (GlobalConst.BUTTON_H + GlobalConst.MARGIN + GlobalConst.ACCOUNT_AVATAR_H / 2)
            if cltImg != nil {
                cltImg.translatesAutoresizingMaskIntoConstraints = true
                cltImg.frame = CGRect(x: GlobalConst.MARGIN_CELL_X * 2,
                                      y: botOffset,
                                      width: self.view.frame.width - 4 * GlobalConst.MARGIN_CELL_X,
                                      height: GlobalConst.ACCOUNT_AVATAR_H / 2)
                cltImg.backgroundColor = UIColor.white
                cltImg.contentSize = CGSize(
                    width: GlobalConst.ACCOUNT_AVATAR_H / 2 * (CGFloat)(_data.record.images.count),
                    height: GlobalConst.ACCOUNT_AVATAR_H / 2)
                
                cltImg.reloadData()
            }
            botOffset += self.cltImg.frame.height
        }
        self.cltImg.isHidden = isHidden
        _tableView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SCREEN_HEIGHT - bottomHeight)
        _bottomView.frame = CGRect(x: 0, y: GlobalConst.SCREEN_HEIGHT - bottomHeight,
                                   width: GlobalConst.SCREEN_WIDTH,
                                   height: bottomHeight)
        btnUpdate.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                 y: botOffset,
                                   width: btnUpdate.frame.width,
                                   height: btnUpdate.frame.height)
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
    
    
    // MARK: Utility methods
    
    /**
     * Handle start create store card
     */
    private func openUpdateCashBookScreen() {
        G09F01VC._typeId    = _data.record.master_lookup_id
        G09F01VC._mode      = DomainConst.NUMBER_ONE_VALUE
        G09F01VC._id        = _data.record.id
        G09F01S01._selectedValue   = _data.record.date_input
        
        G09F01S02._target   = CustomerBean(id: _data.record.customer_id,
                                           name: _data.record.customer_name,
                                           phone: _data.record.customer_phone,
                                           address: _data.record.customer_address)
        G09F01S03._selectedValue = _data.record.amount
        G09F01S04._selectedValue = _data.record.note
        for image in images {
            G09F01S06._selectedValue.append(image.1)
        }
        self.pushToView(name: G09F01VC.theClassName)
    }
    /**
     * Set up list information
     */
    private func setupListInfo() {
        self._listInfo.removeAll()
        // In/out date
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CREATED_DATE_ID,
            name: DomainConst.CONTENT00355,
            iconPath: DomainConst.DATETIME_ICON_IMG_NAME,
            value: _data.record.date_input))
        
        // Type of cashbook
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_ID_ID,
                                            name: _data.record.master_lookup_text,
                                            iconPath: DomainConst.ORDER_ID_ICON_IMG_NAME,
                                            value: DomainConst.BLANK))
        // Address
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_ADDRESS_ID, name: _data.record.customer_address.normalizateString(),
            iconPath: DomainConst.ADDRESS_ICON_IMG_NAME, value: DomainConst.BLANK))
        // Contact
        _listInfo.append(ConfigurationModel(
            id: DomainConst.ORDER_INFO_CONTACT_ID,
            name: _data.record.customer_name,
            iconPath: DomainConst.AGENT_ICON_IMG_NAME,
            value: DomainConst.BLANK))
        // Money
        _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_TOTAL_MONEY_ID,
                                            name: DomainConst.CONTENT00394,
                                            iconPath: DomainConst.MONEY_ICON_PAPER_IMG_NAME,
                                            value: _data.record.amount + DomainConst.VIETNAMDONG))
        // Note
        if !_data.record.note.isEmpty {
            _listInfo.append(ConfigurationModel(id: DomainConst.ORDER_INFO_ID_ID,
                                                name: _data.record.note,
                                                iconPath: DomainConst.PROBLEM_ICON_IMG_NAME,
                                                value: DomainConst.BLANK))
        }
    }
    
    // MARK: - UITableViewDataSource
    /**
     * The number of sections in the table view.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _listInfo.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell: ConfigurationTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: ConfigurationTableViewCell.theClassName)
                as! ConfigurationTableViewCell
            cell.setData(data: _listInfo[indexPath.row])
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConst.CONFIGURATION_ITEM_HEIGHT
    }
    /**
     * Asks your data source object for the number of items in the specified section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.record.images.count
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get current cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        
        cell.imageView.frame  = CGRect(x: 0,  y: 0,  width: GlobalConst.ACCOUNT_AVATAR_H / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        cell.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].thumb, contentMode: cell.imageView.contentMode)
        return cell
    }
    
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = cell.imageView.image
        zoomIMGViewController.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].large, contentMode: cell.imageView.contentMode)
        // Move to rating view
        self.pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)
    }
}
