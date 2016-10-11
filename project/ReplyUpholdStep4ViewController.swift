//
//  ReplyUpholdStep4ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdStep4ViewController: UIViewController, UITextViewDelegate {
    static let sharedInstance: ReplyUpholdStep4ViewController = {
        let instance = ReplyUpholdStep4ViewController()
        return instance
    }()

    var infoStep4 = String()
    
    @IBOutlet weak var lblStep4: UILabel!
    @IBOutlet weak var txtvStep4: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label
         */
        lblStep4.translatesAutoresizingMaskIntoConstraints = true
        lblStep4.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2, height: GlobalConst.LABEL_HEIGHT * 1.5)
        lblStep4.text = "Xin nhập thông tin ghi chú nội bộ"
        lblStep4.textAlignment = NSTextAlignment.center
        lblStep4.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY

        txtvStep4.translatesAutoresizingMaskIntoConstraints = true
        txtvStep4.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + lblStep4.frame.size.height, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2, height: GlobalConst.SCREEN_HEIGHT / 3)
        txtvStep4.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH * 2
        txtvStep4.layer.borderColor = GlobalConst.BUTTON_COLOR_GRAY.cgColor
        txtvStep4.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        txtvStep4.text = ""
        txtvStep4.delegate = self
        //txtvStep4.becomeFirstResponder()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(ReplyUpholdStep4ViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Textfield Delegate
    func textViewDidEndEditing(_ textView: UITextView) {
        ReplyUpholdViewController.valStep4 = txtvStep4.text
        print(txtvStep4.text)
    }
    // MARK: - dismiss Keyboard
    func hideKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //MARK: - textview become FirstResponder
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
