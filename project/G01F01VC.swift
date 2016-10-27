//
//  CreateUpholdViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F01VC: CommonViewController, UIPopoverPresentationControllerDelegate {
    /**
     * Singleton instance.
     */
    static let sharedInstance: G01F01VC = {
        let instance = G01F01VC()
        return instance
    }()
    
    var problemType:String = ""
    var anotherProblemType:String = ""
    var contactType:String = ""

    var isStep1Done:Bool = false
    var isStep2Done:Bool = false
    var isStep3Done:Bool = false
    
    @IBOutlet weak var viewBackground: UIView!

    @IBOutlet weak var btnCreateUpholdStep1: UIButton!
    @IBOutlet weak var btnCreateUpholdStep2: UIButton!
    @IBOutlet weak var btnCreateUpholdStep3: UIButton!
    
    @IBOutlet weak var ctnViewCreateUpholdStep1: UIView!
    @IBOutlet weak var ctnViewCreateUpholdStep2: UIView!
    @IBOutlet weak var ctnViewCreateUpholdStep3: UIView!
    
    @IBOutlet weak var viewScrollButton: UIView!
    
    @IBAction func btnCreateUpholdStep1Tapped(_ sender: AnyObject) {
        ctnViewCreateUpholdStep1.isHidden = false
        ctnViewCreateUpholdStep2.isHidden = true
        ctnViewCreateUpholdStep3.isHidden = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveButtonStep1"), object: nil)
        print(G01F01VC.sharedInstance.problemType)

    }
    @IBAction func btnCreateUpholdStep2Tapped(_ sender: AnyObject) {
        ctnViewCreateUpholdStep1.isHidden = true
        ctnViewCreateUpholdStep2.isHidden = false
        ctnViewCreateUpholdStep3.isHidden = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveButtonStep2"), object: nil)
    }
    @IBAction func btnCreateUpholdStep3Tapped(_ sender: AnyObject) {
        ctnViewCreateUpholdStep1.isHidden = true
        ctnViewCreateUpholdStep2.isHidden = true
        ctnViewCreateUpholdStep3.isHidden = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveButtonStep3"), object: nil)
    }
    
    /**
     * Handle when tap on Issue menu item
     */
    func issueButtonInAccountVCTapped(_ notification: Notification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
         self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.gasServiceItemTapped(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.issueButtonInAccountVCTapped(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(super.configItemTap(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_CREATE_UPHOLD),
            object: nil)
    }
    
    /**
     * move step button to middle of line
     */
    func moveButtonToMiddleStep1(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnCreateUpholdStep1)
    }
    func moveButtonToMiddleStep2(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnCreateUpholdStep2)
    }
    func moveButtonToMiddleStep3(_ notification: Notification) {
        self.moveButtonToMiddle(aButton: btnCreateUpholdStep3)
    }
    
    func moveButtonToMiddle(aButton:UIButton) {
        switch aButton.tag {
        case 1:
            viewScrollButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2), y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        case 2:
            viewScrollButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT), y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        case 3:
            viewScrollButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2) - (GlobalConst.BUTTON_HEIGHT * 2), y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        default:
            break
        }
    }
    
    func step1Done (_ notification: Notification) {
        isStep1Done = true
        
        btnCreateUpholdStep1.isEnabled = isStep1Done
        btnCreateUpholdStep1.backgroundColor = UIColor.green
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveButtonStep2"), object: nil)
        ctnViewCreateUpholdStep1.isHidden = true
        ctnViewCreateUpholdStep2.isHidden = false
        ctnViewCreateUpholdStep3.isHidden = true
        
        
    }
    func step2Done (_ notification: Notification) {
        isStep2Done = true
        btnCreateUpholdStep2.isEnabled = isStep2Done
        btnCreateUpholdStep2.backgroundColor = UIColor.green
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveButtonStep3"), object: nil)
        btnCreateUpholdStep3.isEnabled = isStep2Done
        
        ctnViewCreateUpholdStep1.isHidden = true
        ctnViewCreateUpholdStep2.isHidden = true
        ctnViewCreateUpholdStep3.isHidden = false
        
    }
    func step3Done (_ notification: Notification) {
        isStep3Done = true
        btnCreateUpholdStep3.isEnabled = isStep3Done
        
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        viewBackground.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        viewBackground.translatesAutoresizingMaskIntoConstraints = true
        viewBackground.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        viewBackground.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        viewBackground.frame = CGRect(x: 0, y: (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT), width: (GlobalConst.SCREEN_WIDTH), height: (GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT)))
        
        ctnViewCreateUpholdStep1.isHidden = false
        ctnViewCreateUpholdStep2.isHidden = true
        ctnViewCreateUpholdStep3.isHidden = true
        
        ctnViewCreateUpholdStep1.translatesAutoresizingMaskIntoConstraints = true
        ctnViewCreateUpholdStep1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        
        
        ctnViewCreateUpholdStep2.translatesAutoresizingMaskIntoConstraints = true
        ctnViewCreateUpholdStep2.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        

        ctnViewCreateUpholdStep3.translatesAutoresizingMaskIntoConstraints = true
        ctnViewCreateUpholdStep3.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: viewBackground.frame.size.height - ((GlobalConst.PARENT_BORDER_WIDTH * 2) + GlobalConst.BUTTON_HEIGHT))
        
        viewScrollButton.translatesAutoresizingMaskIntoConstraints = true
        viewScrollButton.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT / 2), y: viewBackground.frame.size.height - GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH, height: GlobalConst.BUTTON_HEIGHT)
        viewScrollButton.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        
        btnCreateUpholdStep1.translatesAutoresizingMaskIntoConstraints = true
        //btnCreateUpholdStep1.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnCreateUpholdStep1.layer.borderColor = UIColor.green.cgColor
        btnCreateUpholdStep1.frame = CGRect(x: 0, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnCreateUpholdStep1.layer.cornerRadius = 0.5 * btnCreateUpholdStep1.bounds.size.width
        btnCreateUpholdStep1.setTitle("1", for: .normal)
        btnCreateUpholdStep1.setTitleColor(UIColor.white , for: .normal)
        btnCreateUpholdStep1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnCreateUpholdStep1.tag = 1
        

        
        btnCreateUpholdStep2.translatesAutoresizingMaskIntoConstraints = true
        btnCreateUpholdStep2.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        //btnCreateUpholdStep2.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnCreateUpholdStep2.layer.borderColor = UIColor.green.cgColor
        btnCreateUpholdStep2.layer.cornerRadius = 0.5 * btnCreateUpholdStep1.bounds.size.width
        btnCreateUpholdStep2.setTitle("2", for: .normal)
        btnCreateUpholdStep2.setTitleColor(UIColor.white , for: .normal)
        btnCreateUpholdStep2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnCreateUpholdStep2.tag = 2
        
        
        btnCreateUpholdStep3.translatesAutoresizingMaskIntoConstraints = true
        btnCreateUpholdStep3.frame = CGRect(x: GlobalConst.BUTTON_HEIGHT * 2, y: 0, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        //btnCreateUpholdStep3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnCreateUpholdStep3.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        btnCreateUpholdStep3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnCreateUpholdStep3.layer.borderColor = UIColor.green.cgColor
        btnCreateUpholdStep3.layer.cornerRadius = 0.5 * btnCreateUpholdStep1.bounds.size.width
        btnCreateUpholdStep3.setTitle("3", for: .normal)
        btnCreateUpholdStep3.setTitleColor(UIColor.green , for: .normal)
        btnCreateUpholdStep3.backgroundColor = UIColor.white
        btnCreateUpholdStep3.tag = 3
        
        
        btnCreateUpholdStep1.isEnabled = isStep1Done
        btnCreateUpholdStep2.isEnabled = isStep2Done
        btnCreateUpholdStep3.isEnabled = isStep3Done
        
        
        // MARK: - NavBar
        setupNavigationBar(title: GlobalConst.CONTENT00178, isNotifyEnable: Singleton.sharedInstance.checkIsLogin())
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(G01F01VC.step1Done(_:)), name:NSNotification.Name(rawValue: "step1Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(G01F01VC.step2Done(_:)), name:NSNotification.Name(rawValue: "step2Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(G01F01VC.step3Done(_:)), name:NSNotification.Name(rawValue: "step3Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(G01F01VC.moveButtonToMiddleStep1(_:)), name:NSNotification.Name(rawValue: "moveButtonStep1"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(G01F01VC.moveButtonToMiddleStep2(_:)), name:NSNotification.Name(rawValue: "moveButtonStep2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(G01F01VC.moveButtonToMiddleStep3(_:)), name:NSNotification.Name(rawValue: "moveButtonStep3"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GlobalConst.POPOVER_MENU_IDENTIFIER {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    /**
     * ...
     */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
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
