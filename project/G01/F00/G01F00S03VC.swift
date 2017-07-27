//
//  ProblemUpholdDetailCustomerViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

//++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
//class G01F00S03VC: BaseViewController {
class G01F00S03VC: ChildViewController, RatingViewDelegate {
//-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
    // MARK: Properties
    let lblHeader0 = UILabel()
    let lblHeader1 = UILabel()
    let lblHeader2 = UILabel()
    let lblHeader3 = UILabel()
    
    var lblCreateDate = UILabel()
    var imgCreateDateIcon = UIImageView()
    
    var lblCustomerName = UILabel()
    var imgCustomerNameIcon = UIImageView()
    
    var lblAddress = UILabel()
    var imgAddressIcon = UIImageView()
    
    var lblContact = UILabel()
    var imgContactIcon = UIImageView()
    
    var lblIssue = UILabel()
    var imgIssueIcon = UIImageView()
    
    var lblContent = UILabel()
    var imgContentIcon = UIImageView()
    
    var lblEmployee = UILabel()
    var imgEmployeeIcon = UIImageView()
    
    var lblEmployeePhone = UIButton()
    var imgEmployeePhoneIcon = UIImageView()
    
    var lblHandlingTime = UILabel()
    var imgHandlingTimeIcon = UIImageView()
    
    var lblStatus = UILabel()
    var imgStatusIcon = UIImageView()
    
    var lblReport = UILabel()
    var imgReportIcon = UIImageView()
    
    /** Report wrong value */
    var lblReportWrong = UILabel()
    // MARK: Properties
    /** Label Feeling */
    var lblFeeling: UILabel = UILabel()
    /** Status value */
    var tbxFeeling: UITextView = UITextView()
    /** Label Time */
    var lblContentRating: UILabel = UILabel()
    /** Time value */
    var tbxContent: UITextView = UITextView()
    var attrs: [String : Any]  = [
        NSFontAttributeName : UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1),
        NSForegroundColorAttributeName : UIColor.blue,
        NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue,
        ]
    //++ BUG0127-SPJ (NguyenPT 20170724) Uphold rating: merge to 1 step
    /** Rating view */
    private var rating: RatingView?
    //-- BUG0127-SPJ (NguyenPT 20170724) Uphold rating: merge to 1 step
    
    // ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Methods
    //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//    /**
//     * Handle when tap menu item
//     */
//    func asignNotifyForMenuItem() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.gasServiceItemTapped(_:)),
//            name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_GAS_SERVICE_ITEM),
//            object: nil)
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(super.issueItemTapped(_:)),
//            name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_ISSUE_ITEM),
//            object: nil)
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(super.configItemTap(_:)),
//            name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_COFIG_ITEM_CREATE_UPHOLD),
//            object: nil)
//    }
    //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        //++ BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
//        // Menu item tap
//        asignNotifyForMenuItem()
        //-- BUG0043-SPJ (NguyenPT 20170301) Change how to menu work
    
        // MARK: Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        // MARK: - NavBar
        //++ BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        //setupNavigationBar(title: DomainConst.CONTENT00143, isNotifyEnable: true)
        createNavigationBar(title: DomainConst.CONTENT00143)
        //-- BUG0048-SPJ (NguyenPT 20170309) Create slide menu view controller
        //++ BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
//        NotificationCenter.default.addObserver(self, selector: #selector(G01F00S03VC.setData(_:)),
//                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_UPHOLD_DETAIL_VIEW),
//                                               object: nil)
        //-- BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion

        // Do any additional setup after loading the view.
        //++ BUG0049-SPJ (NguyenPT 20170313) Handle notification received
