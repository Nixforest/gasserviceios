//
//  menuAccountViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/14/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class menuAccountViewController: UIViewController {

    @IBOutlet weak var gasServiceButton: UIButton!
    @IBOutlet weak var issueButton: UIButton!
    @IBOutlet weak var configButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gasServiceButton.frame = CGRect(x: 0, y: 0, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat(GlobalConst.BUTTON_HEIGHT))
        gasServiceButton.backgroundColor = UIColor.whiteColor()
        gasServiceButton.setTitle(GlobalConst.CONTENT00110, forState: .Normal)
        gasServiceButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        self.view.addSubview(gasServiceButton)
        gasServiceButton.translatesAutoresizingMaskIntoConstraints = true
        
        issueButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT), width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        issueButton.backgroundColor = UIColor.whiteColor()
        issueButton.setTitle(GlobalConst.CONTENT00114, forState: .Normal)
        issueButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        self.view.addSubview(issueButton)
        issueButton.translatesAutoresizingMaskIntoConstraints = true
        configButton.frame = CGRect(x: 0, y: CGFloat( GlobalConst.BUTTON_HEIGHT) * 2, width: CGFloat(GlobalConst.POPOVER_WIDTH), height: CGFloat( GlobalConst.BUTTON_HEIGHT))
        configButton.backgroundColor = UIColor.whiteColor()
        configButton.setTitle(GlobalConst.CONTENT00111, forState: .Normal)
        configButton.setTitleColor(ColorFromRGB().getColorFromRGB(0xF00020), forState: .Normal)
        self.view.addSubview(configButton)
        configButton.translatesAutoresizingMaskIntoConstraints = true

        
        
        // Do any additional setup after loading the view.
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
