//
//  G06F00S02VC.swift
//  project
//
//  Created by SPJ on 3/29/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F00S02VC: ChildViewController {
    // MARK: Properties
    /** Id */
    public static var _id:          String               = DomainConst.BLANK

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        createNavigationBar(title: DomainConst.CONTENT00288)
        
        // Request data from server
        if !G06F00S02VC._id.isEmpty {
            CustomerFamilyViewRequest.request(action: #selector(setData(_:)),
                                              view: self,
                                              customer_id: G06F00S02VC._id)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Set data after finish request server
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as? String)
        let model = CustomerFamilyViewRespModel(jsonString: data!)
        if model.isSuccess() {
            let offset = getTopHeight() + GlobalConst.MARGIN_CELL_Y
            let detailView: DetailInformationColumnView = DetailInformationColumnView()
            detailView.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                        y: offset,
                                      width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                      height: GlobalConst.SCREEN_HEIGHT - offset)
            var listValues = [(String, String)]()
            listValues.append((DomainConst.CONTENT00079, model.record.name))
            listValues.append((DomainConst.CONTENT00152, model.record.phone))
            listValues.append((DomainConst.CONTENT00289, model.record.customer_type))
            listValues.append((DomainConst.CONTENT00088, model.record.address))
            listValues.append((DomainConst.CONTENT00290, model.record.latitude_longitude))
            listValues.append((DomainConst.CONTENT00291, model.record.hgd_type))
            listValues.append((DomainConst.CONTENT00292, model.record.hgd_time_use))
            listValues.append((DomainConst.CONTENT00293, model.record.hgd_thuong_hieu))
            listValues.append((DomainConst.CONTENT00294, model.record.hgd_doi_thu))
            listValues.append((DomainConst.CONTENT00109, model.record.serial))
            listValues.append((DomainConst.CONTENT00163, model.record.list_hgd_invest_text))
            listValues.append((DomainConst.CONTENT00095, model.record.created_by))
            listValues.append((DomainConst.CONTENT00096, model.record.created_date))
            detailView.setData(listValues: listValues)
            self.view.addSubview(detailView)
        }
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
