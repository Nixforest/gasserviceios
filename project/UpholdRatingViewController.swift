//
//  UpholdRatingViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdRatingViewController: CommonViewController {
    
    static let sharedInstance: UpholdRatingViewController = {
        let instance = UpholdRatingViewController()
        return instance
    }()
    
    var isStep0Done:Bool = false
    var isStep1Done:Bool = false
    var isStep2Done:Bool = false
    
    static var valStep0 = String()
    static var valStep1Rating0 = String()
    static var valStep1Rating1 = String()
    static var valStep2 = String()

    @IBOutlet weak var ctnviewRatingStep0: UIView!
    @IBOutlet weak var ctnviewRatingStep1: UIView!
    @IBOutlet weak var ctnviewRatingStep2: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var viewBtn: UIView!
    @IBOutlet weak var btnStep0: UIButton!
    @IBOutlet weak var btnStep1: UIButton!
    @IBOutlet weak var btnStep2: UIButton!
    @IBOutlet weak var viewBackground: UIView!
    
    
    // MARK: - Button Action
    @IBAction func btnBackTapped(_ sender: AnyObject) {
        if ctnviewRatingStep1.isHidden == false {
            self.showContainerView(aCtnView: ctnviewRatingStep0)
        }
        if ctnviewRatingStep2.isHidden == false {
            self.showContainerView(aCtnView: ctnviewRatingStep1)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "hideBtnSend"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
        }
    }
    @IBAction func btnNextTapped(_ sender: AnyObject) {
        // 0->1
        if ctnviewRatingStep0.isHidden == false {
            checkValidData(viewStep: ctnviewRatingStep0)
        }else {
            // 1->2
            if ctnviewRatingStep1.isHidden == false {
                checkValidData(viewStep: ctnviewRatingStep1)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnSend"), object: nil)
            }
        }
    }
    @IBAction func btnSendTapped(_ sender: AnyObject) {
    }
    @IBAction func btnStepTapped(_ sender: AnyObject) {
        switch sender.tag {
        case 0:
            self.showContainerView(aCtnView: ctnviewRatingStep0)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep0ButtonToMiddle"), object: nil)
        case 1:
            self.showContainerView(aCtnView: ctnviewRatingStep1)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep1ButtonToMiddle"), object: nil)
        case 2:
            self.showContainerView(aCtnView: ctnviewRatingStep2)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep2ButtonToMiddle"), object: nil)
        default:
            break
        }
    }
    // MARK: - show containerView
    func showContainerView(aCtnView: UIView) {
        switch aCtnView.tag {
        case 0:
            ctnviewRatingStep0.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep0ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "hideBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
            ctnviewRatingStep1.isHidden = true
            ctnviewRatingStep2.isHidden = true
        case 1:
            ctnviewRatingStep0.isHidden = true
            ctnviewRatingStep1.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep1ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnNext"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "hideBtnSend"), object: nil)
            ctnviewRatingStep2.isHidden = true
        case 2:
            ctnviewRatingStep0.isHidden = true
            ctnviewRatingStep1.isHidden = true
            ctnviewRatingStep2.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep2ButtonToMiddle"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "hideBtnNext"), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnSend"), object: nil)
        default:
            break
        }
    }
    // MARK: checkValidData
    func checkValidData(viewStep: UIView) {
        switch viewStep.tag {
        case 0:
            if UpholdRatingViewController.valStep0.isEmpty == true {
                let nextAlert = UIAlertController(title: "",
                                                  message: GlobalConst.CONTENT00028,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                             style: .cancel,
                                             handler: {(notificationAlert) -> Void in ()})
                nextAlert.addAction(okAction)
                self.present(nextAlert, animated: true, completion: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step0Done"), object: nil)
                self.showContainerView(aCtnView: ctnviewRatingStep1)
            }
        case 1:
            if (UpholdRatingViewController.valStep1Rating0.isEmpty == true) || (UpholdRatingViewController.valStep1Rating1.isEmpty == true) {
                let nextAlert = UIAlertController(title: "",
                                                  message: GlobalConst.CONTENT00028,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: GlobalConst.CONTENT00008,
                                             style: .cancel,
                                             handler: {(notificationAlert) -> Void in ()})
                nextAlert.addAction(okAction)
                self.present(nextAlert, animated: true, completion: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
                self.showContainerView(aCtnView: ctnviewRatingStep2)
            }
        default:
            break
        }
    }
    // MARK: - Step done
    func step0Done (_ notification: Notification) {
        isStep0Done = true
        btnStep0.isEnabled = isStep0Done
        btnStep1.isEnabled = isStep0Done
        btnStep0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self.showContainerView(aCtnView: ctnviewRatingStep1)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep1ButtonToMiddle"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showBtnBack"), object: nil)
    }
    func step1Done (_ notification: Notification) {
        isStep1Done = true
        btnStep2.isEnabled = isStep1Done
        btnStep1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self.showContainerView(aCtnView: ctnviewRatingStep2)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep2ButtonToMiddle"), object: nil)
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "showCtnViewStep2"), object: nil)
    }
    func step2Done (_ notification: Notification) {
        isStep2Done = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveStep3ButtonToMiddle"), object: nil)
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "showCtnViewStep3"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "hideBtnNext"), object: nil)
    }
    //MARK: move btn to middle
    func moveStep0ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnStep0)
        //check status of Button
        setBtnColor(aButton: btnStep1)
        setBtnColor(aButton: btnStep2)
        
    }
    func moveStep1ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnStep1)
        //check status of Button
        setBtnColor(aButton: btnStep0)
        setBtnColor(aButton: btnStep2)
    }
    func moveStep2ButtonToMiddle(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnStep2)
        //check status of Button
        setBtnColor(aButton: btnStep0)
        setBtnColor(aButton: btnStep1)
    }
    // MARK: - Set button color
    func setBtnColor(aButton: UIButton) {
        if aButton.isEnabled == true {
            aButton.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        } else {
            aButton.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        }
    }
    func moveButtonToMiddle(aButton:UIButton) {
        switch aButton.tag {
        case 0:
            viewBtn.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width:GlobalConst.BUTTON_HEIGHT * 7 , height: GlobalConst.BUTTON_HEIGHT)
        case 1:
            viewBtn.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width:GlobalConst.BUTTON_HEIGHT * 7 , height: GlobalConst.BUTTON_HEIGHT)
        case 2:
            viewBtn.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT * 2) + GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width:GlobalConst.BUTTON_HEIGHT * 7 , height: GlobalConst.BUTTON_HEIGHT)
        default:
            break
        }
    }
    
    func showBtnBack(_ notification: Notification) {
        if ctnviewRatingStep0.isHidden == true {
            btnBack.isHidden = false
        }
    }
    func hideBtnNext(_ notification: Notification) {
        if ctnviewRatingStep2.isHidden == false {
            btnNext.isHidden = true
        }
    }
    func hideBtnBack(_ notification: Notification) {
        if ctnviewRatingStep0.isHidden == false {
            btnBack.isHidden = true
        }
    }
    func showBtnNext(_ notification: Notification) {
        if ctnviewRatingStep2.isHidden == true {
            btnNext.isHidden = false
        }
    }
    func showBtnSend(_ notification: Notification) {
        if ctnviewRatingStep2.isHidden == false {
            btnSend.isHidden = false
        }
    }
    func hideBtnSend(_ notification: Notification) {
        if ctnviewRatingStep2.isHidden == true {
            btnSend.isHidden = true
        }
    }
    // MARK: - ViewDidLoad
     override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Background
        viewBackground.translatesAutoresizingMaskIntoConstraints = true
        viewBackground.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        viewBackground.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        viewBackground.frame = CGRect(x: 0, y: (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT), width: (GlobalConst.SCREEN_WIDTH), height: (GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT)))
        viewBackground.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        // Btn Back
        btnBack.translatesAutoresizingMaskIntoConstraints = true
        btnBack.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: viewBackground.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH - GlobalConst.BUTTON_HEIGHT * 2, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnBack.setImage(UIImage(named: "back.png"), for: UIControlState())
        btnBack.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnBack.tintColor = UIColor.white
        btnBack.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnBack.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnBack.layer.borderColor = GlobalConst.BUTTON_COLOR_GRAY.cgColor
        btnBack.isHidden = !isStep0Done
        viewBackground.addSubview(btnBack)
        //Btn Next
        btnNext.translatesAutoresizingMaskIntoConstraints = true
        btnNext.frame = CGRect(x: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH - GlobalConst.BUTTON_HEIGHT, y: viewBackground.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH - GlobalConst.BUTTON_HEIGHT * 2, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnNext.setImage(UIImage(named: "back.png"), for: UIControlState())
        btnNext.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
        btnNext.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnNext.tintColor = UIColor.white
        btnNext.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnNext.layer.borderColor = GlobalConst.BUTTON_COLOR_GRAY.cgColor
        btnNext.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnNext.isHidden = isStep2Done
        viewBackground.addSubview(btnNext)
        /**
         * Button Send Info
         */
        btnSend.translatesAutoresizingMaskIntoConstraints = true
        btnSend.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT) , y: viewBackground.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH - (GlobalConst.BUTTON_HEIGHT * 2), width: GlobalConst.BUTTON_HEIGHT * 2, height: GlobalConst.BUTTON_HEIGHT)
        btnSend.setTitle("Gửi", for: .normal)
        btnSend.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnSend.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnSend.tintColor = UIColor.white
        btnSend.isHidden = true
        viewBackground.addSubview(btnSend)
        
        // MARK: - containerView show/hide in initiation
        ctnviewRatingStep0.isHidden = false
        ctnviewRatingStep1.isHidden = true
        ctnviewRatingStep2.isHidden = true
        
        // MARK: - ContainerView Frame
        ctnviewRatingStep0.translatesAutoresizingMaskIntoConstraints = true
        ctnviewRatingStep0.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + (GlobalConst.BUTTON_HEIGHT * 2)))
        ctnviewRatingStep0.tag = 0
        viewBackground.addSubview(ctnviewRatingStep0)
        ctnviewRatingStep0.backgroundColor = UIColor.red
        
        ctnviewRatingStep1.translatesAutoresizingMaskIntoConstraints = true
        ctnviewRatingStep1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewRatingStep1.tag = 1
        ctnviewRatingStep0.backgroundColor = UIColor.green
        
        ctnviewRatingStep2.translatesAutoresizingMaskIntoConstraints = true
        ctnviewRatingStep2.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        ctnviewRatingStep2.tag = 2
        ctnviewRatingStep0.backgroundColor = UIColor.brown
        //MARK: - view Button
        viewBtn.translatesAutoresizingMaskIntoConstraints = true
        viewBtn.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) + GlobalConst.PARENT_BORDER_WIDTH,
                                     y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH,
                                     width:GlobalConst.BUTTON_HEIGHT * 7 ,
                                     height: GlobalConst.BUTTON_HEIGHT)
        viewBtn.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // Btn 0
        btnStep0.translatesAutoresizingMaskIntoConstraints = true
        btnStep0.frame = CGRect(x: 0, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnStep0.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnStep0.setTitle("1", for: .normal)
        btnStep0.setTitleColor(UIColor.white , for: .normal)
        btnStep0.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
        btnStep0.tag = 0
        viewBtn.addSubview(btnStep0)
        // Btn 1
        btnStep1.translatesAutoresizingMaskIntoConstraints = true
        btnStep1.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnStep1.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnStep1.setTitle("2", for: .normal)
        btnStep1.setTitleColor(UIColor.white , for: .normal)
        btnStep1.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        btnStep1.tag = 1
        viewBtn.addSubview(btnStep1)
        // Btn 2
        btnStep2.translatesAutoresizingMaskIntoConstraints = true
        btnStep2.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT * 2, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnStep2.layer.cornerRadius = 0.5 * GlobalConst.BUTTON_HEIGHT
        btnStep2.setTitle("3", for: .normal)
        btnStep2.setTitleColor(UIColor.white , for: .normal)
        btnStep2.backgroundColor = GlobalConst.BUTTON_COLOR_DISABLE
        btnStep2.tag = 2
        viewBtn.addSubview(btnStep2)

        btnStep0.isEnabled = false
        btnStep1.isEnabled = false
        btnStep2.isEnabled = false
        
        // Do any additional setup after loading the view.
        // MARK: - Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.step0Done(_:)), name:NSNotification.Name(rawValue: "step0Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.step1Done(_:)), name:NSNotification.Name(rawValue: "step1Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.step2Done(_:)), name:NSNotification.Name(rawValue: "step2Done"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.moveStep0ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep0ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.moveStep1ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep1ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.moveStep2ButtonToMiddle(_:)), name:NSNotification.Name(rawValue: "moveStep2ButtonToMiddle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.showBtnBack(_:)), name:NSNotification.Name(rawValue: "showBtnBack"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.hideBtnBack(_:)), name:NSNotification.Name(rawValue: "hideBtnBack"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.hideBtnNext(_:)), name:NSNotification.Name(rawValue: "hideBtnNext"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.showBtnNext(_:)), name:NSNotification.Name(rawValue: "showBtnNext"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.showBtnSend(_:)), name:NSNotification.Name(rawValue: "showBtnSend"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdRatingViewController.hideBtnSend(_:)), name:NSNotification.Name(rawValue: "hideBtnSend"), object: nil)
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
