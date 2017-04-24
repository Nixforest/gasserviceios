//
//  G05F00S04VC.swift
//  project
//
//  Created by SPJ on 4/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F00S04VC: ChildViewController {
    // MARK: Properties
    /** Information table view */
    @IBOutlet weak var _tableView:  UITableView!
    /** Material table view */
    @IBOutlet weak var _tblViewGas: UITableView!
    /** Cylinder table view */
    @IBOutlet weak var _tblViewCylinder: UITableView!
    /** Id */
    public static var _id:          String               = DomainConst.BLANK
    /** Parent view */
    private var _scrollView:        UIScrollView         = UIScrollView()
    /** Customer name label */
    private var _lblCustomerName:   UILabel              = UILabel()
    /** List of information data */
    private var _listInfo:          [ConfigurationModel] = [ConfigurationModel]()
    /** Segment control */
    private var _segment:           UISegmentedControl   = UISegmentedControl(
                                    items: [DomainConst.CONTENT00253, DomainConst.CONTENT00263])
    /** Order information view */
    private var _viewOrderInfo:     UIView               = UIView()
    /** Order cylinder information view */
    private var _viewOrderCylinderInfo: UIView           = UIView()
    /** List of material information */
    private var _listMaterial: [[(String, Int)]]         = [[(String, Int)]]()
    /** List of cylinder information */
    private var _listCylinder: [[(String, Int)]]         = [[(String, Int)]]()
    /** Note textview */
    private var _tbxNote: UITextView                     = UITextView()
    
    // MARK: Methods
    // MARK: Override from UIViewController
    /**
     * Perform additional initialization on views that were loaded from nib files
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
