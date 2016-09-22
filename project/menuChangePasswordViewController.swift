//
//  menuChangePasswordViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class menuChangePasswordViewController: UIViewController {

    @IBOutlet weak var gasServiceButton: UIButton!
    @IBOutlet weak var issueButton: UIButton!
    @IBOutlet weak var configButton: UIButton!
    
    @IBAction func gasServiceButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "gasServiceButtonInChangePassVCTapped"), object: nil)
        }

    }
    @IBAction func issueButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "issueButtonInChangePassVCTapped"), object: nil)
        }

    }
    @IBAction func configButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "configButtonInChangePassVCTapped"), object: nil)
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gasServiceButton.frame = CGRect(x: 0, y: 0, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat(GlobalConst.BUTTON_HEIGHT))
        gasServiceButton.backgroundColor = UIColor.white
        gasServiceButton.setTitle(GlobalConst.CONTENT00127, for: UIControlState())
        gasServiceButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), for: UIControlState())
        self.view.addSubview(gasServiceButton)
        gasServiceButton.translatesAutoresizingMaskIntoConstraints = true
        
        issueButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT), width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        issueButton.backgroundColor = UIColor.white
        issueButton.setTitle(GlobalConst.CONTENT00131, for: UIControlState())
        issueButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), for: UIControlState())
        self.view.addSubview(issueButton)
        issueButton.translatesAutoresizingMaskIntoConstraints = true
        configButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT) * 2, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        configButton.backgroundColor = UIColor.white
        configButton.setTitle(GlobalConst.CONTENT00128, for: UIControlState())
        configButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), for: UIControlState())
        self.view.addSubview(configButton)
        configButton.translatesAutoresizingMaskIntoConstraints = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