//        // Set data
//        if BaseModel.shared.sharedInt != -1 {
//            // Check data is existed
//            if BaseModel.shared.upholdList.getRecord().count > BaseModel.shared.sharedInt {
//                //++ BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
////                RequestAPI.requestUpholdDetail(upholdId: BaseModel.shared.upholdList.getRecord()[BaseModel.shared.sharedInt].id,
////                                               replyId: BaseModel.shared.upholdList.getRecord()[BaseModel.shared.sharedInt].reply_id,
////                                               view: self)
//                let bean = BaseModel.shared.upholdList.getRecord()[BaseModel.shared.sharedInt]
//                UpholdDetailRequest.requestUpholdDetail(action: #selector(self.setData(_:)),
//                                                        view: self,
//                                                        upholdId: bean.id,
//                                                        replyId: bean.reply_id)
//                //-- BUG0046-SPJ (NguyenPT 20170302) Use action for Request server completion
//            }
//        }
        UpholdDetailRequest.requestUpholdDetail(action: #selector(self.finishRequestUpholdDetail(_:)),
                                                view: self,
                                                upholdId: BaseModel.shared.sharedDoubleStr.0,
                                                replyId: BaseModel.shared.sharedDoubleStr.1)
        //-- BUG0049-SPJ (NguyenPT 20170313) Handle notification received
        // Notification
        if BaseModel.shared.checkNotificationExist() {
            BaseModel.shared.clearNotificationData()
        }
    }
    
    internal func finishRequestUpholdDetail(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = UpholdDetailRespModel(jsonString: data)
        if model.isSuccess() {
            BaseModel.shared.saveCurrentUpholdDetail(model: model.model_uphold)
            setData(notification)
        } else {
            showAlert(message: model.message)
        }
    }
    
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
        let marginX     = GlobalConst.PARENT_BORDER_WIDTH
        let leftWidth   = GlobalConst.CELL_HEIGHT_SHOW / 5 + GlobalConst.MARGIN_CELL_X
        let rightWidth  = GlobalConst.SCREEN_WIDTH - leftWidth
        // Get height of status bar + navigation bar
        let height      = self.getTopHeight()
        var offset      = height + GlobalConst.MARGIN_CELL_Y
        
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(width : self.view.frame.size.width - GlobalConst.PARENT_BORDER_WIDTH * 4,
                                        height : GlobalConst.LABEL_HEIGHT * 17 + GlobalConst.PARENT_BORDER_WIDTH * 7)
        //scrollView.scrollRectToVisible(CGRect(x: 0,y: 44 , width: self.view.frame.size.width, height: self.view.frame.size.height -  44) , animated: true)
        
        // MARK: Header0 and Label
        /**
         * Header 0 - Uphold Request Detail
         */
        offset = GlobalConst.MARGIN_CELL_Y * 2 - height
        setHeader(header: lblHeader0, offset: offset)
        offset = lblHeader0.frame.maxY + GlobalConst.MARGIN_CELL_Y
        
//        // Customer
//        self.imgCustomerNameIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
//                                        y: offset + GlobalConst.CELL_HEIGHT_SHOW / 10,
//                                        width: GlobalConst.CELL_HEIGHT_SHOW / 5,
//                                        height: GlobalConst.CELL_HEIGHT_SHOW / 5)
//        self.imgCustomerNameIcon.contentMode = .scaleAspectFit
//        self.imgCustomerNameIcon.image = UIImage(named: DomainConst.CUSTOMER_ICON_IMG_NAME)
//        // Customer name label
//        self.lblCustomerName.frame = CGRect(x: self.imgCustomerNameIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
//                                         y: offset,
//                                         width: rightWidth,
//                                         height: GlobalConst.CELL_HEIGHT_SHOW / 5 * 2)
//        self.lblCustomerName.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
//        self.lblCustomerName.textColor = GlobalConst.BUTTON_COLOR_RED
//        self.lblCustomerName.text = DomainConst.BLANK
//        self.lblCustomerName.numberOfLines = 0
//        self.lblCustomerName.lineBreakMode = .byWordWrapping
//        offset += self.lblCustomerName.frame.height + GlobalConst.MARGIN_CELL_Y
        
        // Date icon
        self.imgCreateDateIcon.frame        = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                                     y: offset,
                                                     width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                     height: GlobalConst.CELL_HEIGHT_SHOW / 5)
        self.imgCreateDateIcon.contentMode  = .scaleAspectFit
        self.imgCreateDateIcon.image        = ImageManager.getImage(named: DomainConst.DATETIME_ICON_IMG_NAME)
        // Create Date label
        self.lblCreateDate.frame            = CGRect(x: self.imgCreateDateIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                     y: offset,
                                                     width: rightWidth,
                                                     height: self.imgCreateDateIcon.frame.height)
        self.lblCreateDate.font             = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
        self.lblCreateDate.textColor        = UIColor.black
        self.lblCreateDate.text             = DomainConst.BLANK
        offset += self.lblCreateDate.frame.height + GlobalConst.MARGIN_CELL_Y
        
