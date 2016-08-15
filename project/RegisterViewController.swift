//
//  RegisterViewController.swift
//  project
//
//  Created by Lâm Phạm on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerNavBar: UINavigationItem!
    @IBOutlet weak var notiNavBar: UIButton!
    @IBOutlet weak var menuNavBar: UIButton!
    
    @IBOutlet weak var imgNameIcon: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imgPhoneIcon: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var imgAddressIcon: UIImageView!
    @IBOutlet weak var txtAddress: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
