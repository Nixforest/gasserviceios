//
//  CommonProcess.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonProcess {
    /**
     * Request login.
     * - parameter username: Username
     * - parameter password: Password
     * - parameter view: View controller
     */
    static func requestLogin(username: String, password: String, view: CommonViewController) {
        //let start = DispatchTime.now()
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = LoginRequest(url: DomainConst.PATH_SITE_LOGIN,
                                   reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(username: username, password: password)
        request.execute()
        //let end = DispatchTime.now()
        //let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds;
        //let timeInterval = nanoTime / 1000000
        //print("Start request -> Start excute: \(timeInterval) miliseconds")
    }
    
    /**
     * Request logout
     * - parameter view: View controller
     */
    static func requestLogout(view: CommonViewController) {
        LoadingView.shared.showOverlay(view: view.view)
        let logoutReq = LogoutRequest(url: DomainConst.PATH_SITE_LOGOUT,
                                      reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        logoutReq.setData()
        logoutReq.execute()
    }
    
    /**
     * Request logout
     * - parameter view: UIView
     */
    static func requestLogout(view: UIView) {
        LoadingView.shared.showOverlay(view: view)
        let logoutReq = LogoutRequest(url: DomainConst.PATH_SITE_LOGOUT,
                                      reqMethod: GlobalConst.HTTP_POST_REQUEST)
        logoutReq.setData()
        logoutReq.execute()
    }
    
    /**
     * Request user information
     * - parameter view: View controller
     */
    static func requestUserProfile(view: CommonViewController) {
        LoadingView.shared.showOverlay(view: view.view)
        let userProfileReq = UserProfileRequest(url: DomainConst.PATH_USER_PROFILE,
                                                reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        userProfileReq.setData(token: Singleton.shared.getUserToken())
        userProfileReq.execute()
    }
    
    /**
     * Request change password.
     * - parameter oldPass: Old password
     * - parameter newPass: New password
     * - parameter view:    View controller
     */
    static func requestChangePassword(oldPass: String, newPass: String, view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = ChangePassRequest(url: DomainConst.PATH_USER_CHANGE_PASS,
                                   reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(oldPass: oldPass, newPass: newPass)
        request.execute()
    }
    
    /**
     * Request uphold list
     * - parameter page:        Page index
     * - parameter type:        Type uphold (Problem/Periodically)
     * - parameter customerId:  Id of customer
     * - parameter status:      Status of item
     * - parameter view:        View controller
     */
    static func requestUpholdList(page: Int, type: Int, customerId: String, status: String, view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = UpholdListRequest(url: DomainConst.PATH_SITE_UPHOLD_LIST, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        
        request.setData(page: page, type: type, customerId: customerId, status: status)
        request.execute()
    }
    
    /**
     * Request search customer
     * - parameter keyword: Keyword
     * - parameter view:    View controller
     */
    static func requestSearchCustomer(keyword: String, view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = SearchCustomerRequest(url: DomainConst.PATH_SITE_AUTOCOMPLETE_USER, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        
        request.setData(keyword: keyword)
        request.execute()
    }
    
    /**
     * Request uphold detail data
     * - parameter upholdId:    Id of uphold
     * - parameter replyId:     Id of reply
     * - parameter view:        View controller
     */
    static func requestUpholdDetail(upholdId: String, replyId: String,
                                    view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = UpholdDetailRequest(url: DomainConst.PATH_SITE_UPHOLD_VIEW, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(upholdId: upholdId, replyId: replyId)
        request.execute()
    }
    
    /**
     * Request create uphold reply
     * - parameter upholdId:            Id of uphold item
     * - parameter status:              Status of uphold
     * - parameter hoursHandle:         Hours handle
     * - parameter note:                Name of reviewer
     * - parameter contact_phone:       Phone of reviewer
     * - parameter reportWrong:         Report wrong
     * - parameter listPostReplyImage:  List images
     * - parameter customerId:          Id of customer
     * - parameter noteInternal:        Note internal
     * - parameter view:                View controller
     */
    static func requestCreateUpholdReply(upholdId: String,
                                         status: String, statusText: String,
                                         hoursHandle: String,
                                         note: String, contact_phone: String,
                                         reportWrong: String,
                                         listPostReplyImage: [UIImage],
                                         customerId: String,
                                         noteInternal: String,
                                         view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = CreateUpholdReplyRequest(url: DomainConst.PATH_SITE_UPHOLD_REPLY, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(upholdId: upholdId,
                        status: status, statusText: statusText, hoursHandle: hoursHandle,
                        note: note, contact_phone: contact_phone,
                        reportWrong: reportWrong,
                        listPostReplyImage: listPostReplyImage,
                        customerId: customerId,
                        noteInternal: noteInternal)
        //request.execute()
        request.executeUploadFile(listImages: listPostReplyImage)
    }
    
    /**
     * Request uphold configuration
     * - parameter view: View controller
     */
    static func requestUpdateConfiguration(view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = UpdateConfigurationRequest(url: DomainConst.PATH_SITE_UPDATE_CONFIG, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData()
        request.execute()
    }
    
    /**
     * Request count of notification
     * - parameter view: View controller
     */
    static func requestNotificationCount(view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = NotificationCountRequest(url: DomainConst.PATH_SITE_NOTIFY_COUNT, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData()
        request.execute()
    }
    
    /**
     * Request create uphold reply
     * - parameter upholdId:            Id of uphold item
     * - parameter status:              Status of uphold
     * - parameter hoursHandle:         Hours handle
     * - parameter note:                Name of reviewer
     * - parameter contact_phone:       Phone of reviewer
     * - parameter reportWrong:         Report wrong
     * - parameter listPostReplyImage:  List images
     * - parameter customerId:          Id of customer
     * - parameter noteInternal:        Note internal
     * - parameter view:                View controller
     */
    static func requestCreateUphold(customerId: String, employeeId: String,
                                    typeUphold: String, content: String, contactPerson: String,
                                    contactTel: String, requestBy: String,
                                         view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = CreateUpholdRequest(url: DomainConst.PATH_SITE_UPHOLD_CREATE, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(customerId: customerId, employeeId: employeeId,
                        typeUphold: typeUphold, content: content, contactPerson: contactPerson,
                        contactTel: contactTel, requestBy: requestBy)
        request.execute()
    }
    
    /**
     * Request create uphold reply
     * - parameter id:              Id of uphold item
     * - parameter ratingStatusId:  Id of rating status
     * - parameter listRating:      List rating type
     * - parameter content:         Content
     * - parameter view:            View controller
     */
    static func requestRatingUphold(id: String, ratingStatusId: String,
                                    listRating: [Int], content: String,
                                    view: CommonViewController) {
        // Show overlay
        LoadingView.shared.showOverlay(view: view.view)
        let request = RatingUpholdRequest(url: DomainConst.PATH_SITE_UPHOLD_CUSTOMER_RATING, reqMethod: GlobalConst.HTTP_POST_REQUEST, view: view)
        request.setData(id: id, ratingStatusId: ratingStatusId, listRating: listRating, content: content)
        request.execute()
        
    }
    
    /**
     * Request confirm notify.
     * - parameter notifyId : Id of notify
     * - parameter type     : Type of notify
     * - parameter objId    : Id of object
     */
    static func requestConfirmNotify(notifyId: String, type: String, objId: String) {
        let request = ConfirmNotifyRequest(url: DomainConst.PATH_SITE_CONFIRM_NOTIFY,
                                   reqMethod: GlobalConst.HTTP_POST_REQUEST)
        request.setData(notifyId: notifyId, type: type, objId: objId)
        request.execute()
    }
    
    /**
     * Set border for control.
     * - parameter view: Control to set border
     */
    static func setBorder(view: UIView) {
        view.layer.borderWidth  = GlobalConst.BUTTON_BORDER_WIDTH
        view.layer.borderColor  = GlobalConst.BUTTON_COLOR_RED.cgColor
        view.clipsToBounds      = true
        view.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
    }
    
    /**
     * Alignment text vertical center on TextView.
     * - parameter textView: TextView to set
     */
    static func alignTextVerticalInTextView(textView :UITextView) -> CGFloat {
        //let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat(MAXFLOAT)))
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: textView.bounds.height))
        var topoffset = (textView.bounds.size.height - size.height * textView.zoomScale) / 2.0
        topoffset = topoffset < 0.0 ? 0.0 : topoffset
        textView.contentOffset = CGPoint(x: 0, y: -topoffset)
        return topoffset
    }
    
    /**
     * Set layout for left controls
     * - parameter lbl:     Label control
     * - parameter offset:  Y offset
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    static func setLayoutLeft(lbl: UILabel, offset: CGFloat, height: CGFloat, text: String, isDrawTopBorder: Bool = true) {
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.frame = CGRect(x: GlobalConst.MARGIN_CELL_X, y: offset,
                           width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) / 3,
                           height: height)
        lbl.text = text
        if isDrawTopBorder {
            lbl.layer.addBorder(edge: UIRectEdge.top)
        }
        lbl.layer.addBorder(edge: UIRectEdge.right)
    }
    
    /**
     * Set layout for left controls
     * - parameter lbl:     Label control
     * - parameter offset:  Y offset
     * - parameter width:   Width of layout
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    static func setLayoutLeft(lbl: UILabel, offset: CGFloat, width: CGFloat, height: CGFloat, text: String, isDrawTopBorder: Bool = true) {
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.frame = CGRect(x: GlobalConst.MARGIN_CELL_X, y: offset,
                           width: width,
                           height: height)
        lbl.text            = text
        lbl.lineBreakMode   = .byWordWrapping
        lbl.numberOfLines   = 0
        if isDrawTopBorder {
            lbl.layer.addBorder(edge: UIRectEdge.top)
        }
        lbl.layer.addBorder(edge: UIRectEdge.right)
    }
    
    /**
     * Set layout for right controls
     * - parameter lbl:     TextView control
     * - parameter offset:  Y offset
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    static func setLayoutRight(lbl: UITextView, offset: CGFloat, height: CGFloat, text: String, isDrawTopBorder: Bool = true) {
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.text = text
        let topOffset =
            CommonProcess.alignTextVerticalInTextView(textView: lbl)
        lbl.frame = CGRect(x: GlobalConst.MARGIN_CELL_X + (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) / 3,
                           y: offset,
                           width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) * 2 / 3,
                           height: height)
        lbl.contentOffset = CGPoint(x: 0, y: -topOffset)
        lbl.frame = CGRect(x: GlobalConst.MARGIN_CELL_X + (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) / 3,
                           y: offset,
                           width: (GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X * 2) * 2) * 2 / 3,
                           height: height)
        if isDrawTopBorder {
            lbl.layer.addBorder(edge: UIRectEdge.top)
        }
        lbl.isEditable = false
    }
    
    /**
     * Set layout for right controls
     * - parameter lbl:     TextView control
     * - parameter x:       X offset
     * - parameter y:       Y offset
     * - parameter width:   Width of layout
     * - parameter height:  Height of layout
     * - parameter text:    Control's text
     */
    static func setLayoutRight(lbl: UITextView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, isDrawTopBorder: Bool = true) {
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.text = text
        let topOffset =
            CommonProcess.alignTextVerticalInTextView(textView: lbl)
        lbl.frame = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
        lbl.contentOffset = CGPoint(x: 0, y: -topOffset)
        lbl.frame = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
        if isDrawTopBorder {
            lbl.layer.addBorder(edge: UIRectEdge.top)
        }
        lbl.isEditable = false
    }
    
    /**
     * Mark button is selected
     * - parameter button: Buton to mark
     */
    static func markButton(button: UIButton) {
        button.backgroundColor = GlobalConst.COLOR_SELECTING_GREEN
    }
    
    /**
     * Mark button is deselected
     * - parameter button: Buton to mark
     */
    static func unMarkButton(button: UIButton) {
        button.backgroundColor = GlobalConst.BUTTON_COLOR_RED
    }
    
    /**
     * Create layout for normal button
     * - parameter btn:     Button to create layout
     * - parameter x:       X position
     * - parameter y:       Y position
     * - parameter text:    Button's title
     */
    static func createButtonLayout(btn: UIButton, x: CGFloat, y: CGFloat,
                             text: String) {
        
        btn.translatesAutoresizingMaskIntoConstraints = true
        btn.frame = CGRect(x: x, y: y,
                           width: GlobalConst.BUTTON_W,
                           height: GlobalConst.BUTTON_H)
        btn.setTitle(text, for: .normal)
        btn.setTitleColor(UIColor.white , for: .normal)
        btn.titleLabel?.font    = UIFont.systemFont(ofSize: GlobalConst.BUTTON_FONT_SIZE)
        btn.backgroundColor     = GlobalConst.BUTTON_COLOR_RED
        btn.layer.cornerRadius  = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
    }
}
