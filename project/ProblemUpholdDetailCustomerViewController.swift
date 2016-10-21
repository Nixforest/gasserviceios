//
//  ProblemUpholdDetailCustomerViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ProblemUpholdDetailCustomerViewController: CommonViewController {

    
    let lblHeader0 = UILabel()
    let lblHeader1 = UILabel()
    let lblHeader2 = UILabel()
    
    var lblCreateDate = UILabel()
    var lblCreateDateValue = UILabel()
    
    var lblCustomerName = UITextView()
    var lblCustomerNameValue = UITextView()
    
    var lblAddress = UITextView()
    var lblAddressValue = UITextView()
    
    var lblContact = UILabel()
    var lblContactValue = UILabel()
    
    var lblIssue = UILabel()
    var lblIssueValue = UILabel()
    
    var lblContent = UITextView()
    var lblContentValue = UITextView()
    
    var lblEmployee = UILabel()
    var lblEmployeeValue = UILabel()
    
    var lblEmployeePhone = UILabel()
    var lblEmployeePhoneValue = UILabel()
    
    var lblHandlingTime = UILabel()
    var lblHandlingTimeValue = UILabel()
    
    var lblStatus = UILabel()
    var lblStatusValue = UILabel()
    
    var lblReport = UILabel()
    var lblReportValue = UILabel()
    
    
    // ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // MARK: Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
