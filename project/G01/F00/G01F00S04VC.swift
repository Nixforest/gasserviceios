//
//  G01F00S04VC.swift
//  project
//
//  Created by SPJ on 6/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F00S04VC: ParentViewController {
    // MARK: Properties
    /** Summary information label */
    private var _lblSum:            UILabel                 = UILabel()
    /** Segment button */
    private var _segment:           UISegmentedControl      = UISegmentedControl(
        items: [
            DomainConst.CONTENT00074,
            DomainConst.CONTENT00311
        ])
    /** Type: New (1) or Finish (2) */
    private var _type:              Int                     = 1
    /** Static data */
    private var _data:              FamilyUpholdListRespModel   = FamilyUpholdListRespModel()
    /** Current page */
    private var _page:              Int                     = 0
    /** Table view */
    private var _tblView:           UITableView             = UITableView()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Utility methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        FamilyUpholdListRequest.request(action: action,
                                        view: self,
                                        page: String(_page),
                                        type: String(_type))
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
    
    // MARK: Handle events
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
     * Handle change value of segment
     */
    internal func segmentChange(_ sender: AnyObject) {
        _type = _segment.selectedSegmentIndex + 1
        resetData()
        requestData()
    }
    
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00420)
        var offset: CGFloat = getTopHeight()
        
        // Summary information label
        _lblSum.frame = CGRect(x: 0, y: offset,
                                        width: GlobalConst.SCREEN_WIDTH,
                                        height: GlobalConst.LABEL_H * 2)
        _lblSum.text = "ABC"//DomainConst.BLANK
        _lblSum.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        _lblSum.textColor = GlobalConst.BUTTON_COLOR_RED
        _lblSum.textAlignment = .center
        _lblSum.lineBreakMode = .byWordWrapping
        _lblSum.numberOfLines = 0
        self.view.addSubview(_lblSum)
        offset = offset + _lblSum.frame.height
        
        // Segment
        let font = UIFont.systemFont(ofSize: GlobalConst.BASE_FONT_SIZE)
        _segment.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.BUTTON_H)
        _segment.setTitleTextAttributes([NSFontAttributeName: font],
                                        for: UIControlState())
        _segment.selectedSegmentIndex = 0
        _segment.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        _segment.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        _segment.tintColor = GlobalConst.BUTTON_COLOR_RED
        _segment.addTarget(self, action: #selector(segmentChange(_:)), for: .valueChanged)
        offset = offset + _segment.frame.height
        self.view.addSubview(_segment)
        
        // Table View
//        _tblView.register(UINib(nibName: TableCellOrderType.theClassName,
//                                bundle: Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)),
//                          forCellReuseIdentifier: TableCellOrderType.theClassName)
//        _tblView.delegate = self
//        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT - offset)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)
        
        // Request data from server
        requestData()
        self.view.makeComponentsColor()
    }
    
    /**
     * Set data for this view controller
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = FamilyUpholdListRespModel(jsonString: data)
        if model.isSuccess() {
            _data.total_page = model.total_page
            _data.total_record = model.total_record
            _data.append(contentOf: model.getRecord())
            self._tblView.reloadData()
        } else {
            showAlert(message: model.message)
        }
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

}
