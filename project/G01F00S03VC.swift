//
//  ProblemUpholdDetailCustomerViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F00S03VC: CommonViewController, UIPopoverPresentationControllerDelegate {

    
    let lblHeader0 = UILabel()
    let lblHeader1 = UILabel()
    let lblHeader2 = UILabel()
    
    var lblCreateDate = UILabel()
    var lblCreateDateValue = UITextView()
    
    var lblCustomerName = UILabel()
    var lblCustomerNameValue = UITextView()
    
    var lblAddress = UILabel()
    var lblAddressValue = UITextView()
    
    var lblContact = UILabel()
    var lblContactValue = UITextView()
    
    var lblIssue = UILabel()
    var lblIssueValue = UITextView()
    
    var lblContent = UILabel()
    var lblContentValue = UITextView()
    
    var lblEmployee = UILabel()
    var lblEmployeeValue = UITextView()
    
    var lblEmployeePhone = UILabel()
    var lblEmployeePhoneValue = UITextView()
    
    var lblHandlingTime = UILabel()
    var lblHandlingTimeValue = UITextView()
    
    var lblStatus = UILabel()
    var lblStatusValue = UITextView()
    
    var lblReport = UILabel()
    var lblReportValue = UITextView()
    /** Report wrong value */
    var lblReportWrong = UILabel()
    
    
    // ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    /**
     * Handle when tap on Issue menu item
     */
    func issueButtonInAccountVCTapped(_ notification: Notification) {
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let configVC = mainStoryboard.instantiateViewControllerWithIdentifier("issueViewController")
         self.navigationController?.pushViewController(configVC, animated: true)
         */
        print("issue button tapped")
    }
    
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.gasServiceItemTapped(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(G01F00S03VC.issueButtonInAccountVCTapped(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_ISSUE_ITEM),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(super.configItemTap(_:)),
            name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_COFIG_ITEM_CREATE_UPHOLD),
            object: nil)
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
    
        // MARK: Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // MARK: - NavBar
        setupNavigationBar(title: GlobalConst.CONTENT00143, isNotifyEnable: true)
        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S03VC.setData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_UPHOLD_DETAIL_VIEW), object: nil)

        // Do any additional setup after loading the view.// Set data
        if Singleton.sharedInstance.sharedInt != -1 {
            // Check data is existed
            if Singleton.sharedInstance.upholdList.record.count > Singleton.sharedInstance.sharedInt {
                CommonProcess.requestUpholdDetail(upholdId: Singleton.sharedInstance.upholdList.record[Singleton.sharedInstance.sharedInt].id, replyId: Singleton.sharedInstance.upholdList.record[Singleton.sharedInstance.sharedInt].reply_id, view: self)
            }
        }
    }
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        let marginX = GlobalConst.PARENT_BORDER_WIDTH
        let height  = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        var offset  = height + GlobalConst.MARGIN_CELL_Y
        
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(width : self.view.frame.size.width - GlobalConst.PARENT_BORDER_WIDTH * 4, height : GlobalConst.LABEL_HEIGHT * 17 + GlobalConst.PARENT_BORDER_WIDTH * 7)
        //scrollView.scrollRectToVisible(CGRect(x: 0,y: 44 , width: self.view.frame.size.width, height: self.view.frame.size.height -  44) , animated: true)
        
        //MARK: Header0 and Label
        /**
         * Header 0 - Uphold Request Detail
         */
        offset = GlobalConst.MARGIN_CELL_Y * 2 - height
        setHeader(header: lblHeader0, offset: offset)
        offset = lblHeader0.frame.maxY + GlobalConst.MARGIN_CELL_Y
        
        // Label CreateDate and CreateDateValue
        setLayoutLeft(lbl: lblCreateDate, offset: offset,
                      height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00096,
                      isDrawTopBorder: false)
        setLayoutRight(lbl: lblCreateDateValue, offset: offset,
                       height: GlobalConst.LABEL_HEIGHT, text: "",
                       isDrawTopBorder: false)
        offset = lblCreateDate.frame.maxY
        
        // Customer name
        setLayoutLeft(lbl: lblCustomerName, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00079)
        setLayoutRight(lbl: lblCustomerNameValue, offset: offset,
                       height: GlobalConst.LABEL_HEIGHT * 2, text: "")
        offset = lblCustomerName.frame.maxY
        
        // Label Address and AddressValue
        setLayoutLeft(lbl: lblAddress, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00088)
        setLayoutRight(lbl: lblAddressValue, offset: offset,
                       height: GlobalConst.LABEL_HEIGHT * 2, text: "")
        offset = lblAddress.frame.maxY
        
        // Label Contact and ContactValue
        if Singleton.sharedInstance.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
            setLayoutLeft(lbl: lblContact, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00146)
            setLayoutRight(lbl: lblContactValue, offset: offset,
                           height: GlobalConst.LABEL_HEIGHT * 2, text: "")
            offset = lblContact.frame.maxY
            
            // Label Issue and IssueValue
            setLayoutLeft(lbl: lblIssue, offset: offset,
                          height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00147)
            setLayoutRight(lbl: lblIssueValue, offset: offset,
                           height: GlobalConst.LABEL_HEIGHT, text: "")
            offset = lblIssue.frame.maxY
            
            // Label Content and ContentValue
            setLayoutLeft(lbl: lblContent, offset: offset, height: GlobalConst.LABEL_HEIGHT * 2, text: GlobalConst.CONTENT00063)
            setLayoutRight(lbl: lblContentValue, offset: offset,
                           height: GlobalConst.LABEL_HEIGHT * 2, text: "")
            offset = lblContent.frame.maxY + GlobalConst.MARGIN_CELL_Y
        } else {
            setLayoutLeft(lbl: lblContact, offset: offset, height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00161)
            setLayoutRight(lbl: lblContactValue, offset: offset,
                           height: GlobalConst.LABEL_HEIGHT, text: "")
            offset = lblContact.frame.maxY
        }
        
        
        // MARK: - Header 1 and label
        /**
         * Header 1 - Uphold Emplyee Detail
         */
        setHeader(header: lblHeader1, offset: offset, text: GlobalConst.CONTENT00156)
        
        offset = lblHeader1.frame.maxY + GlobalConst.MARGIN_CELL_Y
        // Label Employee and EmployeeValue
        setLayoutLeft(lbl: lblEmployee, offset: offset,
                      height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00145, isDrawTopBorder: false)
        setLayoutRight(lbl: lblEmployeeValue, offset: offset,
                       height: GlobalConst.LABEL_HEIGHT, text: "", isDrawTopBorder: false)
        offset = lblEmployee.frame.maxY
        
        // Label EmployeePhone and EmployeePhoneValue
        setLayoutLeft(lbl: lblEmployeePhone, offset: offset,
                      height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00152)
        setLayoutRight(lbl: lblEmployeePhoneValue, offset: offset,
                       height: GlobalConst.LABEL_HEIGHT, text: "")
        offset = lblEmployeePhone.frame.maxY
        
        // Label HandlingTime and HandlingTimeValue
        if Singleton.sharedInstance.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
            setLayoutLeft(lbl: lblHandlingTime, offset: offset,
                          height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00157)
            setLayoutRight(lbl: lblHandlingTimeValue, offset: offset,
                           height: GlobalConst.LABEL_HEIGHT, text: "")
            offset = lblHandlingTime.frame.maxY + GlobalConst.MARGIN_CELL_Y
        }
        
        // MARK: - Header 2 and label
        /**
         * Header 2 - Uphold Result Detail
         */
        setHeader(header: lblHeader2, offset: offset, text: GlobalConst.CONTENT00158)
        offset = lblHeader2.frame.maxY + GlobalConst.MARGIN_CELL_Y
        
        if Singleton.sharedInstance.currentUpholdDetail.status_number == DomainConst.UPHOLD_STATUS_COMPLETE {
            if Singleton.sharedInstance.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
                if Singleton.sharedInstance.currentUpholdDetail.report_wrong.isEmpty {
                    // Label Status and StatusValue
                    setLayoutLeft(lbl: lblStatus, offset: offset,
                                  height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092, isDrawTopBorder: false)
                    setLayoutRight(lbl: lblStatusValue, offset: offset,
                                   height: GlobalConst.LABEL_HEIGHT, text: "", isDrawTopBorder: false)
                    offset = lblStatus.frame.maxY
                    
                    // Label Report and ReportValue
                    setLayoutLeft(lbl: lblReport, offset: offset,
                                  height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00159)
                    setLayoutRight(lbl: lblReportValue, offset: offset,
                                   height: GlobalConst.LABEL_HEIGHT, text: "")
                    offset = lblReport.frame.maxY
                } else {
                    lblReportWrong.translatesAutoresizingMaskIntoConstraints = true
                    lblReportWrong.frame = CGRect(
                        x: GlobalConst.MARGIN_CELL_X + GlobalConst.PARENT_BORDER_WIDTH,
                        y: offset,
                        width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2,
                        height: GlobalConst.LABEL_HEIGHT
                    )
                    lblReportWrong.font = UIFont.boldSystemFont(ofSize: 15.0)
                    scrollView.addSubview(lblReportWrong)
                    offset += GlobalConst.LABEL_HEIGHT
                }
            } else {
                // Label Status and StatusValue
                setLayoutLeft(lbl: lblStatus, offset: offset,
                              height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00092)
                setLayoutRight(lbl: lblStatusValue, offset: offset,
                               height: GlobalConst.LABEL_HEIGHT, text: "")
                offset = lblStatus.frame.maxY
                
                // Label Report and ReportValue
                setLayoutLeft(lbl: lblReport, offset: offset,
                              height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00159)
                setLayoutRight(lbl: lblReportValue, offset: offset,
                               height: GlobalConst.LABEL_HEIGHT, text: "")
                offset = lblReport.frame.maxY
            }
        } else {
            if Singleton.sharedInstance.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
                if !Singleton.sharedInstance.currentUpholdDetail.report_wrong.isEmpty {
                    lblReportWrong.translatesAutoresizingMaskIntoConstraints = true
                    lblReportWrong.frame = CGRect(
                        x: GlobalConst.MARGIN_CELL_X + GlobalConst.PARENT_BORDER_WIDTH,
                        y: offset,
                        width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2,
                        height: GlobalConst.LABEL_HEIGHT
                    )
                    lblReportWrong.font = UIFont.boldSystemFont(ofSize: 15.0)
                    scrollView.addSubview(lblReportWrong)
                    offset += GlobalConst.LABEL_HEIGHT
                }
            }
        }
        /**
         * scrollView
         */
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.frame = CGRect(x: marginX + GlobalConst.MARGIN_CELL_X,
                                  y: height + GlobalConst.MARGIN_CELL_Y,
                                  width: GlobalConst.SCREEN_WIDTH - (marginX + GlobalConst.MARGIN_CELL_X) * 2,
                                  height: GlobalConst.SCREEN_HEIGHT - height - GlobalConst.MARGIN_CELL_Y * 2 - GlobalConst.PARENT_BORDER_WIDTH)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: offset)
        scrollView.backgroundColor = UIColor.white
        CommonProcess.setBorder(view: scrollView)
        
        if Singleton.sharedInstance.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
            lblHeader0.text = GlobalConst.CONTENT00041.uppercased()
            lblCreateDate.text = GlobalConst.CONTENT00096
            lblContactValue.text        = Singleton.sharedInstance.currentUpholdDetail.contact_person + " - " +
                Singleton.sharedInstance.currentUpholdDetail.contact_tel
        } else {
            lblHeader0.text             = GlobalConst.CONTENT00040.uppercased()
            lblCreateDate.text          = GlobalConst.CONTENT00160
            lblContactValue.text        = Singleton.sharedInstance.currentUpholdDetail.schedule_month
        }
        lblCreateDateValue.text     = Singleton.sharedInstance.currentUpholdDetail.created_date
        lblCustomerNameValue.text   = Singleton.sharedInstance.currentUpholdDetail.customer_name
        lblAddressValue.text        = Singleton.sharedInstance.currentUpholdDetail.customer_address
        lblIssueValue.text          = Singleton.sharedInstance.currentUpholdDetail.type_uphold
        lblContentValue.text        = Singleton.sharedInstance.currentUpholdDetail.content
        lblEmployeeValue.text       = Singleton.sharedInstance.currentUpholdDetail.employee_name
        lblEmployeePhoneValue.text  = Singleton.sharedInstance.currentUpholdDetail.employee_phone
        if Singleton.sharedInstance.currentUpholdDetail.reply_item.count > 0 {
            lblHandlingTimeValue.text   = Singleton.sharedInstance.currentUpholdDetail.reply_item[0].date_time_handle
        }
        lblStatusValue.text         = Singleton.sharedInstance.currentUpholdDetail.status
        lblReportValue.text         = Singleton.sharedInstance.currentUpholdDetail.last_reply_message
        lblReportWrong.text         = Singleton.sharedInstance.currentUpholdDetail.report_wrong
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverMenu" {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    /**
     * ...
     */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
    func setHeader(header: UILabel, offset: CGFloat, text: String = GlobalConst.CONTENT00041) {
        header.translatesAutoresizingMaskIntoConstraints = true
        header.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                              y: offset,
                              width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2 + GlobalConst.MARGIN_CELL_X * 4),
                              height: GlobalConst.LABEL_HEIGHT)
        header.layer.masksToBounds = true
        header.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        header.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        header.font = UIFont.boldSystemFont(ofSize: 15.0)
        header.text = text.uppercased()
        header.textColor = UIColor.white
        header.textAlignment = .center
        scrollView.addSubview(header)
    }
    
    
    /**
     * Set layout for left controls
     * - parameter lbl:     Label control
     * - parameter offset:  Y offset
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    func setLayoutLeft(lbl: UILabel, offset: CGFloat, height: CGFloat, text: String, isDrawTopBorder: Bool = true) {
        CommonProcess.setLayoutLeft(lbl: lbl, offset: offset, height: height, text: text, isDrawTopBorder: isDrawTopBorder)
        lbl.font            = UIFont.boldSystemFont(ofSize: 15.0)
        lbl.lineBreakMode   = .byWordWrapping
        lbl.numberOfLines   = 0
        scrollView.addSubview(lbl)
    }
    
    /**
     * Set layout for right controls
     * - parameter lbl:     TextView control
     * - parameter offset:  Y offset
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    func setLayoutRight(lbl: UITextView, offset: CGFloat, height: CGFloat, text: String, isDrawTopBorder: Bool = true) {
        CommonProcess.setLayoutRight(lbl: lbl, offset: offset, height: height, text: text, isDrawTopBorder: isDrawTopBorder)
        lbl.font = UIFont.systemFont(ofSize: 15.0)
        scrollView.addSubview(lbl)
    }
}
