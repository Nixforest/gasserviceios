//
//  UpholdListViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/9/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdListViewController: UIViewController {

    
    var width = UIScreen.mainScreen().bounds.width
    var height = UIScreen.mainScreen().bounds.height
    
    var showProblemUpholdList:Bool! = true
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var upholdListNavBar: UINavigationItem!
    
    @IBOutlet weak var txtSearchBox: UITextField!
    
    @IBOutlet weak var problemUpholdButton: UIButton!
    @IBOutlet weak var periodUpholdButton: UIButton!
    
    @IBOutlet weak var problemUpholdList: UIView!
    @IBOutlet weak var periodUpholdList: UIView!
    
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func problemUpholdButtonTapped(sender: AnyObject) {
        showProblemUpholdList = true
        periodUpholdList.hidden = true
        problemUpholdList.hidden = false
        
        problemUpholdButton.backgroundColor = UIColor.whiteColor()
        problemUpholdButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        
        periodUpholdButton.backgroundColor = UIColor.redColor()
        periodUpholdButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)

    }
    @IBAction func periodUpholdListButtonTapped(sender: AnyObject) {
        showProblemUpholdList = false
        problemUpholdList.hidden = true
        periodUpholdList.hidden = false
        
        
        problemUpholdButton.backgroundColor = UIColor.redColor()
        problemUpholdButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        problemUpholdButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        periodUpholdButton.backgroundColor = UIColor.whiteColor()
        periodUpholdButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        periodUpholdButton.layer.borderColor = UIColor.redColor().CGColor

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        problemUpholdList.frame = CGRectMake(0, 130, width, height - 150)
        problemUpholdList.translatesAutoresizingMaskIntoConstraints = true
        periodUpholdList.frame = CGRectMake(0, 130, width, height - 150)
        periodUpholdList.translatesAutoresizingMaskIntoConstraints = true
        
        
        //show-hide UpholdList
        periodUpholdList.hidden = true
        problemUpholdList.hidden = false
        /*if showProblemUpholdList == true {
            problemUpholdList.hidden = false
            periodUpholdList.hidden = true
        } else {
            problemUpholdList.hidden = true
            periodUpholdList.hidden = false
        }*/
        problemUpholdButton.frame = CGRectMake(0, 110, width/2, 50)
        problemUpholdButton.backgroundColor = UIColor.whiteColor()
        problemUpholdButton.setTitle(GlobalConst.CONTENT00077, forState: .Normal)
        problemUpholdButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        problemUpholdButton.layer.borderColor = UIColor.redColor().CGColor
        
        periodUpholdButton.frame = CGRectMake(width/2 + 1, 110, width/2, 50)
        periodUpholdButton.backgroundColor = UIColor.redColor()
        periodUpholdButton.setTitle(GlobalConst.CONTENT00078, forState: .Normal)
        periodUpholdButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        periodUpholdButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        //Navigation Bar
        upholdListNavBar.title = GlobalConst.CONTENT00112
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:ColorFromRGB().getColorFromRGB(0xF00020)]
        self.navigationItem.setHidesBackButton(true, animated:true);
        //menu button on NavBar
        let menuOrigin = UIImage(named: "menu.png");
        let tintedImage = menuOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButton.setImage(tintedImage, forState: .Normal)
        menuButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        
        //menuButton.addTarget(self, action: #selector(menuButtonTapped), forControlEvents: .TouchUpInside)
        menuButton.setTitle("", forState: .Normal)
        let menuNavBar = UIBarButtonItem()
        menuNavBar.customView = menuButton
        menuNavBar.enabled = true //disable menu button
        
        upholdListNavBar.setRightBarButtonItem(menuNavBar, animated: false)
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backButton.setImage(tintedBackLogo, forState: .Normal)
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        upholdListNavBar.setLeftBarButtonItem(backNavBar, animated: false)
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
