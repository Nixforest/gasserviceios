//
//  G05APITestVC.swift
//  project
//
//  Created by SPJ on 4/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05APITestVC: BaseAPITestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func createData() {
        var listAPI: [ConfigBean] = [ConfigBean]()
        listAPI.append(ConfigBean(id: OrderVIPListRequest.theClassName,
                                  name: OrderVIPListRequest.theClassName))
        listAPI.append(ConfigBean(id: OrderVIPViewRequest.theClassName,
                                  name: OrderVIPViewRequest.theClassName))
        setData(listAPI: listAPI)
    }
    
    override func execute() {
        switch getCurrentAPIId() {
        case OrderVIPListRequest.theClassName:
            OrderVIPListRequest.request(
                action: #selector(finishHandler(_:)),
                view: self,
                page: Int(getParam(idx: 0))!,
                status: "1",
                from: CommonProcess.getCurrentDate(),
                to: CommonProcess.getCurrentDate(),
                customerId: DomainConst.NUMBER_ZERO_VALUE)
        case OrderVIPViewRequest.theClassName:
            OrderVIPViewRequest.request(
                action: #selector(finishHandler(_:)),
                view: self,
                id: getParam(idx: 0))
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
