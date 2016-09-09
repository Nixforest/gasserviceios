//
//  ProblemUpHoldListTableViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/9/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ProblemUpHoldListTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayColor()
        let grayColor = UIColor.grayColor().CGColor
        let borderWidth:CGFloat = 0x05
        self.view.frame = CGRectInset(view.frame, -borderWidth, -borderWidth)
        self.view.layer.borderColor = grayColor
        self.view.layer.borderWidth = borderWidth

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
        let cell = tableView.dequeueReusableCellWithIdentifier("ProblemUpholdCell", forIndexPath: indexPath)

        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.redColor().CGColor
        
        let doneButton:UIButton = UIButton()
        doneButton.frame = CGRectMake(280, 20, 20, 20)
        doneButton.setImage(UIImage(named: "done.png"), forState: .Normal)
        //doneButton.addTarget(self, action: #selector(cellAction(_ :)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.contentView.addSubview(doneButton)
        let ratingButton:UIButton = UIButton()
        ratingButton.frame = CGRectMake(280, 60, 20, 20)
        ratingButton.setImage(UIImage(named: "rating.png"), forState: .Normal)
        //doneButton.addTarget(self, action: #selector(cellAction(_ :)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.contentView.addSubview(ratingButton)
        

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