//        let aView = UIView()
//        aView.translatesAutoresizingMaskIntoConstraints = true
//        aView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
//                             y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT,
//                             width: self.view.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2),
//                             height: self.view.frame.size.height - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + (GlobalConst.PARENT_BORDER_WIDTH * 2)))
//        aView.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
//        self.view.addSubview(aView)
        /**
         * scrollView
         */
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 2,
                                  y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH ,
                                  width: self.view.frame.size.width - GlobalConst.PARENT_BORDER_WIDTH * 4,
                                  height: self.view.frame.size.height - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH * 3))
        scrollView.backgroundColor = UIColor.white
        scrollView.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        scrollView.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        scrollView.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        //self.view.addSubview(scrollView)

        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(width : self.view.frame.size.width - GlobalConst.PARENT_BORDER_WIDTH * 4, height : GlobalConst.LABEL_HEIGHT * 17 + GlobalConst.PARENT_BORDER_WIDTH * 7)
        //scrollView.scrollRectToVisible(CGRect(x: 0,y: 44 , width: self.view.frame.size.width, height: self.view.frame.size.height -  44) , animated: true)
        
        //MARK: Header0 and Label
        /**
         * Header 0 - Uphold Request Detail
         */
        // Header 0
        lblHeader0.translatesAutoresizingMaskIntoConstraints = true
        lblHeader0.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: 0,
                                  width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                  height: GlobalConst.LABEL_HEIGHT)
        lblHeader0.layer.masksToBounds = true
        lblHeader0.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        lblHeader0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        lblHeader0.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblHeader0.text = "Yêu cầu bảo trì"
        lblHeader0.textColor = UIColor.white
        lblHeader0.textAlignment = .center
        scrollView.addSubview(lblHeader0)
        
        // Label CreateDate and CreateDateValue
        lblCreateDate.translatesAutoresizingMaskIntoConstraints = true
        lblCreateDate.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                     y: lblHeader0.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                     width: GlobalConst.SCREEN_WIDTH / 3,
                                     height: GlobalConst.LABEL_HEIGHT)
        lblCreateDate.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCreateDate.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblCreateDate.text = " Ngày tạo"
        lblCreateDate.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblCreateDate)
        
        lblCreateDateValue.translatesAutoresizingMaskIntoConstraints = true
        lblCreateDateValue.frame = CGRect(x: lblCreateDate.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                          y: lblHeader0.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                          width: GlobalConst.SCREEN_WIDTH - (lblCreateDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                          height: GlobalConst.LABEL_HEIGHT)
        lblCreateDateValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCreateDateValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblCreateDateValue.text = "1"
        scrollView.addSubview(lblCreateDateValue)
        
        // Label CustomerName and CustomerNameValue
        lblCustomerName.translatesAutoresizingMaskIntoConstraints = true
        lblCustomerName.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                       y: lblCreateDate.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH / 3,
                                       height: GlobalConst.LABEL_HEIGHT * 2)
        lblCustomerName.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCustomerName.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblCustomerName.text = "Tên KH"
        lblCustomerName.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblCustomerName.isUserInteractionEnabled = false
        scrollView.addSubview(lblCustomerName)
        
        lblCustomerNameValue.translatesAutoresizingMaskIntoConstraints = true
        lblCustomerNameValue.frame = CGRect(x: lblCreateDate.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                            y: lblCreateDateValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                            width: GlobalConst.SCREEN_WIDTH - (lblCreateDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                            height: GlobalConst.LABEL_HEIGHT * 2)
        lblCustomerNameValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCustomerNameValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblCustomerNameValue.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblCustomerNameValue.isUserInteractionEnabled = false
        lblCustomerNameValue.text = "2"
        scrollView.addSubview(lblCustomerNameValue)
        
        // Label Address and AddressValue
        lblAddress.translatesAutoresizingMaskIntoConstraints = true
        lblAddress.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblCustomerName.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                  width: GlobalConst.SCREEN_WIDTH / 3,
                                  height: GlobalConst.LABEL_HEIGHT * 2)
        lblAddress.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblAddress.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblAddress.text = "Địa chỉ"
        lblAddress.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblAddress.isUserInteractionEnabled = false
        scrollView.addSubview(lblAddress)
        
        lblAddressValue.translatesAutoresizingMaskIntoConstraints = true
        lblAddressValue.frame = CGRect(x: lblAddress.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                       y: lblCustomerNameValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH - (lblAddress.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                       height: GlobalConst.LABEL_HEIGHT * 2)
        lblAddressValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblAddressValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblAddressValue.text = "3"
        lblAddressValue.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblAddressValue.isUserInteractionEnabled = false
        scrollView.addSubview(lblAddressValue)
        
        // Label Contact and ContactValue
        lblContact.translatesAutoresizingMaskIntoConstraints = true
        lblContact.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblAddress.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                  width: GlobalConst.SCREEN_WIDTH / 3,
                                  height: GlobalConst.LABEL_HEIGHT)
        lblContact.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContact.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblContact.text = " Liên hệ"
        lblContact.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblContact)
        
        lblContactValue.translatesAutoresizingMaskIntoConstraints = true
        lblContactValue.frame = CGRect(x: lblContact.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                       y: lblAddressValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH - (lblCreateDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                       height: GlobalConst.LABEL_HEIGHT)
        lblContactValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContactValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblContactValue.text = "4"
        scrollView.addSubview(lblContactValue)
        
        // Label Issue and IssueValue
        lblIssue.translatesAutoresizingMaskIntoConstraints = true
        lblIssue.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                y: lblContact.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                width: GlobalConst.SCREEN_WIDTH / 3,
                                height: GlobalConst.LABEL_HEIGHT)
        lblIssue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblIssue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblIssue.text = " Sự cố"
        lblIssue.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblIssue)
        
        lblIssueValue.translatesAutoresizingMaskIntoConstraints = true
        lblIssueValue.frame = CGRect(x: lblIssue.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                     y: lblContactValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                     width: GlobalConst.SCREEN_WIDTH - (lblCreateDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                     height: GlobalConst.LABEL_HEIGHT)
        lblIssueValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblIssueValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblIssueValue.text = "5"
        scrollView.addSubview(lblIssueValue)
        
        // Label Content and ContentValue
        lblContent.translatesAutoresizingMaskIntoConstraints = true
        lblContent.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblIssue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                  width: GlobalConst.SCREEN_WIDTH / 3,
                                  height: GlobalConst.LABEL_HEIGHT * 2)
        lblContent.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContent.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblContent.text = "Nội dung"
        lblContent.isUserInteractionEnabled = false
        lblContent.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblContent)
        
        lblContentValue.translatesAutoresizingMaskIntoConstraints = true
        lblContentValue.frame = CGRect(x: lblContent.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                       y: lblIssueValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH - (lblContent.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                       height: GlobalConst.LABEL_HEIGHT * 2)
        lblContentValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContentValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblContentValue.text = "6"
        lblContentValue.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblContentValue.isUserInteractionEnabled = false
        scrollView.addSubview(lblContentValue)
        
        // MARK: - Header 1 and label
        /**
         * Header 1 - Uphold Emplyee Detail
         */
        lblHeader1.translatesAutoresizingMaskIntoConstraints = true
        lblHeader1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblContent.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                  width: scrollView.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2),
                                  height: GlobalConst.LABEL_HEIGHT)
        lblHeader1.layer.masksToBounds = true
        lblHeader1.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        lblHeader1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        lblHeader1.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblHeader1.text = "Nhân viên bảo trì"
        lblHeader1.textColor = UIColor.white
        lblHeader1.textAlignment = .center
        scrollView.addSubview(lblHeader1)
        
        // Label Employee and EmployeeValue
        lblEmployee.translatesAutoresizingMaskIntoConstraints = true
        lblEmployee.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                     y: lblHeader1.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                     width: GlobalConst.SCREEN_WIDTH / 3,
                                     height: GlobalConst.LABEL_HEIGHT)
        lblEmployee.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblEmployee.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblEmployee.text = " NV Bảo trì"
        lblEmployee.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblEmployee)
        
        lblEmployeeValue.translatesAutoresizingMaskIntoConstraints = true
        lblEmployeeValue.frame = CGRect(x: lblEmployee.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                          y: lblHeader1.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                          width: GlobalConst.SCREEN_WIDTH - (lblEmployee.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                          height: GlobalConst.LABEL_HEIGHT)
        lblEmployeeValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblEmployeeValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblEmployeeValue.text = "1"
        scrollView.addSubview(lblEmployeeValue)
        
        // Label EmployeePhone and EmployeePhoneValue
        lblEmployeePhone.translatesAutoresizingMaskIntoConstraints = true
        lblEmployeePhone.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                       y: lblEmployee.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH / 3,
                                       height: GlobalConst.LABEL_HEIGHT)
        lblEmployeePhone.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblEmployeePhone.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblEmployeePhone.text = " Điện thoại"
        lblEmployeePhone.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblEmployeePhone)
        
        lblEmployeePhoneValue.translatesAutoresizingMaskIntoConstraints = true
        lblEmployeePhoneValue.frame = CGRect(x: lblEmployeePhone.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                            y: lblEmployeeValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                            width: GlobalConst.SCREEN_WIDTH - (lblEmployeePhone.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                            height: GlobalConst.LABEL_HEIGHT)
        lblEmployeePhoneValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblEmployeePhoneValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblEmployeePhoneValue.text = "2"
        scrollView.addSubview(lblEmployeePhoneValue)
        
        // Label HandlingTime and HandlingTimeValue
        lblHandlingTime.translatesAutoresizingMaskIntoConstraints = true
        lblHandlingTime.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblEmployeePhone.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                  width: GlobalConst.SCREEN_WIDTH / 3,
                                  height: GlobalConst.LABEL_HEIGHT)
        lblHandlingTime.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblHandlingTime.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblHandlingTime.text = " Tgian xử lý"
        lblHandlingTime.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblHandlingTime)
        
        lblHandlingTimeValue.translatesAutoresizingMaskIntoConstraints = true
        lblHandlingTimeValue.frame = CGRect(x: lblAddress.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                       y: lblEmployeePhoneValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH - (lblHandlingTime.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                       height: GlobalConst.LABEL_HEIGHT)
        lblHandlingTimeValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblHandlingTimeValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblHandlingTimeValue.text = "3"
        scrollView.addSubview(lblHandlingTimeValue)

        // MARK: - Header 2 and label
        /**
         * Header 2 - Uphold Result Detail
         */
        lblHeader2.translatesAutoresizingMaskIntoConstraints = true
        lblHeader2.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblHandlingTime.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                  width: scrollView.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2),
                                  height: GlobalConst.LABEL_HEIGHT)
        lblHeader2.layer.masksToBounds = true
        lblHeader2.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        lblHeader2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        lblHeader2.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblHeader2.text = "Kết quả"
        lblHeader2.textColor = UIColor.white
        lblHeader2.textAlignment = .center
        scrollView.addSubview(lblHeader2)

        // Label Status and StatusValue
        lblStatus.translatesAutoresizingMaskIntoConstraints = true
        lblStatus.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                   y: lblHeader2.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                   width: GlobalConst.SCREEN_WIDTH / 3,
                                   height: GlobalConst.LABEL_HEIGHT)
        lblStatus.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblStatus.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblStatus.text = " Trạng thái"
        lblStatus.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblStatus)
        
        lblStatusValue.translatesAutoresizingMaskIntoConstraints = true
        lblStatusValue.frame = CGRect(x: lblEmployee.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                        y: lblHeader2.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                        width: GlobalConst.SCREEN_WIDTH - (lblStatus.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                        height: GlobalConst.LABEL_HEIGHT)
        lblStatusValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblStatusValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblStatusValue.text = "1"
        scrollView.addSubview(lblStatusValue)
        
        // Label Report and ReportValue
        lblReport.translatesAutoresizingMaskIntoConstraints = true
        lblReport.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                        y: lblStatus.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                        width: GlobalConst.SCREEN_WIDTH / 3,
                                        height: GlobalConst.LABEL_HEIGHT)
        lblReport.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblReport.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblReport.text = " Báo cáo"
        lblReport.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblReport)
        
        lblReportValue.translatesAutoresizingMaskIntoConstraints = true
        lblReportValue.frame = CGRect(x: lblEmployeePhone.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                             y: lblStatusValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                             width: GlobalConst.SCREEN_WIDTH - (lblReport.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                             height: GlobalConst.LABEL_HEIGHT)
        lblReportValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblReportValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblReportValue.text = "2"
        scrollView.addSubview(lblReportValue)

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
