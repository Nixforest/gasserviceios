//
//  G08F01Sum.swift
//  project
//
//  Created by SPJ on 5/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G08F01Sum: StepSummary, UITableViewDataSource, UITableViewDelegate {
    // MARK: Properties
    /** Main view */
    private var _mainView:      UIView                      = UIView()
    /** Table view */
    private var _tblMaterial:   UITableView                 = UITableView()
    /** Content view */
    private var _detailView:    DetailInformationColumnView = DetailInformationColumnView()
    /** List of material information */
    private var _listMaterial:      [[(String, Int)]]           = [[(String, Int)]]()
    /** Material header */
    private let _materialHeader:    [(String, Int)]             = [(DomainConst.CONTENT00091, G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
                                                                   (DomainConst.CONTENT00335, G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
                                                                   (DomainConst.CONTENT00255, G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2)]
    private var _height:        CGFloat = 0.0

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
        // Set parent
        self.setParentView(parent: parent)
        _height = h
        // Setting table view material
        _tblMaterial.register(OrderDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        _tblMaterial.delegate = self
        _tblMaterial.dataSource = self
        
        let offset = updateContentLayout()
        _mainView.addSubview(_detailView)
        _mainView.addSubview(_tblMaterial)
        self.setup(mainView: _mainView,
                   title: DomainConst.CONTENT00366,
                   contentHeight: offset,
                   width: w, height: h, reCalculate: true)
        // Call update content to re-calculate height of title
        _ = updateContentLayout()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name:NSNotification.Name(rawValue: G08Const.NOTIFY_NAME_SET_DATA_G08_F01),
                                               object: nil)
        self.makeComponentsColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Update data
     */
    func updateData() {
        _ = updateContentLayout()
    }
    
    /**
     * Update layout of content
     * - returns: Offset after reload
     */
    override func updateContentLayout() -> CGFloat {
        var listValues = [(String, String)]()
        if !G08F01VC._typeId.isEmpty {            
            listValues.append((DomainConst.CONTENT00357, CacheDataRespModel.record.getStoreCardTypeById(id: G08F01VC._typeId)))
        }
        listValues.append((DomainConst.CONTENT00364, G08F01S02._selectedValue))
        if G08F01S01._target.name.isEmpty {
            G08F01S01._target.name = "CUA00012-Nha hang Phong Cua AAAAAA"
        }
        listValues.append((G08F01S01.getTargetNameTitle(), G08F01S01._target.name))
        listValues.append((DomainConst.CONTENT00081, G08F01S04._selectedValue))
        var offset = _detailView.updateData(listValues: listValues)
        _detailView.frame  = CGRect(x: 0, y: 0,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: offset)
        let tblHeight = _height - getTitleHeight() - offset
        // Table view material
        _tblMaterial.frame = CGRect(x: 0, y: offset,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: tblHeight)
        updateTableViewData()
        offset += _tblMaterial.frame.height
//        _mainView.frame = CGRect(x: 0, y: 0,
//                                 width: GlobalConst.SCREEN_WIDTH,
//                                 height: offset)
        return offset
    }
    
    /**
     * Update data
     */
    private func updateTableViewData() {
        _listMaterial.removeAll()
        // Header
        _listMaterial.append(_materialHeader)
        
        // Order detail
        for item in G08F01S03._data {
            let materialValue: [(String, Int)] = [
                (item.materials_no,     G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.0),
                (item.material_name,    G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.1),
                (item.qty + " x " + item.unit,     G08Const.TABLE_COLUMN_WEIGHT_GAS_INFO.2)
            ]
            _listMaterial.append(materialValue)
        }
        _tblMaterial.reloadData()
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
        return _listMaterial.count
    }
    
    /**
     * Asks the data source for a cell to insert in a particular location of the table view.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = OrderDetailTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
            if indexPath.row == 0 {
                cell.setup(data: _listMaterial[indexPath.row], color: GlobalConst.BUTTON_COLOR_GRAY)
            } else {
                cell.setup(data: _listMaterial[indexPath.row],
                           color: UIColor.white,
                           highlighColumn: [1],
                           alignment: [.left, .left, .left])
            }
            
            return cell
    }
    
    /**
     * Asks the delegate for the height to use for a row in a specified location.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalConst.CONFIGURATION_ITEM_HEIGHT
    }
}
