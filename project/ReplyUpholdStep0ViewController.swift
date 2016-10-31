//
//  ReplyUpholdStep0ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/1/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdStep0ViewController: UIViewController {
    

    
    
    @IBOutlet weak var lblChoseProblem: UILabel!
    
    
    @IBOutlet weak var btnProblem0: UIButton!
    @IBOutlet weak var btnProblem1: UIButton!
    @IBOutlet weak var btnProblem2: UIButton!
    @IBOutlet weak var btnProblem3: UIButton!
    @IBOutlet weak var btnProblem4: UIButton!
    
    @IBOutlet weak var btnNextStep: UIButton!
    
    
    @IBAction func btnProblem0Tapped(_ sender: AnyObject) {
        ReplyUpholdViewController.valStep0 = (btnProblem0.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "button0Chosen"), object: nil)
    }
    @IBAction func btnProblem1Tapped(_ sender: AnyObject) {
        ReplyUpholdViewController.valStep0 = (btnProblem1.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "button1Chosen"), object: nil)
    }
    @IBAction func btnProblem2Tapped(_ sender: AnyObject) {
        ReplyUpholdViewController.valStep0 = (btnProblem2.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "button2Chosen"), object: nil)
    }
    @IBAction func btnProblem3Tapped(_ sender: AnyObject) {
        ReplyUpholdViewController.valStep0 = (btnProblem3.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "button3Chosen"), object: nil)
    }
    @IBAction func btnProblem4Tapped(_ sender: AnyObject) {
        ReplyUpholdViewController.valStep0 = (btnProblem4.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "button4Chosen"), object: nil)
    }
    
    @IBAction func btnNextStepTapped(_ sender: AnyObject) {
    }
    // MARK: - Button Chosen
    func buttonChosen(aButton: UIButton) {
        switch aButton.tag {
        case 0:
            btnProblem0.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
            btnProblem1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem3.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem4.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        case 1:
            btnProblem0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem1.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
            btnProblem2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem3.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem4.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        case 2:
            btnProblem0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem2.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
            btnProblem3.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem4.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        case 3:
            btnProblem0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem3.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
            btnProblem4.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        case 4:
            btnProblem0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem3.backgroundColor = GlobalConst.BUTTON_COLOR_RED
            btnProblem4.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
        default:
            break
        }
    }
    
    func button0Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btnProblem0)
    }
    func button1Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btnProblem1)
    }
    func button2Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btnProblem2)
    }
    func button3Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btnProblem3)
    }
    func button4Chosen(_ notification: Notification) {
        self.buttonChosen(aButton: btnProblem4)
    }
    
    // MARK : -- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label
         */
        lblChoseProblem.translatesAutoresizingMaskIntoConstraints = true
        lblChoseProblem.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.LABEL_HEIGHT)
        lblChoseProblem.text = "Xin vui lòng chọn Trạng thái sự cố"
        lblChoseProblem.textAlignment = NSTextAlignment.center
        lblChoseProblem.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // MARK: - Problem Button Frame
        /**
         * Choose Problem Button 1
         */
        btnProblem0.translatesAutoresizingMaskIntoConstraints = true
        btnProblem0.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem0.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem0.layer.borderColor = UIColor.green.cgColor
        btnProblem0.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem0.setTitle("Mới", for: .normal)
        btnProblem0.setTitleColor(UIColor.white, for: .normal)
        btnProblem0.tag = 0
        /**
         * Choose Problem Button 2
         */
        btnProblem1.translatesAutoresizingMaskIntoConstraints = true
        btnProblem1.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH + (btnProblem0.frame.size.height + GlobalConst.PARENT_BORDER_WIDTH), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem1.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem1.layer.borderColor = UIColor.green.cgColor
        btnProblem1.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem1.setTitle("Xử lý", for: .normal)
        btnProblem1.setTitleColor(UIColor.white, for: .normal)
        btnProblem1.tag = 1
        /**
         * Choose Problem Button 3
         */
        btnProblem2.translatesAutoresizingMaskIntoConstraints = true
        btnProblem2.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH + (btnProblem0.frame.size.height + GlobalConst.PARENT_BORDER_WIDTH) * 2 , width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem2.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem2.layer.borderColor = UIColor.green.cgColor
        btnProblem2.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem2.setTitle("Hoàn thành", for: .normal)
        btnProblem2.setTitleColor(UIColor.white, for: .normal)
        btnProblem2.tag = 2
        /**
         * Choose Problem Button 4
         */
        btnProblem3.translatesAutoresizingMaskIntoConstraints = true
        btnProblem3.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + (btnProblem0.frame.size.height + GlobalConst.PARENT_BORDER_WIDTH) * 3 + GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem3.layer.borderColor = UIColor.green.cgColor
        btnProblem3.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem3.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem3.setTitle("Yêu cầu chuyển", for: .normal)
        btnProblem3.setTitleColor(UIColor.white, for: .normal)
        btnProblem3.tag = 3
        /**
         * Choose Problem Button 5
         */
        btnProblem4.translatesAutoresizingMaskIntoConstraints = true
        btnProblem4.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + (btnProblem0.frame.size.height + GlobalConst.PARENT_BORDER_WIDTH) * 4 + GlobalConst.PARENT_BORDER_WIDTH , width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem4.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem4.layer.borderColor = UIColor.green.cgColor
        btnProblem4.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem4.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem4.setTitle("Xử lý dài ngày", for: .normal)
        btnProblem4.setTitleColor(UIColor.white, for: .normal)
        btnProblem4.tag = 4
        
        /**
         * button Next
         */
        btnNextStep.translatesAutoresizingMaskIntoConstraints = true
        
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.button0Chosen(_ :)), name:NSNotification.Name(rawValue: "button0Chosen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.button1Chosen(_ :)), name:NSNotification.Name(rawValue: "button1Chosen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.button2Chosen(_ :)), name:NSNotification.Name(rawValue: "button2Chosen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.button3Chosen(_ :)), name:NSNotification.Name(rawValue: "button3Chosen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.button4Chosen(_ :)), name:NSNotification.Name(rawValue: "button4Chosen"), object: nil)

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
