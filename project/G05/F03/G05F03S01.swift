//
//  G05F03S01.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F03S01: StepContent, UISearchBarDelegate,
UITableViewDataSource, UITableViewDelegate {
    // MARK: Properties
    /** Search bar */
    private var _searchBar:             UISearchBar         = UISearchBar()
    /** Flag begin search */
    private var _beginSearch:           Bool                = false
    /** Data */
    private var _data:                  [G05CustomerBean]   = [G05CustomerBean]()
    /** Search bar table view */
    private var _tblSearchBar:          UITableView         = UITableView()
    /** Flag search active */
    private var _searchActive:          Bool                = false
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:        Bool                = false
    /** Tap gesture hide keyboard */
    private var _gestureHideKeyboard:   UIGestureRecognizer = UIGestureRecognizer()
    /** Current target table view */
    private var _tblTarget:             UITableView         = UITableView()
    /** Current target data */
    public static var _target:          G05CustomerBean     = G05CustomerBean()
    /** Number of target table view row */
    private let TARGET_TBL_VIEW_ROW:    Int                 = 3
    /** Button clear target */
    private var _btnClearTarget:        UIButton            = UIButton()
    /** Value of keyword */
    public static var keyword:          String              = DomainConst.BLANK

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = 0
        let contentView     = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        // --- Create content view ---
        // Search bar
        _searchBar.delegate = self
        _searchBar.frame = CGRect(x: 0, y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SEARCH_BOX_HEIGHT)
        _searchBar.placeholder          = DomainConst.CONTENT00287
        _searchBar.layer.shadowColor    = UIColor.black.cgColor
        _searchBar.layer.shadowOpacity  = 0.5
        _searchBar.layer.masksToBounds  = false
        _searchBar.showsCancelButton    = true
        _searchBar.showsBookmarkButton  = false
        _searchBar.searchBarStyle       = .default
        contentView.addSubview(_searchBar)
        offset += _searchBar.frame.height
        
        // Target table
        _tblTarget.frame = CGRect(x: 0, y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.CONFIGURATION_ITEM_HEIGHT * CGFloat(TARGET_TBL_VIEW_ROW + 1))
        _tblTarget.delegate = self
        _tblTarget.dataSource = self
        _tblTarget.isHidden = G08F01S01._target.isEmpty()
        contentView.addSubview(_tblTarget)
        offset = offset + _tblTarget.frame.height
        
        // Button clear target
        CommonProcess.createButtonLayout(btn: _btnClearTarget,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y: offset + GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00361.uppercased(),
                                         action: #selector(btnClearTargetTapped),
                                         target: self,
                                         img: DomainConst.CANCEL_IMG_NAME,
                                         tintedColor: UIColor.white)
        self._btnClearTarget.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                            left: GlobalConst.MARGIN,
                                                            bottom: GlobalConst.MARGIN,
                                                            right: GlobalConst.MARGIN)
        _btnClearTarget.isHidden = G05F03S01._target.isEmpty()
        offset = offset + _btnClearTarget.frame.height
        contentView.addSubview(_btnClearTarget)
        // Gesture
        _gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        // Show hide result of search bar action
        _tblSearchBar.isHidden = !_searchActive
        _tblSearchBar.frame = CGRect(x: 0, y: _searchBar.frame.maxY,
                                     width: GlobalConst.SCREEN_WIDTH,
                                     height: GlobalConst.CELL_IN_SEARCHBAR_TABLE_HEIGHT * 5)
        _tblSearchBar.delegate = self
        _tblSearchBar.dataSource = self
        contentView.addSubview(_tblSearchBar)
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00374,
                   contentHeight: offset,
                   width: w, height: h)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        if G05F03S01._target.isEmpty() {
            self.showAlert(message: DomainConst.CONTENT00374)
            return false
        }
        return true
    }
    
    // MARK: Handle events
    /**
     * Hide keyboard.
     */
    func hideKeyboard() {
        // Hide keyboard
        self.endEditing(true)
        // Turn off flag
        _isKeyboardShow = false
        // Remove hide keyboard gesture
        self.removeGestureRecognizer(_gestureHideKeyboard)
    }
    
    /**
     * Handle tap on clear target button
     */
    internal func btnClearTargetTapped(_ sender: AnyObject) {
        G05F03S01._target = G05CustomerBean.init()
        _tblTarget.reloadData()
        _tblTarget.isHidden = G05F03S01._target.isEmpty()
        _btnClearTarget.isHidden = G05F03S01._target.isEmpty()
    }
    
    // MARK: - SearchbarDelegate
    /**
     * Handle begin search
     */
    func beginSearching()  {
        if _beginSearch == false {
            _beginSearch = true
        }
        // Remove all current data
        _data.removeAll()
        
        if _searchBar.text != nil {
            // Get keyword
            let keyword = _searchBar.text!.removeSign().lowercased()
            G05SearchCustomerRequest.request(action: #selector(finishSearch(_:)),
                                          view: self.getParentView(),
                                          currentView: self,
                                          keyword: keyword)
        }
    }
    
    /**
     * Handle when finish search target
     */
    func finishSearch(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = G05SearchCustomerRespModel(jsonString: data)
        if model.isSuccess() {
            _data = model.record
            // Load data for search bar table view
            _tblSearchBar.reloadData()
            // Show
            _tblSearchBar.isHidden = !_searchActive
            // Move to front
            //self.bringSubview(toFront: _tblSearchBar)
            _tblSearchBar.layer.zPosition = 1
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Tells the delegate that the user changed the search text.
     */
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredStr = searchText
        if filteredStr.characters.count > (DomainConst.SEARCH_TARGET_MIN_LENGTH - 1) {
            _beginSearch = false
            _searchActive = true
            // Start count
//            /** Timer for search auto complete */
//            var timer = Timer()
//            timer.invalidate()
//            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(beginSearching), userInfo: nil, repeats: false)
            
        } else {
            _beginSearch = false
            _searchActive = false
            // Hide search bar table view
            _tblSearchBar.isHidden = !_searchActive
        }
    }
    
    /**
     * Tells the delegate that the cancel button was tapped.
     */
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        _searchActive = false
        // Clear textbox
        if _searchBar.text != nil {
            _searchBar.text = DomainConst.BLANK
        }
        _tblSearchBar.isHidden = !_searchActive
        // Hide keyboard
        self.endEditing(true)
    }
    
    /**
     * Tells the delegate that the search button was tapped.
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        _searchActive = true
        beginSearching()
    }
    
    /**
     * Tells the delegate when the user begins editing the search text.
     */
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        _searchActive = true
        _isKeyboardShow = true
        self.addGestureRecognizer(_gestureHideKeyboard)
    }
    
    /**
     * Tells the delegate that the user finished editing the search text.
     */
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        _searchActive = true
        _isKeyboardShow = false
        // If text is empty
        if (_searchBar.text?.isEmpty)! {
        } else {
            self.endEditing(true)
        }
    }
    
    // MARK: - UITableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == _tblSearchBar {
            return _data.count
        } else  if tableView == _tblTarget {
            if !G05F03S01._target.isEmpty() {
                return TARGET_TBL_VIEW_ROW
            }
        }
        return 0
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Target table view
        if tableView == _tblTarget {
            // Last row
            if indexPath.row == (TARGET_TBL_VIEW_ROW - 1) {
                return GlobalConst.CONFIGURATION_ITEM_HEIGHT * 2
            }
            return GlobalConst.CONFIGURATION_ITEM_HEIGHT
        }
        return UITableViewAutomaticDimension
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            var cell = UITableViewCell()
            if tableView == _tblSearchBar {
                if _data.count > indexPath.row {
                    cell.textLabel?.text = _data[indexPath.row].name
                }                
            } else  if tableView == _tblTarget {
                if !G05F03S01._target.isEmpty() {
                    cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: "cell")
                    // Setting attributes
                    cell.textLabel?.font = GlobalConst.BASE_FONT
                    cell.detailTextLabel?.numberOfLines = 0
                    cell.detailTextLabel?.lineBreakMode = .byWordWrapping
                    cell.detailTextLabel?.font = GlobalConst.BASE_FONT
                    switch indexPath.row {
                    case 0:
                        cell.textLabel?.text = DomainConst.CONTENT00360
                        cell.detailTextLabel?.text = G05F03S01._target.name
                    case 1:
                        cell.textLabel?.text = DomainConst.CONTENT00152
                        cell.detailTextLabel?.text = G05F03S01._target.customer_phone
                    case 2:
                        cell.textLabel?.text = DomainConst.CONTENT00088
                        cell.detailTextLabel?.text = G05F03S01._target.customer_address
                    default:
                        break
                    }
                }
            }
            return cell
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == _tblSearchBar {
            // Dissmiss search result
            _searchActive = false
            _tblSearchBar.isHidden = !_searchActive
            _searchBar.resignFirstResponder()
            // Save selection
            G05F03S01._target = _data[indexPath.row]
            _tblTarget.isHidden = G05F03S01._target.isEmpty()
            _btnClearTarget.isHidden = G05F03S01._target.isEmpty()
            // Update agent selection
            if G05F03S01._target.customer_delivery_agent_id.isEmpty {
                G05F03S03._selectedValue = BaseAgentInfoBean(id: G05F03S01._target.agent_id)
            } else {
                G05F03S03._selectedValue = BaseAgentInfoBean(id: G05F03S01._target.customer_delivery_agent_id)
            }
            // Reload table target data
            _tblTarget.reloadData()
            // Move to next step
            self.stepDoneDelegate?.stepDone()
            // Save keyword
            G05F03S01.keyword = self._searchBar.text!
            // Update data notification
            NotificationCenter.default.post(name: Notification.Name(rawValue: G05Const.NOTIFY_NAME_UPDATE_DATA_G05_F03), object: nil)
        }
    }
}
