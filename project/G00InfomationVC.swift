//
//  InfomationViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

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
    /** Logo */
    var imgLogo: UIImageView = UIImageView()
    
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

        let backOrigin = UIImage(named: GlobalConst.BACK_IMG_NAME)
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBackLogo, for: UIControlState())
        backButton.tintColor = GlobalConst.BUTTON_COLOR_RED
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
            width: self.view.frame.width - GlobalConst.MARGIN,
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
            width: self.view.frame.width - GlobalConst.MARGIN * 2,
            height: GlobalConst.LABEL_HEIGHT / 2)
        lblVersionValue.text          = GlobalConst.VERSION_CODE_NAME
        lblVersionValue.textAlignment = NSTextAlignment.left
        lblVersionValue.font          = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT / 2
        
        // Email
        lblEmail.translatesAutoresizingMaskIntoConstraints = true
        lblEmail.frame = CGRect(
            x: GlobalConst.MARGIN,
            y: offset,
            width: self.view.frame.width - GlobalConst.MARGIN,
            height: GlobalConst.LABEL_HEIGHT)
        lblEmail.text               = GlobalConst.CONTENT00199
        lblEmail.textAlignment      = NSTextAlignment.left
        lblEmail.font               = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        lblEmail.textColor          = GlobalConst.INFOR_TITLE_COLOR
        offset += GlobalConst.LABEL_HEIGHT
        // Email value
        lblEmailValue.translatesAutoresizingMaskIntoConstraints = true
        lblEmailValue.frame = CGRect(
            x: GlobalConst.MARGIN * 2,
            y: offset,
            width: self.view.frame.width - GlobalConst.MARGIN * 2,
            height: GlobalConst.LABEL_HEIGHT / 2)
        lblEmailValue.text          = GlobalConst.EMAIL
        lblEmailValue.textAlignment = NSTextAlignment.left
        lblEmailValue.font          = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT / 2
        
        // Website
        lblWebsite.translatesAutoresizingMaskIntoConstraints = true
        lblWebsite.frame = CGRect(
            x: GlobalConst.MARGIN,
            y: offset,
            width: self.view.frame.width - GlobalConst.MARGIN,
            height: GlobalConst.LABEL_HEIGHT)
        lblWebsite.text               = GlobalConst.CONTENT00200
        lblWebsite.textAlignment      = NSTextAlignment.left
        lblWebsite.font               = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        lblWebsite.textColor          = GlobalConst.INFOR_TITLE_COLOR
        offset += GlobalConst.LABEL_HEIGHT
        // Website value
        lblWebsiteValue.translatesAutoresizingMaskIntoConstraints = true
        lblWebsiteValue.frame = CGRect(
            x: GlobalConst.MARGIN * 2,
            y: offset,
            width: self.view.frame.width - GlobalConst.MARGIN * 2,
            height: GlobalConst.LABEL_HEIGHT / 2)
        lblWebsiteValue.text          = GlobalConst.WEBSITE
        lblWebsiteValue.textAlignment = NSTextAlignment.left
        lblWebsiteValue.font          = UIFont.systemFont(ofSize: GlobalConst.TEXTFIELD_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT / 2 + GlobalConst.MARGIN
        
        // Logo
        imgLogo.image = UIImage(named: GlobalConst.LOGO_IMG_NAME)
        imgLogo.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W) / 2,
                               y: offset,
                               width: GlobalConst.LOGIN_LOGO_W,
                               height: GlobalConst.LOGIN_LOGO_H)
        imgLogo.translatesAutoresizingMaskIntoConstraints = true
        
        self.view.addSubview(lblVersion)
        self.view.addSubview(lblVersionValue)
        self.view.addSubview(lblEmail)
        self.view.addSubview(lblEmailValue)
        self.view.addSubview(lblWebsite)
        self.view.addSubview(lblWebsiteValue)
        self.view.addSubview(imgLogo)
    }
    
    /**
     * Did receive memory warning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
