//
//  PeriodUpholdDetailViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class PeriodUpholdDetailViewController: CommonViewController {

    
    let lblHeader0 = UILabel()
    let lblHeader1 = UILabel()
    let lblHeader2 = UILabel()
    
    var lblCreateDate = UILabel()
    var lblCreateDateValue = UILabel()
    
    var lblCustomerName = UILabel()
    var lblCustomerNameValue = UILabel()
    
    var lblAddress = UILabel()
    var lblAddressValue = UILabel()
    
    var lblContact = UILabel()
    var lblContactValue = UILabel()
    
    var lblIssue = UILabel()
    var lblIssueValue = UILabel()
    
    var lblContent = UILabel()
    var lblContentValue = UILabel()
    
    var lblEmployee = UILabel()
    var lblEmployeeValue = UILabel()
    
    var lblEmployeePhone = UILabel()
    var lblEmployeePhoneValue = UILabel()
    
    var lblHandlingTime = UILabel()
    var lblHandlingTimeValue = UILabel()
    
    var lblStatus = UILabel()
    var lblStatusValue = UILabel()
    
    // ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var viewBackground: UIView!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // MARK: Background
        let aView = UIView()
        aView.translatesAutoresizingMaskIntoConstraints = true
        aView.frame = CGRect(x: 0,
                             y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT,
                             width: self.view.frame.size.width,
                             height: self.view.frame.size.height - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH))
        aView.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        aView.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        aView.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        self.view.addSubview(aView)
        /**
         * scroolview
         */
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: GlobalConst.PARENT_BORDER_WIDTH ,
                                  width: self.view.frame.size.width - GlobalConst.PARENT_BORDER_WIDTH * 2,
                                  height: self.view.frame.size.height - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH * 2))
        scrollView.backgroundColor = UIColor.white
        scrollView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        scrollView.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        scrollView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        aView.addSubview(scrollView)

        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(width : self.view.frame.size.width, height :1000)
        //scrollView.scrollRectToVisible(CGRect(x: 0,y: 44 , width: self.view.frame.size.width, height: self.view.frame.size.height -  44) , animated: true)
        
        //MARK: Label
        
        /**
         * Header 0 - Uphold Request Detail
         */
        // Header 0
        lblHeader0.translatesAutoresizingMaskIntoConstraints = true
        lblHeader0.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 4), height: GlobalConst.LABEL_HEIGHT)
        lblHeader0.layer.masksToBounds = true
        lblHeader0.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        lblHeader0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        lblHeader0.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblHeader0.text = "Yêu cầu bảo trì"
        lblHeader0.textAlignment = .center
        scrollView.addSubview(lblHeader0)
        
        // Label CreateDate and CreateDateValue
        lblCreateDate.translatesAutoresizingMaskIntoConstraints = true
        lblCreateDate.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                     y: lblHeader0.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                     width: GlobalConst.SCREEN_WIDTH / 3,
                                     height: GlobalConst.LABEL_HEIGHT)
        lblCreateDate.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCreateDate.layer.borderColor = UIColor.black.cgColor
        lblCreateDate.text = " Ngày tạo"
        lblCreateDate.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblCreateDate)
        
        lblCreateDateValue.translatesAutoresizingMaskIntoConstraints = true
        lblCreateDateValue.frame = CGRect(x: lblCreateDate.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                          y: lblHeader0.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                          width: GlobalConst.SCREEN_WIDTH - (lblCreateDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 4),
                                          height: GlobalConst.LABEL_HEIGHT)
        lblCreateDateValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCreateDateValue.layer.borderColor = UIColor.black.cgColor
        lblCreateDateValue.text = "1"
        scrollView.addSubview(lblCreateDateValue)
        
        // Label CustomerName and CustomerNameValue
        lblCustomerName.translatesAutoresizingMaskIntoConstraints = true
        lblCustomerName.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                       y: lblCreateDate.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH / 3,
                                       height: GlobalConst.LABEL_HEIGHT)
        lblCustomerName.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCustomerName.layer.borderColor = UIColor.black.cgColor
        lblCustomerName.text = " Tên KH"
        lblCustomerName.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblCustomerName)
        
        lblCustomerNameValue.translatesAutoresizingMaskIntoConstraints = true
        lblCustomerNameValue.frame = CGRect(x: lblCreateDate.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                            y: lblCreateDateValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                            width: GlobalConst.SCREEN_WIDTH - (lblCreateDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 4),
                                            height: GlobalConst.LABEL_HEIGHT)
        lblCustomerNameValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCustomerNameValue.layer.borderColor = UIColor.black.cgColor
        lblCustomerNameValue.text = "2"
        scrollView.addSubview(lblCustomerNameValue)
        
        // Label Address and AddressValue
        lblAddress.translatesAutoresizingMaskIntoConstraints = true
        lblAddress.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblCustomerName.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                  width: GlobalConst.SCREEN_WIDTH / 3,
                                  height: GlobalConst.LABEL_HEIGHT)
        lblAddress.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblAddress.layer.borderColor = UIColor.black.cgColor
        lblAddress.text = " Địa chỉ"
        lblAddress.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblAddress)
        
        lblAddressValue.translatesAutoresizingMaskIntoConstraints = true
        lblAddressValue.frame = CGRect(x: lblAddress.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                       y: lblCustomerNameValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH - (lblAddress.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 4),
                                       height: GlobalConst.LABEL_HEIGHT)
        lblAddressValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblAddressValue.layer.borderColor = UIColor.black.cgColor
        lblAddressValue.text = "3"
        scrollView.addSubview(lblAddressValue)
        
        // Label Contact and ContactValue
        lblContact.translatesAutoresizingMaskIntoConstraints = true
        lblContact.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblAddress.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                  width: GlobalConst.SCREEN_WIDTH / 3,
                                  height: GlobalConst.LABEL_HEIGHT)
        lblContact.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContact.layer.borderColor = UIColor.black.cgColor
        lblContact.text = " Liên hệ"
        lblContact.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblContact)
        
        lblContactValue.translatesAutoresizingMaskIntoConstraints = true
        lblContactValue.frame = CGRect(x: lblContact.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                       y: lblAddressValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH - (lblCreateDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 4),
                                       height: GlobalConst.LABEL_HEIGHT)
        lblContactValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContactValue.layer.borderColor = UIColor.black.cgColor
        lblContactValue.text = "4"
        scrollView.addSubview(lblContactValue)
        
        // Label Issue and IssueValue
        lblIssue.translatesAutoresizingMaskIntoConstraints = true
        lblIssue.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                y: lblContact.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                width: GlobalConst.SCREEN_WIDTH / 3,
                                height: GlobalConst.LABEL_HEIGHT)
        lblIssue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblIssue.layer.borderColor = UIColor.black.cgColor
        lblIssue.text = " Sự cố"
        lblIssue.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblIssue)
        
        lblIssueValue.translatesAutoresizingMaskIntoConstraints = true
        lblIssueValue.frame = CGRect(x: lblIssue.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                     y: lblContactValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                     width: GlobalConst.SCREEN_WIDTH - (lblCreateDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 4),
                                     height: GlobalConst.LABEL_HEIGHT)
        lblIssueValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblIssueValue.layer.borderColor = UIColor.black.cgColor
        lblIssueValue.text = "5"
        scrollView.addSubview(lblIssueValue)
        
        // Label Content and ContentValue
        lblContent.translatesAutoresizingMaskIntoConstraints = true
        lblContent.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblIssue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                  width: GlobalConst.SCREEN_WIDTH / 3,
                                  height: GlobalConst.LABEL_HEIGHT)
        lblContent.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContent.layer.borderColor = UIColor.black.cgColor
        lblContent.text = " Nội dung"
        lblContent.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblContent)
        
        lblContentValue.translatesAutoresizingMaskIntoConstraints = true
        lblContentValue.frame = CGRect(x: lblContent.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                       y: lblIssueValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH - (lblContent.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 4),
                                       height: GlobalConst.LABEL_HEIGHT)
        lblContentValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContentValue.layer.borderColor = UIColor.black.cgColor
        lblContentValue.text = "6"
        scrollView.addSubview(lblContentValue)
        
        
//        /**
//         * Header 1 - Uphold Emplyee Detail
//         */
//        lblHeader1.translatesAutoresizingMaskIntoConstraints = true
//        lblHeader1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: viewBackground.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.LABEL_HEIGHT)
//        lblHeader1.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
//        lblHeader1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
//        
//        /**
//         * Header 2 - Uphold Result Detail
//         */
//        lblHeader2.translatesAutoresizingMaskIntoConstraints = true
//        lblHeader2.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: viewBackground.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.LABEL_HEIGHT)
//        lblHeader2.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
//        lblHeader2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        
        // Do any additional setup after loading the view.
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
