//
//  UpholdRatingStep2ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdRatingStep2ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var txtvFeedback: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label header
         */
        lblHeader.translatesAutoresizingMaskIntoConstraints = true
        lblHeader.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH , y: GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4, height: GlobalConst.LABEL_HEIGHT)
        lblHeader.text = "Đánh giá nhân viên bảo trì"
        lblHeader.textAlignment = NSTextAlignment.center
        lblHeader.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        lblHeader.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        lblHeader.textColor = UIColor.white
        /**
         * textview Feedback
         */
        txtvFeedback.translatesAutoresizingMaskIntoConstraints = true
        txtvFeedback.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: lblHeader.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH, width: self.view.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 4), height: self.view.frame.size.height * 0.5)
        txtvFeedback.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH * 2
        txtvFeedback.layer.borderColor = GlobalConst.BUTTON_COLOR_GRAY.cgColor
        txtvFeedback.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        txtvFeedback.text = ""
        txtvFeedback.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UpholdRatingStep2ViewController.hideKeyboard))
        view.addGestureRecognizer(tap)

        txtvFeedback.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Textfield Delegate
    func textViewDidEndEditing(_ textView: UITextView) {
        UpholdRatingViewController.valStep2 = txtvFeedback.text
        print(txtvFeedback.text)
    }
    // MARK: - dismiss Keyboard
    func hideKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
