//
//  G08F00S01VC.swift
//  project
//
//  Created by SPJ on 5/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G08F00S01VC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Table view */
    @IBOutlet weak var _tblView: UITableView!
    /** Create new store card button */
    @IBOutlet weak var _btnCreateNew: UIButton!
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    /** Data */
    private var _data:              StoreCardListRespModel  = StoreCardListRespModel()
    /** Page number */
    private var _page:              Int                     = 0
    
    // MARK: Methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        StoreCardListRequest.request(action: action,
                                     view: self,
                                     page: String(_page))
    }
    
    /**
     * Reset data
     */
    private func resetData() {
        _data.clearData()
        // Reset current search value
        self._page      = 0
        // Reload table
        _tblView.reloadData()
    }
    
    /**
     * Handle refresh
     */
    internal func handleRefresh(_ sender: AnyObject) {
        self.resetData()
        requestData(action: #selector(finishHandleRefresh(_:)))
    }
    
    /**
     * Handle finish refresh
     */
    internal func finishHandleRefresh(_ notification: Notification) {
        setData(notification)
        refreshControl.endRefreshing()
    }
    
    /**
     * Finish request, set data to control
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = StoreCardListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            _tblView.reloadData()
        }
        
    }
    
    /**
     * Handle event when tap create new button
     */
    internal func btnCreateNewTapped(_ sender: AnyObject) {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } else {
            // Open create store card view controller
            openCreateStoreCardScreen()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Open create store card view controller
            openCreateStoreCardScreen()
        }
    }
    
    /**
     * Handle start create store card
     */
    private func openCreateStoreCardScreen() {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00357,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
        for item in CacheDataRespModel.record.getListStoreCardType() {
            let action = UIAlertAction(title: item.name,
                                       style: .default, handler: {
                                        action in
                                        self.handleCreateStoreCard(id: item.id)
            })
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle create store card with Type id
     * - parameter id: Type id of store card
     */
    internal func handleCreateStoreCard(id: String) {
        G08F01VC._typeId = id
        self.pushToView(name:G08F01VC.theClassName)
    }
    
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00352)
        _tblView.addSubview(refreshControl)
        _tblView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SCREEN_HEIGHT - GlobalConst.BUTTON_H - GlobalConst.MARGIN)
        _tblView.rowHeight = UITableViewAutomaticDimension
        _tblView.estimatedRowHeight = 240
        requestData()
        CommonProcess.createButtonLayout(btn: _btnCreateNew,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y:  GlobalConst.SCREEN_HEIGHT - GlobalConst.BUTTON_H - GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00353.uppercased(),
                                         action: #selector(btnCreateNewTapped(_:)),
                                         target: self,
                                         img: DomainConst.ADD_ICON_IMG_NAME,
                                         tintedColor: UIColor.white)
        _btnCreateNew.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                         left: GlobalConst.MARGIN,
                                                         bottom: GlobalConst.MARGIN,
                                                         right: GlobalConst.MARGIN)
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
    
    // MARK: - UITableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            var cell = tableView.dequeueReusableCell(
                withIdentifier: G08Const.G08F00S01_TABLE_VIEW_CELL_ID)
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: G08Const.G08F00S01_TABLE_VIEW_CELL_ID)
                cell?.selectionStyle = .none
            }
            // Set title
            cell?.textLabel?.text           = _data.getRecord()[indexPath.row].code_no
            cell?.textLabel?.textColor      = GlobalConst.MAIN_COLOR
            cell?.textLabel?.numberOfLines  = 0
            cell?.textLabel?.lineBreakMode  = .byWordWrapping
            // Set description
            cell?.detailTextLabel?.text = _data.getRecord()[indexPath.row].customer_name
            cell?.detailTextLabel?.numberOfLines = 0
            cell?.detailTextLabel?.lineBreakMode = .byWordWrapping
            // Set image
             cell?.imageView?.image = textToImage(
                drawText: _data.getRecord()[indexPath.row].date_delivery,
                inImage: UIImage(
                    color: UIColor.white,
                    size: CGSize(width: G08Const.G08F00S01_TABLE_VIEW_CELL_MIN_SIZE,
                                 height: G08Const.G08F00S01_TABLE_VIEW_CELL_MIN_SIZE)
                    )!)
            return cell!
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if self._data.total_page != 1 {
            let lastElement = self._data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= self._data.total_page {
                    requestData()
                }
            }
        }
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        G08F00S02VC._id = _data.getRecord()[indexPath.row].id
        self.pushToView(name: G08F00S02VC.theClassName)
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /**
     * Convert text to image
     * - parameter sText: String of text
     * - parameter image: Image object
     */
    func textToImage(drawText sText: String, inImage image: UIImage) -> UIImage {
        let text = sText as NSString
        // Setup the font specific variables
        let textColor = UIColor.black
        let textFont = UIFont(name: G08Const.G08F00S01_TABLE_VIEW_CELL_FONT,
                              size: G08Const.G08F00S01_TABLE_VIEW_CELL_FONT_SIZE)!
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ] as [String : Any]
        // Put the image into a rectangle as large as the original image
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        // Get start point to draw string
        let strHeight = sText.heightOfString(usingFont: textFont)
        let strWidth = sText.widthOfString(usingFont: textFont)
        let point = CGPoint(x: (image.size.width - strWidth) / 2,
                            y: (image.size.height - strHeight) / 2)
        
        // Create a point within the space that is as bit as the image
        let rect = CGRect(origin: point, size: image.size)
        // Draw the text into an image
        text.draw(in: rect, withAttributes: textFontAttributes)
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        // Pass the image back up to the caller
        return newImage!
    }
}
