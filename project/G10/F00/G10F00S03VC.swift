//
//  G10F00S03VC.swift
//  project
//
//  Created by SPJ on 5/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G10F00S03VC: G10F00ReportVC, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: Properties
    /** Content cell identify */
    private let contentCellIdentifier:  String                   = ContentCollectionViewCell.theClassName
    /** Report collection view */
    @IBOutlet weak var collectionView:  UICollectionView!
    /** Static data */
    private var _data:                  ReportOrderFamilyRespModel = ReportOrderFamilyRespModel()
    /** Header text array */
    private var _arrHeaderText:         [String]                 = [
        DomainConst.CONTENT00414,
        DomainConst.CONTENT00415,
        DomainConst.CONTENT00416,
        DomainConst.CONTENT00417,
        DomainConst.CONTENT00239,
        DomainConst.CONTENT00246
    ]
    /** Label from date */
    private var lblFromDate:            UILabel                  = UILabel()
    /** Label to date */
    private var lblToDate:              UILabel                  = UILabel()
    /** Reload data button */
    private var btnReload:              UIButton                 = UIButton()
    
    // MARK: Event handlers
    /**
     * Handle when tap on reload button
     */
    internal func btnReloadTapped(_ sender: AnyObject) {
        requestData()
    }
    
    // MARK: Utility methods
    /**
     * Update data
     * - parameter bean: ReportInventoryRespBean
     */
    private func updateData(bean: ReportOrderFamilyRespBean) {
        _data.record.rows.removeAll()
        let total: ReportOrderFamilyBean = ReportOrderFamilyBean()
        total.name = "Tổng doanh thu"
        total.revenue = bean.total_revenue
        _data.record.rows.append(total)
        for item in bean.sum_all {
            _data.record.rows.append(item)
            _data.record.rows.append(contentsOf: item.children)
        }
        for item in bean.rows {
            _data.record.rows.append(item)
            _data.record.rows.append(contentsOf: item.children)
        }
        for item in bean.sum_order_type {
            _data.record.rows.append(item)
            _data.record.rows.append(contentsOf: item.children)
        }
    }
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        ReportRequest.request(action: action,
                              view: self,
                              from: CommonProcess.getCurrentDate(),
                              to: CommonProcess.getCurrentDate(),
                              url: G10Const.PATH_APP_REPORT_ORDER_FAMILY)
    }
    
    // MARK: Override methods
    /**
     * Handle finish request data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = ReportOrderFamilyRespModel(jsonString: data)
        if model.isSuccess() {
            updateData(bean: model.record)
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.reloadData()
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
        createNavigationBar(title: DomainConst.CONTENT00404)
        var offset = getTopHeight() + GlobalConst.MARGIN
        
        // From date label
        updateLabel(lbl: lblFromDate, x: 0, y: offset,
                    w: GlobalConst.SCREEN_WIDTH / 2,
                    h: GlobalConst.LABEL_H,
                    text: DomainConst.CONTENT00412 + CommonProcess.getCurrentDate(withSpliter: DomainConst.SPLITER_TYPE3),
                    textAlignment: .center)
        self.view.addSubview(lblFromDate)
        
        // To date label
        updateLabel(lbl: lblToDate, x: lblFromDate.frame.maxX, y: offset,
                    w: GlobalConst.SCREEN_WIDTH / 2,
                    h: GlobalConst.LABEL_H,
                    text: DomainConst.CONTENT00413 + CommonProcess.getCurrentDate(withSpliter: DomainConst.SPLITER_TYPE3),
                    textAlignment: .center)
        self.view.addSubview(lblToDate)
        offset += GlobalConst.LABEL_H + GlobalConst.MARGIN / 2
        
        // Collection view
        // Register collection cell
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: contentCellIdentifier)
        // Update frame
        collectionView.frame = CGRect(x: 0, y: offset,
                                      width: GlobalConst.SCREEN_WIDTH,
                                      height: GlobalConst.SCREEN_HEIGHT - offset - GlobalConst.BUTTON_H - GlobalConst.MARGIN * 2)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        offset += collectionView.frame.height + GlobalConst.MARGIN
        // Button update store card
        setupButton(button: btnReload, x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                    y: offset, title: DomainConst.CONTENT00410,
                    icon: DomainConst.RELOAD_IMG_NAME,
                    color: GlobalConst.BUTTON_COLOR_YELLOW,
                    action: #selector(btnReloadTapped(_:)))
        self.view.addSubview(btnReload)
        
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
    // MARK - UICollectionViewDataSource
    /**
     * Asks your data source object for the number of sections in the collection view.
     * - returns: Number of rows
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if _data.record.rows.count != 0 {
            return _data.record.rows.count + 1
        }
        return 2
    }
    
    /**
     * Asks your data source object for the number of items in the specified section.
     * - returns: Number of columns
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _arrHeaderText.count + 1
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: contentCellIdentifier,
            for: indexPath) as! ContentCollectionViewCell
        // This is the first row
        if (indexPath as NSIndexPath).section == 0 {
            cell.updateValueHeader(index: indexPath, topLeftText: DomainConst.CONTENT00411,
                                   arrHeader: _arrHeaderText)
        } else {
            // These are the remaining rows
            if (indexPath as NSIndexPath).row == 0 {
                // This is the first column of each row. Label it accordingly.
                if _data.record.rows.count > (indexPath.section - 1) {
                    let data = _data.record.rows[indexPath.section - 1]
                    if !data.children.isEmpty {
                        cell.updateValue(value: data.name, alignment: .left, bkgColor: GlobalConst.REPORT_PARENT_COLOR)
                    } else {
                        var background = UIColor.white
                        if indexPath.section % 2 != 0 {
                            background = GlobalConst.BACKGROUND_COLOR_GRAY
                        }
                        cell.updateValue(value: data.name, alignment: .left, bkgColor: background, leftMargin: 10)
                    }
                    
                    //cell.layer.addBorder(edge: .right, color: .black, thickness: 1.0)
                }
            } else {
                // These are all the remaining content cells (neither first column nor first row)
                if _data.record.rows.count > indexPath.section - 1 {
                    let data = _data.record.rows[indexPath.section - 1]
                    var value = DomainConst.BLANK
                    switch indexPath.row - 1 {
                    case 0:
                        value = data.revenue
                    case 1:
                        value = data.qty
                    case 2:
                        value = data.price
                    case 3:
                        value = data.amount
                    case 4:
                        value = data.discount
                    case 5:
                        value = data.bu_vo
                    default:
                        value = DomainConst.BLANK
                    }
                    if !data.children.isEmpty {
                        cell.updateValue(value: value, alignment: .center, bkgColor: GlobalConst.REPORT_PARENT_COLOR)
                    } else {
                        var background = UIColor.white
                        if indexPath.section % 2 != 0 {
                            background = GlobalConst.BACKGROUND_COLOR_GRAY
                        }
                        cell.updateValue(value: value, alignment: .center, bkgColor: background)
                    }
                }
            }
        }
        return cell
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: Setup layout-control
    /**
     * Setup button for this view
     * - parameter button:  Button to setup
     * - parameter x:       X position of button
     * - parameter y:       Y position of button
     * - parameter title:   Title of button
     * - parameter icon:    Icon of button
     * - parameter color:   Color of button
     * - parameter action:  Action of button
     */
    private func setupButton(button: UIButton, x: CGFloat, y: CGFloat, title: String,
                             icon: String, color: UIColor, action: Selector) {
        button.frame = CGRect(x: x,
                              y: y,
                              width: GlobalConst.BUTTON_W,
                              height: GlobalConst.BUTTON_H)
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(GlobalConst.BUTTON_COLOR_DISABLE, for: .disabled)
        button.backgroundColor          = color
        button.titleLabel?.font         = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        button.layer.cornerRadius       = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        button.imageView?.contentMode   = .scaleAspectFit
        let img = ImageManager.getImage(named: icon)
        let tintedImg = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        button.tintColor = UIColor.white
        button.setImage(tintedImg, for: UIControlState())
        //button.setImage(ImageManager.getImage(named: icon), for: UIControlState())
        button.addTarget(self, action: action, for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                              left: GlobalConst.MARGIN / 2,
                                              bottom: GlobalConst.MARGIN,
                                              right: GlobalConst.MARGIN)
    }
    
    /**
     * Update label control
     * - parameter lbl:             Label control
     * - parameter x:               X position
     * - parameter y:               Y position
     * - parameter w:               Width
     * - parameter h:               Height
     * - parameter text:            Text value
     * - parameter textAlignment:   Text alignment value
     */
    private func updateLabel(lbl: UILabel, x: CGFloat, y: CGFloat,
                             w: CGFloat, h: CGFloat,
                             text: String, textAlignment: NSTextAlignment) {
        lbl.frame = CGRect(x: x, y: y, width: w, height: h)
        lbl.text = text
        lbl.textAlignment = textAlignment
        lbl.font = GlobalConst.BASE_FONT
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.black
    }
}
