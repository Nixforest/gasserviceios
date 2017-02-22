//
//  G04F02S01VC.swift
//  project
//
//  Created by SPJ on 2/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G04F02S01VC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Icon image view */
    @IBOutlet weak var iconImg:     UIImageView!
    /** Table view */
    @IBOutlet weak var tableView:   UITableView!
    /** Add button */
    private var _btnAdd: UIButton = UIButton()
    /** Current page */
    private var _page = 0
    /** Data */
    private var _data: [PromotionBean] = [PromotionBean]()
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self, selector: #selector(configItemTap(_:)), name:NSNotification.Name(rawValue: G04Const.NOTIFY_NAME_G04_PROMOTION_LIST_CONFIG_ITEM), object: nil)
    }

    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Request list
        PromotionListRequest.requestPromotionList(action: #selector(self.setData(_:)), view: self, page: String(self._page))
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Get height of status bar + navigation bar
        let heigh = self.getTopHeight()
        iconImg.image = ImageManager.getImage(named: DomainConst.PROMOTION_ICON_IMG_NAME)
        iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
                               y: heigh + GlobalConst.MARGIN,
                               width: GlobalConst.LOGIN_LOGO_W / 2,
                               height: GlobalConst.LOGIN_LOGO_H / 2)
        iconImg.translatesAutoresizingMaskIntoConstraints = true
        // Order list view
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.frame = CGRect(x: 0,
                                 y: iconImg.frame.maxY,
                                 width: GlobalConst.SCREEN_WIDTH,
                                 height: GlobalConst.SCREEN_HEIGHT - iconImg.frame.maxY - GlobalConst.BUTTON_H - 2 * GlobalConst.MARGIN)
        tableView.separatorStyle = .singleLine
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        tableView.register(UINib(nibName: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE, bundle: frameworkBundle), forCellReuseIdentifier: DomainConst.TABLE_VIEW_CELL_ORDER_TYPE)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        // Button Add
        CommonProcess.createButtonLayout(btn: self._btnAdd,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y: tableView.frame.maxY + GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00222.uppercased(),
                                         action: #selector(_btnAddTapped),
                                         target: self,
                                         img: DomainConst.ADD_ICON_IMG_NAME,
                                         tintedColor: UIColor.white)
        //++ BUG0038-SPJ (NguyenPT 20170222) Decrease size of icon on Button
        self._btnAdd.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                           left: GlobalConst.MARGIN,
                                           bottom: GlobalConst.MARGIN,
                                           right: GlobalConst.MARGIN)
        //-- BUG0038-SPJ (NguyenPT 20170222) Decrease size of icon on Button
        self.view.addSubview(self._btnAdd)

        // Do any additional setup after loading the view.
        setupNavigationBar(title: DomainConst.CONTENT00247, isNotifyEnable: true)
    }
    
    /**
     * Handle tap on Not select button
     */
    func _btnAddTapped(_ sender: AnyObject) {
        self.showToast(message: "_btnAddTapped")
        createAlert()
    }
    
    private func createAlert() {
        var tbxCode: UITextField?
        
        // Create alert
        let alert = UIAlertController(title: DomainConst.CONTENT00249,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .alert)
        // Add textfield
        alert.addTextField(configurationHandler: { textField -> Void in
            tbxCode = textField
            tbxCode?.placeholder = DomainConst.CONTENT00250
            tbxCode?.clearButtonMode = .whileEditing
            tbxCode?.returnKeyType = .done
        })
        // Add cancel action
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202, style: .cancel, handler: nil)
        
        // Add ok action
        let ok = UIAlertAction(title: DomainConst.CONTENT00008, style: .default) { action -> Void in
            if !(tbxCode?.text?.isEmpty)! {
                AddPromotionRequest.requestAddPromotion(action: #selector(self.finishRequestAddPromotion(_:)), view: self, code: (tbxCode?.text)!)
            } else {
                self.showAlert(message: DomainConst.CONTENT00025, okTitle: DomainConst.CONTENT00251,
                               okHandler: {_ in
                                self.createAlert()
                },
                               cancelHandler: {_ in
                                
                })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func finishRequestAddPromotion(_ notification: Notification) {
        let resp = (notification.object as! BaseRespModel)
        if resp.status == DomainConst.RESPONSE_STATUS_SUCCESS {
            self.showAlert(message: resp.message, okHandler: {_ in
                PromotionListRequest.requestPromotionList(action: #selector(self.setData(_:)), view: self, page: String(self._page))
            })
        } else {
//            self.showAlert(message: resp.message, okHandler: {_ in
//                self.createAlert()
//            })
            self.showAlert(message: resp.message, okTitle: DomainConst.CONTENT00251,
                           okHandler: {_ in
                            self.createAlert()
            },
                           cancelHandler: {_ in
                            
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setData(_ notification: Notification) {
        _data = (notification.object as! PromotionListRespModel).getRecord()
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _data.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DomainConst.PROMOTION_TABLE_VIEW_CELL) as! PromotionTableViewCell
        if _data.count > indexPath.row {
            cell.setData(data: _data[indexPath.row])
        }
        return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConst.CELL_HEIGHT_SHOW + GlobalConst.MARGIN
    }
}
