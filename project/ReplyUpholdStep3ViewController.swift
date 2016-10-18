//
//  ReplyUpholdStep3ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdStep3ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var lblStep3: UILabel!
    @IBOutlet weak var txtfName: UITextField!
    @IBOutlet weak var txtfPhone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label
         */
        lblStep3.translatesAutoresizingMaskIntoConstraints = true
        lblStep3.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2, height: GlobalConst.LABEL_HEIGHT * 1.5)
        lblStep3.text = "Xin nhập thông tin Người nghiệm thu"
        lblStep3.textAlignment = NSTextAlignment.center
        lblStep3.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        /**
         * TextField
         */
        txtfName.translatesAutoresizingMaskIntoConstraints = true
        txtfName.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: lblStep3.frame.size.height, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4, height: GlobalConst.LABEL_HEIGHT * 1.5)
        txtfName.placeholder = "  Tên"
        txtfName.tag = 0
        txtfName.delegate = self
        
        txtfPhone.translatesAutoresizingMaskIntoConstraints = true
        txtfPhone.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: lblStep3.frame.size.height + txtfName.frame.size.height, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4, height: GlobalConst.LABEL_HEIGHT * 1.5)
        txtfPhone.placeholder = "  Số điện thoại"
        txtfPhone.tag = 1
        txtfPhone.delegate = self
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(ReplyUpholdStep3ViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Textfield Delegate
    func hideKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide keyboard
        //textField.resignFirstResponder()
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if (nextResponder != nil){
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
            
        }
        else
        {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
            hideKeyboard()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtfName {
            ReplyUpholdViewController.valNameStep3 = txtfName.text!
        }
        //print(ReplyUpholdViewController.valStep3)
        if textField == txtfPhone {
        ReplyUpholdViewController.valPhoneStep3 = txtfPhone.text!
        }
        //print(ReplyUpholdViewController.valStep3)
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
