//
//  PopTableViewController.swift
//  project
//
//  Created by SPJ on 9/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework

//++ BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
//Pop Up Select Material By Module
class PopTableViewController: BaseChildViewController, UITableViewDelegate, UITableViewDataSource {
    /** Current selected list material */
    public static var _selectedList:   [OrderDetailBean]   = [OrderDetailBean].init()  
    /** Button Ok */
    @IBOutlet weak var btnOk: UIButton!
    /** Button Cancel */
    @IBOutlet weak var btnCancel: UIButton!
    /** View Pop Up */
    @IBOutlet weak var Popupview: UIView!
    /** Table View Material */
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Table View
        tableView.dataSource = self 
        tableView.delegate = self 
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        // Apply radius to Popupview
        Popupview.layer.cornerRadius = 10
        Popupview.layer.masksToBounds = true
        //custom button 
        btnOk.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnOk.layer.cornerRadius = 15
        btnCancel.backgroundColor = GlobalConst.BUTTON_COLOR_YELLOW
        btnCancel.layer.cornerRadius = 15
    }
    
    // Returns count of items in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.names.count;
        return G17F00S03VC._dataClientCache.count
    }
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            for (index, orderDetailBean) in PopTableViewController._selectedList.enumerated(){
                if orderDetailBean.module_id == G17F00S03VC._dataClientCache[indexPath.row].module_id{
                    PopTableViewController._selectedList.remove(at: index)
                }
            }
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            PopTableViewController._selectedList.append(G17F00S03VC._dataClientCache[indexPath
                        .row])
            
        }
        // save the value in the array
        let index = (indexPath as NSIndexPath).row
        G17F00S03VC._dataClientCache[index].enabled = !G17F00S03VC._dataClientCache[index].enabled
        
    }
    
    //Assign values for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: ModuleCell  = tableView.dequeueReusableCell(
            withIdentifier: "ModuleCell1")
            as! ModuleCell
        cell.lblModuleName.text = G17F00S03VC._dataClientCache[indexPath.row].module_name
        cell.accessoryType = G17F00S03VC._dataClientCache[indexPath.row].enabled ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
//        cell.layer.borderColor = UIColor.darkGray.cgColor
//        cell.layer.borderWidth = 0.5
        return cell
    }
    
    /**
     * Get current selected list
     * - returns: Selected list
     */
    public static func getSelectedList() -> [OrderDetailBean] {
        return PopTableViewController._selectedList
    }
    
    /**
     * Set current selected item
     * - parameter item: Selected item
     */
    public static func setSelectedList(item: [OrderDetailBean]) {
        PopTableViewController._selectedList = item
    }
    
    // Close PopUp
    @IBAction func closePopup(_ sender: Any) {
        PopTableViewController._selectedList.removeAll()
        //self.animationControllerForDismissedController(dismissed: self)
        dismiss(animated: true, completion: nil)
    }
    // Accept List Material
    @IBAction func acceptListMaterial(_ sender: Any) {
        //print(PopTableViewController._selectedList.count)
        G17F00S03VC._selectedList = PopTableViewController._selectedList
        dismiss(animated: true, completion: nil)
    }
}
//-- BUG0218-SPJ (KhoiVT 20180906) Gasservice - Update Screen. Change Select Material by Pop Up, add field action invest of Customer Request Function