//        // Address icon
//        self.imgAddressIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
//                                           y: offset + GlobalConst.CELL_HEIGHT_SHOW / 10,
//                                           width: GlobalConst.CELL_HEIGHT_SHOW / 5,
//                                           height: GlobalConst.CELL_HEIGHT_SHOW / 5)
//        self.imgAddressIcon.contentMode = .scaleAspectFit
//        self.imgAddressIcon.image = UIImage(named: "icon47.png")
//        // Address label
//        self.lblAddress.frame = CGRect(x: self.imgAddressIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
//                                       y: offset,
//                                       width: rightWidth,
//                                       height: GlobalConst.CELL_HEIGHT_SHOW / 5 * 2)
//        self.lblAddress.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
//        self.lblAddress.textColor = UIColor.black
//        self.lblAddress.text = DomainConst.BLANK
//        self.lblAddress.numberOfLines = 0
//        self.lblAddress.lineBreakMode = .byWordWrapping
//        offset += self.lblAddress.frame.height + GlobalConst.MARGIN_CELL_Y
        
        // Contact icon
        self.imgContactIcon.frame       = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                                 y: offset + GlobalConst.CELL_HEIGHT_SHOW / 10,
                                                 width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                 height: GlobalConst.CELL_HEIGHT_SHOW / 5)
        self.imgContactIcon.contentMode = .scaleAspectFit
        self.imgContactIcon.image       = ImageManager.getImage(named: DomainConst.CONTACT_ICON_IMG_NAME)
        // Contact label
        self.lblContact.frame           = CGRect(x: self.imgContactIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                 y: offset,
                                                 width: rightWidth / 2,
                                                 height: GlobalConst.CELL_HEIGHT_SHOW / 5 * 2)
        self.lblContact.font            = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
        self.lblContact.textColor       = UIColor.black
        self.lblContact.text            = DomainConst.BLANK
        self.lblContact.numberOfLines   = 0
        self.lblContact.lineBreakMode   = .byWordWrapping
        
        // Check uphold type is Problem type
        if BaseModel.shared.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
            // Issue icon
            self.imgIssueIcon.frame         = CGRect(x: self.lblContact.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                     y: self.imgContactIcon.frame.minY,
                                                     width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                     height: GlobalConst.CELL_HEIGHT_SHOW / 5)
            self.imgIssueIcon.contentMode   = .scaleAspectFit
            self.imgIssueIcon.image         = ImageManager.getImage(named: DomainConst.PROBLEM_TYPE_IMG_NAME)
            // Issue label
            self.lblIssue.frame             = CGRect(x: self.imgIssueIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                     y: offset,
                                                     width: rightWidth / 2,
                                                     height: GlobalConst.CELL_HEIGHT_SHOW / 5 * 2)
            self.lblIssue.font              = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
            self.lblIssue.textColor         = UIColor.black
            self.lblIssue.text              = DomainConst.BLANK
            self.lblIssue.numberOfLines     = 0
            self.lblIssue.lineBreakMode     = .byWordWrapping
        }
        offset += self.lblContact.frame.height + GlobalConst.MARGIN_CELL_Y
        
        // Check content is empty or not
        if !BaseModel.shared.currentUpholdDetail.content.isEmpty {
            // Content icon
            self.imgContentIcon.frame       = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                                     y: offset,
                                                     width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                     height: GlobalConst.CELL_HEIGHT_SHOW / 5)
            self.imgContentIcon.contentMode = .scaleAspectFit
            self.imgContentIcon.image       = ImageManager.getImage(named: DomainConst.CONTENT_ICON_IMG_NAME)
            // Content label
            self.lblContent.frame           = CGRect(x: self.imgContentIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                     y: offset,
                                                     width: rightWidth,
                                                     height: self.imgContentIcon.frame.height)
            self.lblContent.font            = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
            self.lblContent.textColor       = UIColor.black
            self.lblContent.text            = DomainConst.BLANK
            offset += self.lblContent.frame.height + GlobalConst.MARGIN_CELL_Y
        }
        
        // MARK: - Header 1 and label
        /**
         * Header 1 - Uphold Emplyee Detail
         */
        offset += GlobalConst.MARGIN_CELL_Y * 2
        setHeader(header: lblHeader1, offset: offset, text: DomainConst.CONTENT00156)
        
        offset = lblHeader1.frame.maxY + GlobalConst.MARGIN_CELL_Y
        
        // Employee icon
        self.imgEmployeeIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                                y: offset,
                                                width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                height: GlobalConst.CELL_HEIGHT_SHOW / 5)
        self.imgEmployeeIcon.contentMode = .scaleAspectFit
        self.imgEmployeeIcon.image = ImageManager.getImage(named: DomainConst.HUMAN_ICON_IMG_NAME)
        // Employee name label
        self.lblEmployee.frame = CGRect(x: self.imgEmployeeIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                            y: offset,
                                            width: rightWidth,
                                            height: self.imgEmployeeIcon.frame.height)
        self.lblEmployee.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self.lblEmployee.textColor = GlobalConst.BUTTON_COLOR_RED
        self.lblEmployee.text = DomainConst.BLANK
        offset += self.lblEmployee.frame.height + GlobalConst.MARGIN_CELL_Y
        
        // Employee phone icon
        self.imgEmployeePhoneIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                           y: offset,
                                           width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                           height: GlobalConst.CELL_HEIGHT_SHOW / 5)
        self.imgEmployeePhoneIcon.contentMode = .scaleAspectFit
        self.imgEmployeePhoneIcon.image = ImageManager.getImage(named: DomainConst.CONTACT_ICON_IMG_NAME)
        // Employee phone label
        self.lblEmployeePhone.frame = CGRect(x: self.imgEmployeePhoneIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                       y: offset,
                                       width: rightWidth / 2,
                                       height: self.imgEmployeePhoneIcon.frame.height)
        self.lblEmployeePhone.addTarget(self, action: #selector(phonetap), for: .touchUpInside)
        
        if BaseModel.shared.currentUpholdDetail.reply_item.count > 0 {
            // Handle time icon
            self.imgHandlingTimeIcon.frame = CGRect(x: self.lblEmployeePhone.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                    y: offset,
                                                    width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                    height: GlobalConst.CELL_HEIGHT_SHOW / 5)
            self.imgHandlingTimeIcon.contentMode = .scaleAspectFit
            self.imgHandlingTimeIcon.image = ImageManager.getImage(named: DomainConst.DATETIME_ICON_IMG_NAME)
            // Handle time label
            self.lblHandlingTime.frame = CGRect(x: self.imgHandlingTimeIcon.frame.maxX,
                                                y: offset,
                                                width: rightWidth / 2,
                                                height: self.imgHandlingTimeIcon.frame.height)
            self.lblHandlingTime.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
            self.lblHandlingTime.textColor = UIColor.black
            self.lblHandlingTime.text = DomainConst.BLANK
        }
        offset += self.imgEmployeePhoneIcon.frame.height + GlobalConst.MARGIN_CELL_Y
        
        // MARK: - Header 2 and label
        /**
         * Header 2 - Uphold Result Detail
         */
        offset += GlobalConst.MARGIN_CELL_Y * 2
        setHeader(header: lblHeader2, offset: offset, text: DomainConst.CONTENT00158)
        offset = lblHeader2.frame.maxY + GlobalConst.MARGIN_CELL_Y
        
        if BaseModel.shared.currentUpholdDetail.status_number == DomainConst.UPHOLD_STATUS_COMPLETE {
            if BaseModel.shared.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
                if BaseModel.shared.currentUpholdDetail.report_wrong.isEmpty {
                    // Status icon
                    self.imgStatusIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                                             y: offset,
                                                             width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                             height: GlobalConst.CELL_HEIGHT_SHOW / 5)
                    self.imgStatusIcon.contentMode = .scaleAspectFit
                    self.imgStatusIcon.image = ImageManager.getImage(named: DomainConst.STATUS_ICON_IMG_NAME)
                    // Status label
                    self.lblStatus.frame = CGRect(x: self.imgStatusIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                         y: offset,
                                                         width: rightWidth / 2,
                                                         height: self.imgStatusIcon.frame.height)
                    self.lblStatus.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
                    self.lblStatus.textColor = UIColor.black
                    self.lblStatus.text = DomainConst.BLANK
                    
                    // Report icon
                    self.imgReportIcon.frame = CGRect(x: self.lblStatus.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                      y: offset,
                                                      width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                      height: GlobalConst.CELL_HEIGHT_SHOW / 5)
                    self.imgReportIcon.contentMode = .scaleAspectFit
                    self.imgReportIcon.image = ImageManager.getImage(named: DomainConst.REPORT_ICON_IMG_NAME)
                    // Report label
                    self.lblReport.frame = CGRect(x: self.imgReportIcon.frame.maxX,
                                                  y: offset,
                                                  width: rightWidth / 2,
                                                  height: self.imgReportIcon.frame.height)
                    self.lblReport.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
                    self.lblReport.textColor = UIColor.black
                    self.lblReport.text = DomainConst.BLANK
                    offset = self.imgStatusIcon.frame.maxY
                } else {
                    lblReportWrong.translatesAutoresizingMaskIntoConstraints = true
                    lblReportWrong.frame = CGRect(
                        x: GlobalConst.MARGIN_CELL_X + GlobalConst.PARENT_BORDER_WIDTH,
                        y: offset,
                        width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2,
                        height: GlobalConst.LABEL_HEIGHT
                    )
                    lblReportWrong.font = UIFont.boldSystemFont(ofSize: 15.0)
                    //++ BUG0068-SPJ (NguyenPT 20170429) Add rating button
                    offset = self.lblReportWrong.frame.maxY
                    //-- BUG0068-SPJ (NguyenPT 20170429) Add rating button
                    scrollView.addSubview(lblReportWrong)
                    
//                    // Report icon
//                    self.imgReportIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
//                                                      y: offset,
//                                                      width: GlobalConst.CELL_HEIGHT_SHOW / 5,
//                                                      height: GlobalConst.CELL_HEIGHT_SHOW / 5)
//                    self.imgReportIcon.contentMode = .scaleAspectFit
//                    self.imgReportIcon.image = UIImage(named: DomainConst.REPORT_ICON_IMG_NAME)
//                    // Report label
//                    self.lblReport.frame = CGRect(x: self.imgReportIcon.frame.maxX,
//                                                  y: offset,
//                                                  width: rightWidth,
//                                                  height: self.imgReportIcon.frame.height)
//                    self.lblReport.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
//                    self.lblReport.textColor = UIColor.black
//                    self.lblReport.text = DomainConst.BLANK
//                    offset += GlobalConst.LABEL_HEIGHT
                }
            } else {
                // Status icon
                self.imgStatusIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                                  y: offset,
                                                  width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                  height: GlobalConst.CELL_HEIGHT_SHOW / 5)
                self.imgStatusIcon.contentMode = .scaleAspectFit
                self.imgStatusIcon.image = ImageManager.getImage(named: DomainConst.STATUS_ICON_IMG_NAME)
                // Status label
                self.lblStatus.frame = CGRect(x: self.imgStatusIcon.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                              y: offset,
                                              width: rightWidth / 2,
                                              height: self.imgStatusIcon.frame.height)
                self.lblStatus.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
                self.lblStatus.textColor = UIColor.black
                self.lblStatus.text = DomainConst.BLANK
                
                // Report icon
                self.imgReportIcon.frame = CGRect(x: self.lblStatus.frame.maxX + GlobalConst.MARGIN_CELL_X,
                                                  y: offset,
                                                  width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                                  height: GlobalConst.CELL_HEIGHT_SHOW / 5)
                self.imgReportIcon.contentMode = .scaleAspectFit
                self.imgReportIcon.image = ImageManager.getImage(named: DomainConst.REPORT_ICON_IMG_NAME)
                // Report label
                self.lblReport.frame = CGRect(x: self.imgReportIcon.frame.maxX,
                                              y: offset,
                                              width: rightWidth / 2,
                                              height: self.imgReportIcon.frame.height)
                self.lblReport.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE_1)
                self.lblReport.textColor = UIColor.black
                self.lblReport.text = DomainConst.BLANK
                offset = self.imgStatusIcon.frame.maxY
            }
        } else {
            if BaseModel.shared.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
                if !BaseModel.shared.currentUpholdDetail.report_wrong.isEmpty {
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
        
        //++ BUG0068-SPJ (NguyenPT 20170429) Add rating button
        let _btnRating: UIButton = UIButton()
        // Button Rating
        CommonProcess.createButtonLayout(btn: _btnRating,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y: offset + 2 * getTopHeight() + GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00098.uppercased(),
                                         action: #selector(btnRatingTapped),
                                         target: self,
                                         img: DomainConst.CANCEL_IMG_NAME,
                                         tintedColor: UIColor.white)
        _btnRating.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                  left: GlobalConst.MARGIN,
                                                  bottom: GlobalConst.MARGIN,
                                                  right: GlobalConst.MARGIN)
        if BaseModel.shared.currentUpholdDetail.status_number == DomainConst.UPHOLD_STATUS_COMPLETE && BaseModel.shared.currentUpholdDetail.rating_status.isEmpty {
            self.view.addSubview(_btnRating)
        }
        //-- BUG0068-SPJ (NguyenPT 20170429) Add rating button
        
        // Rating
        if !BaseModel.shared.currentUpholdDetail.rating_status.isEmpty {
            // Add controls
            if BaseModel.shared.listRatingType.count > 0 {
                for i in 0..<BaseModel.shared.listRatingType.count {
                    // Label title
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = true
                    label.frame = CGRect(
                        x: GlobalConst.MARGIN_CELL_X,
                        y: offset,
                        width: self.view.frame.width,
                        height: GlobalConst.LABEL_HEIGHT)
                    label.text               = BaseModel.shared.listRatingType[i].name
                    //label.textAlignment      = NSTextAlignment.center
                    label.font               = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
                    scrollView.addSubview(label)
                    offset += GlobalConst.LABEL_HEIGHT
                    
                    // Rating bar
                    let ratingBar = RatingBar()
                    ratingBar.translatesAutoresizingMaskIntoConstraints = true
                    let size = GlobalConst.LABEL_HEIGHT
                    let width = size * (CGFloat)(ratingBar._starCount) + (ratingBar._spacing * (CGFloat)(ratingBar._starCount - 1))
                    ratingBar.frame = CGRect(
                        x: (self.view.frame.width - width) / 2,
                        y: offset,
                        width: width,
                        height: size)
                    ratingBar.setBackgroundColor(color: UIColor.white)
                    ratingBar.setEnabled(isEnabled: true)
                    ratingBar.isUserInteractionEnabled = false
                    if BaseModel.shared.currentUpholdDetail.rating_type.count > i {
                        let ratingValue = Int(BaseModel.shared.currentUpholdDetail.rating_type[i].name)
                        ratingBar.setRatingValue(value: ratingValue!)
                    }
                    scrollView.addSubview(ratingBar)
                    offset += size
                }
            }
            
            // Label Feeling
            CommonProcess.setLayoutLeft(lbl: lblFeeling, offset: offset,
                                        width: (self.view.frame.width - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                        height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00210)
            lblFeeling.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
            // Feeling value
            var statusString: String = DomainConst.BLANK
            for status in BaseModel.shared.listRatingStatus {
                if status.id == BaseModel.shared.currentUpholdDetail.rating_status {
                    statusString = status.name
                    break
                }
            }
            CommonProcess.setLayoutRight(lbl: tbxFeeling, x: lblFeeling.frame.maxX, y: offset,
                                         width: (self.view.frame.width - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                         height: GlobalConst.LABEL_HEIGHT, text: statusString)
            tbxFeeling.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
            
            offset += GlobalConst.LABEL_HEIGHT
            
            if !BaseModel.shared.currentUpholdDetail.rating_note.isEmpty {
                // Label Content
                CommonProcess.setLayoutLeft(lbl: lblContentRating, offset: offset,
                                            width: (self.view.frame.width - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                            height: GlobalConst.LABEL_HEIGHT * 2, text: DomainConst.CONTENT00063)
                lblContentRating.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
                // Content value
                CommonProcess.setLayoutRight(lbl: tbxContent, x: lblContent.frame.maxX, y: offset,
                                             width: (self.view.frame.width - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                             height: GlobalConst.LABEL_HEIGHT * 2, text: BaseModel.shared.currentUpholdDetail.rating_note)
                tbxContent.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
                offset += GlobalConst.LABEL_HEIGHT * 2
            }
        }
        
        // Add control
        scrollView.addSubview(self.imgCustomerNameIcon)
        scrollView.addSubview(self.lblCustomerName)
        scrollView.addSubview(self.imgCreateDateIcon)
        scrollView.addSubview(self.lblCreateDate)
        scrollView.addSubview(self.imgAddressIcon)
        scrollView.addSubview(self.lblAddress)
        scrollView.addSubview(self.imgContactIcon)
        scrollView.addSubview(self.lblContact)
        scrollView.addSubview(self.imgIssueIcon)
        scrollView.addSubview(self.lblIssue)
        scrollView.addSubview(self.imgContentIcon)
        scrollView.addSubview(self.lblContent)
        scrollView.addSubview(self.imgEmployeeIcon)
        scrollView.addSubview(self.lblEmployee)
        scrollView.addSubview(self.imgEmployeePhoneIcon)
        scrollView.addSubview(self.lblEmployeePhone)
        scrollView.addSubview(self.imgHandlingTimeIcon)
        scrollView.addSubview(self.lblHandlingTime)
        scrollView.addSubview(self.imgStatusIcon)
        scrollView.addSubview(self.lblStatus)
        scrollView.addSubview(self.imgReportIcon)
        scrollView.addSubview(self.lblReport)
        scrollView.addSubview(self.lblContentRating)
        scrollView.addSubview(self.tbxContent)
        scrollView.addSubview(self.lblFeeling)
        scrollView.addSubview(self.tbxFeeling)
        
        
        /**
         * scrollView
         */
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.frame = CGRect(x: marginX + GlobalConst.MARGIN_CELL_X,
                                  y: height + GlobalConst.MARGIN_CELL_Y,
                                  width: GlobalConst.SCREEN_WIDTH - (marginX + GlobalConst.MARGIN_CELL_X) * 2,
                                  height: GlobalConst.SCREEN_HEIGHT - height - GlobalConst.MARGIN_CELL_Y * 2 - GlobalConst.PARENT_BORDER_WIDTH)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: offset > scrollView.frame.height ? offset : scrollView.frame.height - height - GlobalConst.MARGIN_CELL_Y)
        scrollView.backgroundColor = UIColor.white
        //CommonProcess.setBorder(view: scrollView)
        
        // Header 3
//        setHeader(header: lblHeader3, offset: scrollView.contentSize.height - GlobalConst.LABEL_HEIGHT - GlobalConst.MARGIN_CELL_Y, text: DomainConst.CONTENT00225,
//                  bkgColor: ColorFromRGB().getColorFromRGB(0xFAB102))
        
        if BaseModel.shared.currentUpholdDetail.uphold_type == DomainConst.UPHOLD_TYPE_TROUBLE {
            lblHeader0.text         = DomainConst.CONTENT00041.uppercased()
            lblCreateDate.text      = DomainConst.CONTENT00096
            lblContact.text         = BaseModel.shared.currentUpholdDetail.contact_person +
                                        DomainConst.CONTACT_SPLITER +
                                        BaseModel.shared.currentUpholdDetail.contact_tel
        } else {
            lblHeader0.text             = DomainConst.CONTENT00040.uppercased()
            lblCreateDate.text          = DomainConst.CONTENT00160
            lblContact.text             = BaseModel.shared.currentUpholdDetail.schedule_month
        }
        lblCreateDate.text     = BaseModel.shared.currentUpholdDetail.created_date
        lblCustomerName.text   = BaseModel.shared.currentUpholdDetail.customer_name
        lblAddress.text        = BaseModel.shared.currentUpholdDetail.customer_address.normalizateString()
        lblIssue.text          = BaseModel.shared.currentUpholdDetail.type_uphold
        lblContent.text        = BaseModel.shared.currentUpholdDetail.content
        lblEmployee.text       = BaseModel.shared.currentUpholdDetail.employee_name
        //lblEmployeePhone.text  = BaseModel.shared.currentUpholdDetail.employee_phone
        //lblEmployeePhone.setTitle(BaseModel.shared.currentUpholdDetail.employee_phone, for: UIControlState())
        
        let attributedString = NSMutableAttributedString(string:"")
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        attrs.updateValue(paragraph, forKey: NSParagraphStyleAttributeName)
        let buttonTitleStr = NSMutableAttributedString(string: BaseModel.shared.currentUpholdDetail.employee_phone,
                                                       attributes:attrs)
        
        attributedString.append(buttonTitleStr)
        self.lblEmployeePhone.setAttributedTitle(attributedString, for: .normal)
        
        if BaseModel.shared.currentUpholdDetail.reply_item.count > 0 {
            lblHandlingTime.text   = BaseModel.shared.currentUpholdDetail.reply_item[0].date_time_handle
        }
        lblStatus.text         = BaseModel.shared.currentUpholdDetail.status
        lblReport.text         = BaseModel.shared.currentUpholdDetail.last_reply_message
        lblReportWrong.text         = BaseModel.shared.currentUpholdDetail.report_wrong
        self.updateNotificationStatus()
        
        //++ BUG0127-SPJ (NguyenPT 20170724) Uphold rating: merge to 1 step
        // Show rating view
        if BaseModel.shared.currentUpholdDetail.status_number == DomainConst.UPHOLD_STATUS_COMPLETE && BaseModel.shared.currentUpholdDetail.rating_status.isEmpty {
            // Create rating view
            rating = RatingView(frame: CGRect(x: 0, y: getTopHeight(),
                                                  width: GlobalConst.SCREEN_WIDTH,
                                                  height: GlobalConst.SCREEN_HEIGHT * 2))
            if BaseModel.shared.currentUpholdDetail.reply_item.count > 0 {
                // Set value
                rating?.setLabels(time: BaseModel.shared.currentUpholdDetail.reply_item[0].date_time_handle,
                                 first: DomainConst.CONTENT00147,
                                 firstValue: BaseModel.shared.currentUpholdDetail.type_uphold,
                                 second: DomainConst.CONTENT00158,
                                 secondValue: BaseModel.shared.currentUpholdDetail.status)
                rating?.setHotline(hotline: BaseModel.shared.currentUpholdDetail.employee_phone)
                rating?.delegate = self
            }
            
            self.view.addSubview(rating!)
        }
        //-- BUG0127-SPJ (NguyenPT 20170724) Uphold rating: merge to 1 step
    }
    
    //++ BUG0127-SPJ (NguyenPT 20170724) Uphold rating: merge to 1 step
    /**
     * Request rating to server
     */
    func requestRating(_ sender: AnyObject) {
        let ratingValue = rating?.getRatingValue()
        var ratingStatusId = DomainConst.BLANK
        if ratingValue! > 3 {
            if BaseModel.shared.listRatingStatus.count != 0 {
                ratingStatusId = BaseModel.shared.listRatingStatus[BaseModel.shared.listRatingStatus.count - 1].id
            }
        } else {
            if BaseModel.shared.listRatingStatus.count != 0 {
            ratingStatusId = BaseModel.shared.listRatingStatus[0].id
            }
        }
        var listRating: [Int] = [Int]()
        for _ in BaseModel.shared.listRatingType {
            listRating.append(ratingValue!)
        }
        RatingUpholdRequest.requestRatingUphold(
            action: #selector(finishRequestRating(_:)),
            id: BaseModel.shared.currentUpholdDetail.id,
            ratingStatusId: ratingStatusId,
            listRating: listRating,
            content: (rating?.getContent())!,
            view: self)
    }
    
    /**
     * Handle when finish request rating
     */
    internal func finishRequestRating(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            self.clearData()
            showAlert(message: model.message, okHandler: {
                alert in
                self.rating?.isHidden = true
            })
        } else {
            showAlert(message: model.message)
        }
    }
    //-- BUG0127-SPJ (NguyenPT 20170724) Uphold rating: merge to 1 step
    
    func phonetap() {
        self.makeACall(phone: BaseModel.shared.currentUpholdDetail.employee_phone)
//        if let url = NSURL(string: "tel://\(BaseModel.shared.currentUpholdDetail.employee_phone)"), UIApplication.shared.canOpenURL(url as URL) {
//            UIApplication.shared.openURL(url as URL)
//        }
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
    func setHeader(header: UILabel, offset: CGFloat, text: String = DomainConst.CONTENT00041, bkgColor: UIColor = GlobalConst.BUTTON_COLOR_RED) {
        header.translatesAutoresizingMaskIntoConstraints = true
        header.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                              y: offset,
                              width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2 + GlobalConst.MARGIN_CELL_X * 4),
                              height: GlobalConst.LABEL_HEIGHT)
        header.layer.masksToBounds = true
        //header.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        //header.backgroundColor = bkgColor
        header.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        header.text = text.uppercased()
        header.textColor = UIColor.black
        header.textAlignment = .left
        scrollView.addSubview(header)
    }
    
    //++ BUG0068-SPJ (NguyenPT 20170429) Add rating button
    /**
     * Handle tap on rating button
     */
    internal func btnRatingTapped(_ sender: AnyObject) {
        //++ BUG0127-SPJ (NguyenPT 20170724) Uphold rating: merge to 1 step
//        BaseModel.shared.sharedString = BaseModel.shared.currentUpholdDetail.id
//        self.pushToView(name: G01F03VC.theClassName)
        if rating != nil {
            rating?.isHidden = false
        }
        //-- BUG0127-SPJ (NguyenPT 20170724) Uphold rating: merge to 1 step
    }
    //-- BUG0068-SPJ (NguyenPT 20170429) Add rating button
    
    
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
    
    override func clearData() {
        // Notification
        if BaseModel.shared.checkNotificationExist() {
            BaseModel.shared.clearNotificationData()
        }
    }
}
