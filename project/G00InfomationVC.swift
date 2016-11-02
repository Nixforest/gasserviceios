//
//  InfomationViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G00InfomationVC: UIViewController {
    // MARK: Properties
    /** Navigation bar */
    @IBOutlet weak var infomationNavBar: UINavigationItem!
    /** Back button */
    @IBOutlet weak var backButton: UIButton!
    /** Version */
    var lblVersion: UILabel = UILabel()
    var lblVersionValue: UILabel = UILabel()
    /** Email */
    var lblEmail: UILabel = UILabel()
    var lblEmailValue: UILabel = UILabel()
    /** Website */
    var lblWebsite: UILabel = UILabel()
    var lblWebsiteValue: UILabel = UILabel()
    
    // MARK: Actions
    /**
     * Handle back buton tapped
     * - parameter sender:AnyObject
     */
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        infomationNavBar.title = GlobalConst.CONTENT00072
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: GlobalConst.BUTTON_COLOR_RED]

        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBackLogo, for: UIControlState())
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //menuButton.addTarget(self, action: #selector(showPopOver), forControlEvents: .TouchUpInside)
        backButton.setTitle("", for: UIControlState())
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        infomationNavBar.setLeftBarButton(backNavBar, animated: false)
        let heigh = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        var offset: CGFloat = heigh + GlobalConst.MARGIN
        
        // Setup content
        // Version label
        lblVersion.translatesAutoresizingMaskIntoConstraints = true
        lblVersion.frame = CGRect(
            x: GlobalConst.MARGIN,
            y: offset,
            width: self.view.frame.width,
            height: GlobalConst.LABEL_HEIGHT)
        lblVersion.text               = GlobalConst.CONTENT00198
        lblVersion.textAlignment      = NSTextAlignment.left
        lblVersion.font               = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        lblVersion.textColor          = GlobalConst.INFOR_TITLE_COLOR
        offset += GlobalConst.LABEL_HEIGHT
        // Version value
        lblVersionValue.translatesAutoresizingMaskIntoConstraints = true
        lblVersionValue.frame = CGRect(
            x: GlobalConst.MARGIN * 2,
            y: offset,
            width: self.view.frame.width,
            height: GlobalConst.LABEL_HEIGHT)
        lblVersionValue.text          = GlobalConst.VERSION_CODE
        lblVersionValue.textAlignment = NSTextAlignment.left
        lblVersionValue.font          = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT
        
        self.view.addSubview(lblVersion)
        self.view.addSubview(lblVersionValue)
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
