//
//  G04F01S03MenuVC.swift
//  project
//
//  Created by SPJ on 1/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G04F01S03MenuVC: BaseMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if BaseModel.shared.checkIsLogin() {
            setItem(listValues: [false, true, false, true, true])
        } else {
            setItem(listValues: [true, false, true, false, true])
        }
        setupMenuItem()
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