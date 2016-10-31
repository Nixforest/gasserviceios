//
//  ReplyUpholdStep2ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdStep2ViewController: UIViewController {


    
    @IBOutlet weak var txtvStep2: UITextView!
    
    @IBOutlet weak var btn1Step2: UIButton!
    @IBOutlet weak var btn2Step2: UIButton!
    
    @IBAction func btn1Step2Tapped(_ sender: AnyObject) {
        ReplyUpholdViewController.valStep2 = (btn1Step2.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step2Done"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "btn1Step2Chosen"), object: nil)
    }
    @IBAction func btn2Step2Tapped(_ sender: AnyObject) {
        ReplyUpholdViewController.valStep2 = (btn2Step2.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step2Done"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "btn2Step2Chosen"), object: nil)
    }
    
    // MARK: - Button Chosen
    func buttonChosen(aButton: UIButton) {
        switch aButton.tag {
        case 0:
            btn1Step2.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
            btn2Step2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        case 1:
            btn1Step2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btn2Step2.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
        default:
            break
        }
    }
    func btn1Step2Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btn1Step2)
    }
    func btn2Step2Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btn2Step2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label
         */
        txtvStep2.translatesAutoresizingMaskIntoConstraints = true
        txtvStep2.frame = CGRect(x: GlobalConst.SCREEN_WIDTH * 0.15, y: 0, width: GlobalConst.SCREEN_WIDTH * 0.7, height: GlobalConst.LABEL_HEIGHT * 2)
        txtvStep2.text = "Xin vui lòng đánh giá thông tin của khách hàng"
        txtvStep2.textAlignment = NSTextAlignment.center
        txtvStep2.font = UIFont.systemFont(ofSize: 17)
        txtvStep2.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // MARK: - Button Frame
        /**
         *  Button 1
         */
        btn1Step2.translatesAutoresizingMaskIntoConstraints = true
        btn1Step2.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + txtvStep2.frame.size.height, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT)
        //btn1Step2.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btn1Step2.layer.borderColor = UIColor.green.cgColor
        btn1Step2.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btn1Step2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btn1Step2.setTitle("Khách hàng báo ĐÚNG sự cố", for: .normal)
        btn1Step2.setTitleColor(UIColor.white, for: .normal)
        btn1Step2.titleLabel?.font = UIFont(name: "", size: 20)
        btn1Step2.tag = 0
        /**
         *  Button 2
         */
        btn2Step2.translatesAutoresizingMaskIntoConstraints = true
        btn2Step2.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + txtvStep2.frame.size.height + GlobalConst.BUTTON_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT)
        //btn2Step2.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btn2Step2.layer.borderColor = UIColor.green.cgColor
        btn2Step2.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btn2Step2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btn2Step2.setTitle("Khách hàng báo SAI sự cố", for: .normal)
        btn2Step2.setTitleColor(UIColor.white, for: .normal)
        btn2Step2.titleLabel?.font = UIFont(name: "", size: 20)
        btn2Step2.tag = 1

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.btn1Step2Chosen(_ :)), name:NSNotification.Name(rawValue: "btn1Step2Chosen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.btn2Step2Chosen(_ :)), name:NSNotification.Name(rawValue: "btn2Step2Chosen"), object: nil)
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
