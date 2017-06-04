//
//  G11F00S02VC.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G11F00S02VC: ChildViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Summary information label */
    private var _lblSum:            UILabel                 = UILabel()
    /** Id */
    public static var _id:          String              = DomainConst.BLANK
    /** Current data */
    private var _data:              TicketViewRespModel = TicketViewRespModel()
    /** Table view */
    private var _tblView:           UITableView         = UITableView()
    /** Refrest control */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        //refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    // MARK: Methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        if !G11F00S02VC._id.isEmpty {
            TicketViewRequest.request(action: action,
                                                view: self,
                                                id: G11F00S02VC._id)
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
    
    // MARK: Override from UIViewController
    /**
     * Handle finish request data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = TicketViewRespModel(jsonString: data)
        if model.isSuccess() {
            self._data = model
            self._lblSum.text = model.record.title.capitalizingFirstLetter()
            self._tblView.reloadData()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00426)
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
        
        // Table View
        _tblView.register(UINib(nibName: G11F00S01Cell.theClassName, bundle: nil), forCellReuseIdentifier: G11F00S01Cell.theClassName)
        _tblView.delegate = self
        _tblView.dataSource = self
        _tblView.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT - offset)
        _tblView.addSubview(refreshControl)
        self.view.addSubview(_tblView)
        // Request data from server
        requestData()
        self.view.makeComponentsColor()
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
    
    
    
    // MARK: - UITableViewDataSource-Delegate
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _data.record.list_reply.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell: G11F00S01Cell = tableView.dequeueReusableCell(
                withIdentifier: G11F00S01Cell.theClassName)
                as! G11F00S01Cell
            if _data.record.list_reply.count > indexPath.row {
                cell.setData(dataReply: _data.record.list_reply[indexPath.row])
            }
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return G11F00S01Cell.CELL_HEIGHT
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        G01F00S05VC._id = _data.getRecord()[indexPath.row].id
        //        self.pushToView(name: G01F00S05VC.theClassName)
    }
}
