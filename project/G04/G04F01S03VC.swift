//
//  G04F01S03.swift
//  project
//
//  Created by SPJ on 1/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G04F01S03VC: MaterialSelectViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // NavBar setup
        setupNavigationBar(title: DomainConst.CONTENT00238, isNotifyEnable: BaseModel.shared.checkIsLogin(), isHiddenBackBtn: false)
    }
    
    public static func setData(data: [MaterialBean]) {
        MaterialSelectViewController.setMaterialData(data: data)
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
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MapViewController._promoteSelected = self.getData(index: indexPath.row)
        self.backButtonTapped(self)
    }
}
