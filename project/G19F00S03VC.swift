//
//  G19F00S03VC.swift
//  project
//
//  Created by SPJ on 9/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

class G19F00S03VC: BaseChildViewController {
    @IBOutlet weak var lblTitle: UILabel!
    /** id */
    internal var _linkWeb:                String              = DomainConst.BLANK
    var _id : String = DomainConst.BLANK
    /** Data CMS List*/
    internal var _data: CMSViewResModel    = CMSViewResModel()
    internal var _dataCMS: CMSListBean   = CMSListBean()
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var btnOtherAction: UIButton!
    
    @IBOutlet weak var btnReload: UIButton!
    @IBAction func reload(_ sender: Any) {
        requestCMSView(completionHandler: finishRequestCMSView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOtherAction.layer.cornerRadius  = 20
        btnOtherAction.backgroundColor     = GlobalConst.BUTTON_COLOR_RED
        btnReload.layer.cornerRadius  = 20
        btnReload.backgroundColor     = GlobalConst.BUTTON_COLOR_RED
        webView.scrollView.bounces = false
        if BaseModel.shared.sharedTitle == DomainConst.BLANK{
            self.createNavigationBar(title: "Thông báo")
        }
        else{
            self.createNavigationBar(title: BaseModel.shared.sharedTitle)
        }
        self.automaticallyAdjustsScrollViewInsets = false
        // Id
        //lblTitle.text = BaseModel.shared.sharedTitleNotify
        _id = BaseModel.shared.sharedString
//        let url = URL(string: _linkWeb)
//        let requestObj = URLRequest(url: url! as URL)
//        webView.loadRequest(requestObj)
        //request View
        requestCMSView(completionHandler: finishRequestCMSView)
        // Do any additional setup after loading the view.
    }
    
    private func requestCMSView(completionHandler: ((Any?)->Void)?) {
        //CategoryListRequest.request(view: self, completionHandler: completionHandler)
        CMSViewRequest.request(view: self, id: _id, completionHandler: completionHandler)
    }
    
    public func finishRequestCMSView(_ model: Any?) {
        let data = model as! String
        let model = CMSViewResModel(jsonString: data)
        if model.isSuccess() {
            _dataCMS = model.record
            lblTitle.text = _dataCMS.title
            let url = URL(string: _dataCMS.link_web)
            let requestObj = URLRequest(url: url! as URL)
            webView.loadRequest(requestObj)
            //tblList.reloadData()
        }
            //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }

    /** Tap OtherAction Button */
    @IBAction func btnOtherActionTapped(_ sender: Any) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00436,
                                      message: DomainConst.CONTENT00437,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(cancel)
    
        let ticket = UIAlertAction(title: DomainConst.CONTENT00402,
                                   style: .default, handler: {
                                    action in
                                    self.btnCreateTicketTapped(self)
        })
        alert.addAction(ticket)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = btnOtherAction
            presenter.sourceRect = btnOtherAction.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle when tap on create button
     */
    internal func btnCreateTicketTapped(_ sender: AnyObject) {
        // Check cache data is exist
        if CacheDataRespModel.record.isEmpty() {
            // Request server cache data
            CacheDataRequest.request(action: #selector(finishRequestCacheData(_:)),
                                     view: self)
        } else {
            // Start create ticket
            createTicket()
        }
    }
    
    /**
     * Handle when finish request cache data
     */
    internal func finishRequestCacheData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CacheDataRespModel(jsonString: data)
        if model.isSuccess() {
            // Start create ticket
            createTicket()
        } else {
            showAlert(message: model.message)
        }
    }
    
    /**
     * Start create ticket
     */
    private func createTicket() {
        
        handleCreateTicket()
        
    }
    
    /**
     * Open create ticket view controller
     * - parameter id: Id of ticket handler
     */
    internal func handleCreateTicket() {
        //++ BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
        //G11F01VC._handlerId = id
        G11F00S03VC._selectedValue.content = String.init(
            format: DomainConst.CONTENT00597,
            _dataCMS.created_date,
            _dataCMS.id,
            BaseModel.shared.getUserInfoLogin(id: DomainConst.KEY_FIRST_NAME))
        self.pushToView(name: G11F00S03VC.theClassName)
        //-- BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
        
    }
}
