//
//  PeriodUpholdDetailCustomerViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class PeriodUpholdDetailCustomerViewController: UIViewController {
    
    // MARK: Header and label declare
    let lblHeader0 = UILabel()
    let lblHeader1 = UILabel()
    let lblHeader2 = UILabel()

    var lblUpholdDate = UILabel()
    var lblUpholdDateValue = UILabel()
    
    var lblCustomerName = UITextView()
    var lblCustomerNameValue = UITextView()
    
    var lblAddress = UITextView()
    var lblAddressValue = UITextView()
    
    var lblUpholdPeriod = UILabel()
    var lblUpholdPeriodValue = UILabel()
    
    var lblEmployee = UILabel()
    var lblEmployeeValue = UILabel()
    
    var lblEmployeePhone = UILabel()
    var lblEmployeePhoneValue = UILabel()
    
    var lblStatus = UILabel()
    var lblStatusValue = UILabel()
    
    var lblReport = UILabel()
    var lblReportValue = UILabel()

    // ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - ViewDidLoad
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
        scrollView.contentSize = CGSize(width : self.view.frame.size.width - GlobalConst.PARENT_BORDER_WIDTH * 4, height : self.view.frame.size.height - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH * 3))

        //MARK: Header0 and Label
        /**
         * Header 0 - Uphold Request Detail
         */
        // Header 0
        lblHeader0.translatesAutoresizingMaskIntoConstraints = true
        print(lblHeader0.frame.origin.y)
        lblHeader0.layer.masksToBounds = true
        lblHeader0.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        lblHeader0.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        lblHeader0.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblHeader0.text = "Bảo trì định kỳ"
        lblHeader0.textColor = UIColor.white
        lblHeader0.textAlignment = .center
        scrollView.addSubview(lblHeader0)
        lblHeader0.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: 0,
                                  width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                  height: GlobalConst.LABEL_HEIGHT)
        // Label CreateDate and CreateDateValue
        lblUpholdDate.translatesAutoresizingMaskIntoConstraints = true
                lblUpholdDate.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblUpholdDate.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblUpholdDate.text = " Ngày tạo"
        lblUpholdDate.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblUpholdDate)
        lblUpholdDate.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                     y: lblHeader0.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                     width: GlobalConst.SCREEN_WIDTH / 3,
                                     height: GlobalConst.LABEL_HEIGHT)

        lblUpholdDateValue.translatesAutoresizingMaskIntoConstraints = true
        lblUpholdDateValue.frame = CGRect(x: lblUpholdDate.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                          y: lblHeader0.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
                                          width: GlobalConst.SCREEN_WIDTH - (lblUpholdDate.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                          height: GlobalConst.LABEL_HEIGHT)
        lblUpholdDateValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblUpholdDateValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblUpholdDateValue.text = "1"
        scrollView.addSubview(lblUpholdDateValue)
        // Label CustomerName and CustomerNameValue
        lblCustomerName.translatesAutoresizingMaskIntoConstraints = true
        lblCustomerName.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                       y: lblUpholdDate.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH / 3,
                                       height: GlobalConst.LABEL_HEIGHT * 2)
        lblCustomerName.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblCustomerName.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblCustomerName.text = "Tên KH"
        lblCustomerName.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblCustomerName.isUserInteractionEnabled = false
        scrollView.addSubview(lblCustomerName)
        
        lblCustomerNameValue.translatesAutoresizingMaskIntoConstraints = true
        lblCustomerNameValue.frame = CGRect(x: lblUpholdDate.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                            y: lblUpholdDateValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                            width: GlobalConst.SCREEN_WIDTH - (lblCustomerName.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
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
        
        // Label UpholdPeriod and UpholdPeriodValue
        lblUpholdPeriod.translatesAutoresizingMaskIntoConstraints = true
        lblUpholdPeriod.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblAddress.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                  width: GlobalConst.SCREEN_WIDTH / 3,
                                  height: GlobalConst.LABEL_HEIGHT)
        lblUpholdPeriod.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblUpholdPeriod.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblUpholdPeriod.text = " Lịch bảo trì"
        lblUpholdPeriod.font = UIFont.boldSystemFont(ofSize: 15.0)
        scrollView.addSubview(lblUpholdPeriod)
        
        lblUpholdPeriodValue.translatesAutoresizingMaskIntoConstraints = true
        lblUpholdPeriodValue.frame = CGRect(x: lblUpholdPeriod.frame.maxX - GlobalConst.BUTTON_BORDER_WIDTH,
                                       y: lblAddressValue.frame.maxY - GlobalConst.BUTTON_BORDER_WIDTH,
                                       width: GlobalConst.SCREEN_WIDTH - (lblUpholdPeriod.frame.size.width) - (GlobalConst.PARENT_BORDER_WIDTH * 6),
                                       height: GlobalConst.LABEL_HEIGHT)
        lblUpholdPeriodValue.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblUpholdPeriodValue.layer.borderColor = GlobalConst.BACKGROUND_COLOR_GRAY.cgColor
        lblUpholdPeriodValue.text = "4"
        scrollView.addSubview(lblUpholdPeriodValue)
        // MARK: - Header 1 and label
        /**
         * Header 1 - Uphold Emplyee Detail
         */
        lblHeader1.translatesAutoresizingMaskIntoConstraints = true
        lblHeader1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblUpholdPeriod.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
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
        // MARK: - Header 2 and label
        /**
         * Header 2 - Uphold Result Detail
         */
        lblHeader2.translatesAutoresizingMaskIntoConstraints = true
        lblHeader2.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                  y: lblEmployeePhone.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH,
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
