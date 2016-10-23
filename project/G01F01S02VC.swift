//
//  CreateUpholdStep2ViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F01S02VC: UIViewController {
    
    @IBOutlet weak var lblChooseContact: UILabel!
    
    @IBOutlet weak var btnContactType1: UIButton!
    @IBOutlet weak var btnContactType2: UIButton!
    @IBOutlet weak var btnContactType3: UIButton!
    @IBOutlet weak var btnContactType4: UIButton!

    
    @IBAction func btnContactType1Tapped(_ sender: AnyObject) {
        G01F01VC.sharedInstance.contactType = (btnContactType1.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step2Done"), object: nil)
        print(G01F01VC.sharedInstance.contactType)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showDetail"), object: nil)
    }
    @IBAction func btnContactType2Tapped(_ sender: AnyObject) {
        G01F01VC.sharedInstance.contactType = (btnContactType2.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step2Done"), object: nil)
        print(G01F01VC.sharedInstance.contactType)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showDetail"), object: nil)
    }
    @IBAction func btnContactType3Tapped(_ sender: AnyObject) {
        G01F01VC.sharedInstance.contactType = (btnContactType3.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step2Done"), object: nil)
        print(G01F01VC.sharedInstance.contactType)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showDetail"), object: nil)
    }
    @IBAction func btnContactType4Tapped(_ sender: AnyObject) {
        var inputTextFieldName:UITextField?
        var inputTextFieldPhone:UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Sự cố khác", message: "", preferredStyle: .alert)
            //Add a text field
            actionSheetController.addTextField {
                (textFieldName: UITextField!) in
                textFieldName.placeholder = "Nhập họ tên"
                inputTextFieldName = textFieldName
            }
            actionSheetController.addTextField {
                    (textFieldPhone: UITextField!) in
                    textFieldPhone.placeholder = "Nhập số điện thoại"
                inputTextFieldPhone = textFieldPhone
                
            }
        
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Huỷ", style: .cancel) { action -> Void in
                //Do some stuff
            }
            actionSheetController.addAction(cancelAction)
            //Create and an option action
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                G01F01VC.sharedInstance.contactType = (inputTextFieldName?.text)! + " - " + (inputTextFieldPhone?.text)!
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step2Done"), object: nil)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "showDetail"), object: nil)
                print(G01F01VC.sharedInstance.contactType)
            }
            actionSheetController.addAction(okAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Background
         */
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label Choose Contact Type
         */
        lblChooseContact.translatesAutoresizingMaskIntoConstraints = true
        lblChooseContact.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.LABEL_HEIGHT)
        lblChooseContact.text = "Xin vui lòng chọn Người liên hệ"
        lblChooseContact.textAlignment = NSTextAlignment.center
        lblChooseContact.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Choose Problem Button 1
         */
        btnContactType1.translatesAutoresizingMaskIntoConstraints = true
        btnContactType1.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnContactType1.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnContactType1.layer.borderColor = UIColor.green.cgColor
        btnContactType1.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnContactType1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnContactType1.setTitle("Chủ quán", for: .normal)
        btnContactType1.setTitleColor(UIColor.white, for: .normal)
        /**
         * Choose Problem Button 2
         */
        btnContactType2.translatesAutoresizingMaskIntoConstraints = true
        btnContactType2.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + ((GlobalConst.BUTTON_HEIGHT * 2/3)), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnContactType2.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnContactType2.layer.borderColor = UIColor.green.cgColor
        btnContactType2.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnContactType2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnContactType2.setTitle("Người quản lý", for: .normal)
        btnContactType2.setTitleColor(UIColor.white, for: .normal)
        /**
         * Choose Problem Button 3
         */
        btnContactType3.translatesAutoresizingMaskIntoConstraints = true
        btnContactType3.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + ((GlobalConst.BUTTON_HEIGHT * 2/3) * 2), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnContactType3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnContactType3.layer.borderColor = UIColor.green.cgColor
        btnContactType3.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnContactType3.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnContactType3.setTitle("Nhân viên kỹ thuật", for: .normal)
        btnContactType3.setTitleColor(UIColor.white, for: .normal)
        /**
         * Choose Problem Button 4
         */
        btnContactType4.translatesAutoresizingMaskIntoConstraints = true
        btnContactType4.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + ((GlobalConst.BUTTON_HEIGHT * 2/3) * 3), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnContactType4.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnContactType4.layer.borderColor = UIColor.green.cgColor
        btnContactType4.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnContactType4.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnContactType4.setTitle("Khác", for: .normal)
        btnContactType4.setTitleColor(UIColor.white, for: .normal)


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
