//
//  UpholdRatingStep0ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdRatingStep0ViewController: UIViewController {

    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnOption0: UIButton!
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    
    @IBAction func btnOptionTapped(_ sender: AnyObject) {
        switch sender.tag {
        case 0:
            UpholdRatingViewController.valStep0 = (btnOption0.titleLabel?.text)!
            NotificationCenter.default.post(name: Notification.Name(rawValue: "option0Chosen"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
        case 1:
            UpholdRatingViewController.valStep0 = (btnOption1.titleLabel?.text)!
            NotificationCenter.default.post(name: Notification.Name(rawValue: "option1Chosen"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
        case 2:
            UpholdRatingViewController.valStep0 = (btnOption2.titleLabel?.text)!
            NotificationCenter.default.post(name: Notification.Name(rawValue: "option2Chosen"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
        default:
            break
        }
    }
    
    // MARK: - Button Chosen
    func buttonChosen(aButton: UIButton) {
        btnOption0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnOption1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnOption2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        switch aButton.tag {
        case 0:
            btnOption0.backgroundColor = GlobalConst.BUTTON_COLOR_SELECTING
        case 1:
            btnOption1.backgroundColor = GlobalConst.BUTTON_COLOR_SELECTING
        case 2:
            btnOption2.backgroundColor = GlobalConst.BUTTON_COLOR_SELECTING
        default:
            break
        }
    }
    // MARK: button chosen Notification
    func button0Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btnOption0)
    }
    func button1Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btnOption1)
    }
    func button2Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btnOption2)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label header
         */
        lblHeader.translatesAutoresizingMaskIntoConstraints = true
        lblHeader.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.LABEL_HEIGHT)
        lblHeader.text = "Đánh giá dịch vụ"
        lblHeader.textAlignment = NSTextAlignment.center
        lblHeader.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        /**
         * Choose Problem Button 1
         */
        btnOption0.translatesAutoresizingMaskIntoConstraints = true
        btnOption0.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + GlobalConst.LABEL_HEIGHT, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        btnOption0.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnOption0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnOption0.setTitle("Hài lòng", for: .normal)
        btnOption0.setTitleColor(UIColor.white, for: .normal)
        btnOption0.tag = 0
        /**
         * Choose Problem Button 2
         */
        btnOption1.translatesAutoresizingMaskIntoConstraints = true
        btnOption1.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + GlobalConst.LABEL_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH + ((GlobalConst.BUTTON_HEIGHT * 2/3)), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        btnOption1.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnOption1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnOption1.setTitle("Bình thường", for: .normal)
        btnOption1.setTitleColor(UIColor.white, for: .normal)
        btnOption1.tag = 1
        
        /**
         * Choose Problem Button 3
         */
        btnOption2.translatesAutoresizingMaskIntoConstraints = true
        //btnOption2.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + GlobalConst.LABEL_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.PARENT_BORDER_WIDTH + ((GlobalConst.BUTTON_HEIGHT * 2/3)  * 2), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        btnOption2.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnOption2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnOption2.setTitle("Không hài lòng", for: .normal)
        btnOption2.setTitleColor(UIColor.white, for: .normal)
        btnOption2.tag = 2

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.button0Chosen(_ :)), name:NSNotification.Name(rawValue: "option0Chosen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.button1Chosen(_ :)), name:NSNotification.Name(rawValue: "option1Chosen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.button2Chosen(_ :)), name:NSNotification.Name(rawValue: "option2Chosen"), object: nil)
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
