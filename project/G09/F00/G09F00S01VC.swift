//
//  G09F00S01VC.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G09F00S01VC: ParentViewController, UISearchBarDelegate {
    // MARK: Properties
    /** Segment button */
    private var _segment:           UISegmentedControl  = UISegmentedControl(
        items: [
            DomainConst.CONTENT00372,
            DomainConst.CONTENT00373
        ])
    /** Search bar */
    private var _searchBar:         UISearchBar         = UISearchBar()
    /** Flag begin search */
    private var _beginSearch:       Bool                = false
    /** Flag search active */
    private var _searchActive:      Bool                = false
    /** Static data */
    private var _data:              EmployeeCashBookListRespModel   = EmployeeCashBookListRespModel()
    /** Current page */
    private var _page:              Int                     = 0
    /** Type: In (1) or Out (2) */
    private var _lookup_type:       Int                     = 1
    /** Current customer Id */
    private var customerId:         String                  = DomainConst.NUMBER_ZERO_VALUE
    
    // MARK: Utility methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        EmployeeCashBookListRequest.request(
            action: action, view: self,
            page: String(_page),
            lookup_type: String(_lookup_type),
            type: DomainConst.CASHBOOK_TYPE_LIST,
            customer_id: customerId)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let height = self.getTopHeight()
        var offset: CGFloat = height
        _searchBar.delegate = self
        _searchBar.frame = CGRect(x: 0, y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SEARCH_BOX_HEIGHT)
        _searchBar.placeholder = DomainConst.CONTENT00287
        _searchBar.layer.shadowColor = UIColor.black.cgColor
        _searchBar.layer.shadowOpacity = 0.5
        _searchBar.layer.masksToBounds = false
        _searchBar.showsCancelButton = true
        _searchBar.showsBookmarkButton = false
        _searchBar.searchBarStyle = .default
        self.view.addSubview(_searchBar)
        offset += _searchBar.frame.height
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
