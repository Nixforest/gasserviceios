//
//  G06F00S01VC.swift
//  project
//
//  Created by SPJ on 3/27/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F00S01VC: ParentViewController, UITableViewDataSource, UITableViewDelegate {
    /** Table view */
    @IBOutlet weak var _tableView:     UITableView!
    /** Icon image */
    @IBOutlet weak var iconImg:        UIImageView!
    /** Report label */
    @IBOutlet weak var lblReport: UILabel!
    /** Static data */
    private static var _data:   CustomerFamilyListRespModel = CustomerFamilyListRespModel()
    /** Current page */
    private var _page = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        createNavigationBar(title: DomainConst.CONTENT00281)
        
        // Get height of status bar + navigation bar
        //let height = self.getTopHeight()
        var offset: CGFloat = 0.0
        if BaseModel.shared.getDebugShowTopIconFlag() {
            iconImg.image = ImageManager.getImage(named: DomainConst.ORDER_ICON_IMG_NAME)
            iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
                                   y: offset,
                                   width: GlobalConst.LOGIN_LOGO_W / 2,
                                   height: GlobalConst.LOGIN_LOGO_H / 2)
            iconImg.translatesAutoresizingMaskIntoConstraints = true
            offset += iconImg.frame.height
            iconImg.isHidden = false
        } else {
            iconImg.isHidden = true
        }
        
        // Report label
        lblReport.translatesAutoresizingMaskIntoConstraints = true
        lblReport.frame = CGRect(x: 0, y: self.getTopHeight() + GlobalConst.MARGIN,
                                 width: GlobalConst.SCREEN_WIDTH,
                                 height: GlobalConst.LABEL_H)
        lblReport.text               = DomainConst.BLANK
        lblReport.textAlignment      = NSTextAlignment.center
        lblReport.font               = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        lblReport.textColor = UIColor.black
        lblReport.backgroundColor = UIColor.white
        self.view.addSubview(lblReport)
        offset += lblReport.frame.height + GlobalConst.MARGIN
        
        // Customer list view
        _tableView.translatesAutoresizingMaskIntoConstraints = true
        _tableView.frame = CGRect(x: 0,
                                  y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SCREEN_HEIGHT - offset)
        _tableView.separatorStyle = .singleLine
         _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.contentInset = UIEdgeInsets.zero
        
        // Get data from server
        G06F00S01VC._data.clearData()
        CustomerFamilyListRequest.request(action: #selector(setData(_:)),
                                          view: self,
                                          buying: DomainConst.CUSTOMER_FAMILY_BUYING_ALL,
                                          dateFrom: CommonProcess.getCurrentDate(),
                                          dateTo: CommonProcess.getCurrentDate(),
                                          page: String(self._page))
    }
    
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = CustomerFamilyListRespModel(jsonString: data)
        G06F00S01VC._data.total_page = model.total_page
        G06F00S01VC._data.total_record = model.total_record
        G06F00S01VC._data.append(contentOf: model.getRecord())
        lblReport.text = model.report
        _tableView.reloadData()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     * Tells the data source to return the number of rows in a given section of a table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return G06F00S01VC._data.getRecord().count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DomainConst.CUSTOMER_FAMILY_LIST_TABLE_VIEW_CELL) as! CustomerFamilyListCell
        if G06F00S01VC._data.getRecord().count > indexPath.row {
            cell.setData(model: G06F00S01VC._data.getRecord()[indexPath.row])
        }
        return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CustomerFamilyListCell.CELL_HEIGHT - GlobalConst.CELL_HEIGHT_SHOW / 4
    }
    
    /**
     * Tells the delegate that the specified row is now selected.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        G05F00S02VC._id = G05F00S01VC._data.getRecord()[indexPath.row].id
//        self.pushToView(name: G05Const.G05_F00_S02_VIEW_CTRL)
//        self.showToast(message: "Open order detail: \(G05F00S02VC._id)")
    }
    
    /**
     * Tells the delegate the table view is about to draw a cell for a particular row.
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Total page does not 1
        if G06F00S01VC._data.total_page != 1 {
            let lastElement = G06F00S01VC._data.getRecord().count - 1
            // Current is the last element
            if indexPath.row == lastElement {
                self._page += 1
                // Page less than total page
                if self._page <= G06F00S01VC._data.total_page {
                    CustomerFamilyListRequest.request(action: #selector(setData(_:)),
                                                      view: self,
                                                      buying: DomainConst.CUSTOMER_FAMILY_BUYING_ALL,
                                                      dateFrom: CommonProcess.getCurrentDate(),
                                                      dateTo: CommonProcess.getCurrentDate(),
                                                      page: String(self._page))
                }
            }
        }
    }
}
