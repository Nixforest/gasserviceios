//
//  UpholdListTableViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/6/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class PeriodUpholdListTableViewController: UITableViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var upholdListNavBar: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //screen
        view.backgroundColor = UIColor.grayColor()
        let grayColor = UIColor.grayColor().CGColor
        
        self.view.frame = CGRectInset(view.frame, -GlobalConst.PARENT_BORDER_WIDTH, -GlobalConst.PARENT_BORDER_WIDTH)
        self.view.layer.borderColor = grayColor
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        
                // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PeriodUpholdCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        //cell.layer.borderWidth = 1.0
        //cell.layer.borderColor = UIColor.redColor().CGColor
        let bgrView = UIView()
        bgrView.backgroundColor = UIColor.whiteColor()
        bgrView.frame = CGRectMake(GlobalConst.PARENT_BORDER_WIDTH , GlobalConst.PARENT_BORDER_WIDTH, cell.frame.size.width - GlobalConst.PARENT_BORDER_WIDTH * 2 - (cell.frame.size.height - 5 * 2)/2, cell.frame.size.height - 5 * 2)
        bgrView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        bgrView.layer.borderColor = ColorFromRGB().getColorFromRGB(0xF00020).CGColor
        bgrView.clipsToBounds = true
        bgrView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        cell.contentView.addSubview(bgrView)
        
        let txtName:UILabel = UILabel(frame: CGRectMake(10, 10, GlobalConst.SCREEN_WIDTH - 10, 20))
        let txtIssue:UILabel = UILabel(frame: CGRectMake(10, 30, GlobalConst.SCREEN_WIDTH - 10, 20))
        let txtStatus:UILabel = UILabel(frame: CGRectMake(10, 50, GlobalConst.SCREEN_WIDTH - 10, 20))
        let txtDate:UILabel = UILabel(frame: CGRectMake(10, 70, GlobalConst.SCREEN_WIDTH - 10, 20))
        txtName.text = "hai san bien dong"
        txtIssue.text = "hu bep"
        txtStatus.text = "moi"
        txtDate.text = "dd/mm/yy hour:min"
        
        cell.contentView.addSubview(txtName)
        cell.contentView.addSubview(txtIssue)
        cell.contentView.addSubview(txtStatus)
        cell.contentView.addSubview(txtDate)
        
        let doneButton:UIButton = UIButton()
        doneButton.frame = CGRectMake(270, GlobalConst.PARENT_BORDER_WIDTH, (cell.frame.size.height - 5 * 2)/2, (cell.frame.size.height - 5 * 2)/2)
        doneButton.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        doneButton.layer.borderColor = ColorFromRGB().getColorFromRGB(0xF00020).CGColor
        doneButton.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        doneButton.setImage(UIImage(named: "done.png"), forState: .Normal)
        //doneButton.addTarget(self, action: #selector(cellAction(_ :)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.contentView.addSubview(doneButton)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let rowHeight:CGFloat = 100.0
        return rowHeight
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
