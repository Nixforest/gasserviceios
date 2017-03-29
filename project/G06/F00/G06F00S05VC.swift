//
//  G06F00S05VC.swift
//  project
//
//  Created by SPJ on 3/29/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F00S05VC: ChildViewController {
    // MARK: Properties
    /** Id */
    public static var _id:          String               = DomainConst.BLANK

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        createNavigationBar(title: DomainConst.CONTENT00296)
        // Request data from server
        if !G06F00S05VC._id.isEmpty {
            WorkingReportViewRequest.request(action: #selector(setData(_:)),
                                              view: self,
                                              id: G06F00S05VC._id)
        }
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
    
    
    /**
     * Set data after finish request server
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as? String)
        let model = WorkingReportViewRespModel(jsonString: data!)
        if model.isSuccess() {
            let offset = getTopHeight() + GlobalConst.MARGIN_CELL_Y
            let detailView: DetailInformationColumnView = DetailInformationColumnView()
            detailView.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                      y: offset,
                                      width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                      height: GlobalConst.SCREEN_HEIGHT - offset)
            var listValues = [(String, String)]()
            listValues.append((DomainConst.CONTENT00091, model.record.getCode()))
            listValues.append((DomainConst.CONTENT00055, model.record.name))
            listValues.append((DomainConst.CONTENT00063, model.record.getReportContent()))
            listValues.append((DomainConst.CONTENT00096, model.record.getCreatedDate()))
            detailView.setData(listValues: listValues)
            self.view.addSubview(detailView)
        }
    }
}
