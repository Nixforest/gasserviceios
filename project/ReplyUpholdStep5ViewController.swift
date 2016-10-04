//
//  ReplyUpholdStep5ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdStep5ViewController: UIViewController {
    
    static let sharedInstance: ReplyUpholdStep5ViewController = {
        let instance = ReplyUpholdStep5ViewController()
        return instance
    }()

    @IBOutlet weak var lblStep5: UILabel!
    
    @IBOutlet weak var btnPickImageStep5: UIButton!
    
    @IBOutlet weak var viewPickImageStep5: UIView!
    
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
