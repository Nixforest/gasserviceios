//
//  G06APITestVC.swift
//  project
//
//  Created by SPJ on 3/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06APITestVC: BaseAPITestViewController {

    override func viewDidLoad() {
        var listAPI: [ConfigBean] = [ConfigBean]()
        listAPI.append(ConfigBean(id: "CustomerFamilyListRequest", name: "Customer List API"))
        listAPI.append(ConfigBean(id: "CustomerFamilyViewRequest", name: "Customer View API"))
        listAPI.append(ConfigBean(id: "WorkingReportListRequest", name: "Working report list API"))
        listAPI.append(ConfigBean(id: "WorkingReportViewRequest", name: "Working report View API"))
        setData(listAPI: listAPI)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func execute() {
        switch getCurrentAPIId() {
        case "CustomerFamilyListRequest":
            CustomerFamilyListRequest.request(
                action: #selector(finishHandler(_:)),
                view: self,
                buying: getParam(idx: 0),
                dateFrom: getParam(idx: 1),
                dateTo: getParam(idx: 2),
                page: getParam(idx: 3))
            break
        case "CustomerFamilyViewRequest":
            CustomerFamilyViewRequest.request(
                action: #selector(finishHandler(_:)),
                view: self,
                customer_id: getParam(idx: 0))
            break
        case "WorkingReportListRequest":
            WorkingReportListRequest.request(
                action: #selector(finishHandler(_:)),
                view: self,
                dateFrom: getParam(idx: 0),
                dateTo: getParam(idx: 1),
                page: getParam(idx: 2))
            break
        case "WorkingReportViewRequest":
            WorkingReportViewRequest.request(
                action: #selector(finishHandler(_:)),
                view: self,
                id: getParam(idx: 0))
            break
        default: break
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
