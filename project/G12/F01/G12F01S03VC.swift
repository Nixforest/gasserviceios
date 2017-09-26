//
//  G12F01S03VC.swift
//  project
//
//  Created by SPJ on 9/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class G12F01S03VC: G04F01S02VC {

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
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        G12F01S01VC._gasSelected = self.getData(index: indexPath.row)
        self.backButtonTapped(self)
    }

}
