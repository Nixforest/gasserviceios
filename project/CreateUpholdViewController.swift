//
//  CreateUpholdViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class CreateUpholdViewController: UIViewController {
    
    static let sharedInstance: CreateUpholdViewController = {
        let instance = CreateUpholdViewController()
        return instance
    }()
    
    var problemType:String = ""
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
    
    
    @IBAction func btnCreateUpholdStep1Tapped(_ sender: AnyObject) {
        ctnViewCreateUpholdStep1.isHidden = false
        ctnViewCreateUpholdStep2.isHidden = true
        ctnViewCreateUpholdStep3.isHidden = true
    }
    @IBAction func btnCreateUpholdStep2Tapped(_ sender: AnyObject) {
        ctnViewCreateUpholdStep1.isHidden = true
        ctnViewCreateUpholdStep2.isHidden = false
        ctnViewCreateUpholdStep3.isHidden = true
    }
    @IBAction func btnCreateUpholdStep3Tapped(_ sender: AnyObject) {
        ctnViewCreateUpholdStep1.isHidden = true
        ctnViewCreateUpholdStep2.isHidden = true
        ctnViewCreateUpholdStep3.isHidden = false
    }
    
    func step1Done (_ notification: Notification) {
        isStep1Done = true
        
        btnCreateUpholdStep1.isEnabled = isStep1Done
        btnCreateUpholdStep1.backgroundColor = UIColor.green
    
        ctnViewCreateUpholdStep1.isHidden = true
        ctnViewCreateUpholdStep2.isHidden = false
        ctnViewCreateUpholdStep3.isHidden = true
    }
    func step2Done (_ notification: Notification) {
        isStep2Done = true
        btnCreateUpholdStep2.isEnabled = isStep2Done
        btnCreateUpholdStep2.backgroundColor = UIColor.green
        
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
        
        btnCreateUpholdStep1.translatesAutoresizingMaskIntoConstraints = true
        btnCreateUpholdStep1.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnCreateUpholdStep1.layer.borderColor = UIColor.green.cgColor
        btnCreateUpholdStep1.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT * 3/2), y: GlobalConst.PARENT_BORDER_WIDTH + ctnViewCreateUpholdStep1.frame.size.height, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnCreateUpholdStep1.layer.cornerRadius = 0.5 * btnCreateUpholdStep1.bounds.size.width
        btnCreateUpholdStep1.setTitle("1", for: .normal)
        btnCreateUpholdStep1.setTitleColor(UIColor.white , for: .normal)
        btnCreateUpholdStep1.backgroundColor = GlobalConst.BUTTON_COLOR_RED

        
        btnCreateUpholdStep2.translatesAutoresizingMaskIntoConstraints = true
        btnCreateUpholdStep2.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT * 3/2) + GlobalConst.BUTTON_HEIGHT, y: GlobalConst.PARENT_BORDER_WIDTH + ctnViewCreateUpholdStep1.frame.size.height, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnCreateUpholdStep2.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnCreateUpholdStep2.layer.borderColor = UIColor.green.cgColor
        btnCreateUpholdStep2.layer.cornerRadius = 0.5 * btnCreateUpholdStep1.bounds.size.width
        btnCreateUpholdStep2.setTitle("2", for: .normal)
        btnCreateUpholdStep2.setTitleColor(UIColor.white , for: .normal)
        btnCreateUpholdStep2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        
        btnCreateUpholdStep3.translatesAutoresizingMaskIntoConstraints = true
        btnCreateUpholdStep3.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT * 3/2) + (GlobalConst.BUTTON_HEIGHT * 2), y: GlobalConst.PARENT_BORDER_WIDTH + ctnViewCreateUpholdStep1.frame.size.height, width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        btnCreateUpholdStep3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnCreateUpholdStep3.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        btnCreateUpholdStep3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnCreateUpholdStep3.layer.borderColor = UIColor.green.cgColor
        btnCreateUpholdStep3.layer.cornerRadius = 0.5 * btnCreateUpholdStep1.bounds.size.width
        btnCreateUpholdStep3.setTitle("3", for: .normal)
        btnCreateUpholdStep3.setTitleColor(UIColor.green , for: .normal)
        btnCreateUpholdStep3.backgroundColor = UIColor.white

        
        
        btnCreateUpholdStep1.isEnabled = isStep1Done
        btnCreateUpholdStep2.isEnabled = isStep2Done
        btnCreateUpholdStep3.isEnabled = isStep3Done
        
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(CreateUpholdViewController.step1Done(_:)), name:NSNotification.Name(rawValue: "step1Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateUpholdViewController.step2Done(_:)), name:NSNotification.Name(rawValue: "step2Done"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateUpholdViewController.step3Done(_:)), name:NSNotification.Name(rawValue: "step3Done"), object: nil)
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
