//
//  RatingView.swift
//  project
//
//  Created by SPJ on 7/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class RatingView: UIView, RatingBarDelegate, UITextViewDelegate {
    /** Top view */
    @IBOutlet weak var topView: UIView!
    /** Close button */
    @IBOutlet weak var btnClose: UIButton!
    /** Status image */
    @IBOutlet weak var imgStatus: UIImageView!
    /** Hotline button */
    @IBOutlet weak var btnHotline: UIButton!
    /** Time label */
    @IBOutlet weak var lblTime: UILabel!
    /** First attribute label */
    @IBOutlet weak var lblFirst: UILabel!
    /** First attribute value label */
    @IBOutlet weak var lblFirstValue: UILabel!
    /** Second attribute label */
    @IBOutlet weak var lblSecond: UILabel!
    /** Second attribute value label */
    @IBOutlet weak var lblSecondValue: UILabel!
    /** Rating view */
    @IBOutlet weak var viewRating: UIView!
    /** Reply label */
    @IBOutlet weak var lblReply: UILabel!
    /** Avatar image */
    @IBOutlet weak var imgAvatar: UIImageView!
    /** Rating bar */
    private var ratingBar: RatingBar = RatingBar()
    /** Failed view */
    @IBOutlet weak var viewFailed: UIView!
    /** Success view */
    @IBOutlet weak var viewSuccess: UIView!
    /** Send button */
    @IBOutlet weak var btnSend: UIButton!
    /** Top slide gesture */
    var _swipeGestTop:    UISwipeGestureRecognizer!
    /** Bottom slide gesture */
    var _swipeGestBottom:    UISwipeGestureRecognizer!
    /** Failed label */
    @IBOutlet weak var lblFailed: UILabel!
    /** Success label */
    @IBOutlet weak var lblSuccess: UILabel!
    /** Note textfield */
    @IBOutlet weak var txtNote: UITextView!
    /** Moving distance */
    private var MOVING_DISTANCE: CGFloat = 0
    /** Navigator height */
    private var NAVIGATOR_HEIGHT: CGFloat = 0
    /** Height of keyboard */
    private var keyboardTopY : CGFloat = 0.0
    /** Delegate */
    public var delegate: RatingViewDelegate? = nil
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        makeComponentsColor()
        // Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
    }
    
    // MARK: - Private Helper Methods
    
    /**
     * Get height of keyboard
     */
    open func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardTopY = GlobalConst.SCREEN_HEIGHT - keyboardSize.height
        }
    }
    
    // Performs the initial setup.
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        // Show the view.
        addSubview(view)
        var offset: CGFloat = 0.0
        let topHeight = GlobalConst.ICON_SIZE * 2
        // Top view
        topView.frame = CGRect(x: 0, y: 0,
                               width: GlobalConst.SCREEN_WIDTH,
                               height: topHeight)
        
        // Close button
        let close = ImageManager.getImage(named: DomainConst.ORDER_STATUS_CANCEL_ICON_IMG_NAME)
        let tintedBack = close?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        btnClose.setImage(tintedBack, for: UIControlState())
        btnClose.tintColor = GlobalConst.BUTTON_COLOR_RED
        btnClose.frame = CGRect(x: GlobalConst.MARGIN,
                                y: (topHeight - GlobalConst.MENU_BUTTON_W) / 2,
                                width: GlobalConst.MENU_BUTTON_W,
                                height: GlobalConst.MENU_BUTTON_W)
        btnClose.setTitle(DomainConst.BLANK, for: UIControlState())
        
        // Status image
        imgStatus.frame = CGRect(x: GlobalConst.SCREEN_WIDTH / 2 - GlobalConst.ICON_SIZE,
                                 y: 0,
                                 width: GlobalConst.ICON_SIZE * 2,
                                 height: GlobalConst.ICON_SIZE * 2)
        imgStatus.image = ImageManager.getImage(named: DomainConst.FINISH_STATUS_IMG_NAME)
        
        // Hotline button
        let hotline = ImageManager.getImage(named: DomainConst.CONTACT_ICON_IMG_NAME)
        let tintedHotline = hotline?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        btnHotline.setImage(tintedHotline, for: UIControlState())
        btnHotline.tintColor = GlobalConst.BUTTON_COLOR_RED
        btnHotline.frame = CGRect(x: GlobalConst.SCREEN_WIDTH - GlobalConst.MENU_BUTTON_W - GlobalConst.MARGIN,
                                  y: (topHeight - GlobalConst.MENU_BUTTON_W) / 2,
                                  width: GlobalConst.MENU_BUTTON_W,
                                  height: GlobalConst.MENU_BUTTON_W)
        btnHotline.setTitle(DomainConst.BLANK, for: UIControlState())
        offset += topHeight + GlobalConst.MARGIN
        // Time label
        lblTime.translatesAutoresizingMaskIntoConstraints = true
        lblTime.frame = CGRect(x: 0, y: offset,
                               width: GlobalConst.SCREEN_WIDTH,
                               height: GlobalConst.LABEL_H)
        lblTime.textColor = GlobalConst.TEXT_COLOR_GRAY
        lblTime.font = UIFont.systemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        lblTime.layer.addBorder(edge: UIRectEdge.bottom, color: GlobalConst.TEXT_COLOR_GRAY, thickness: 1.0)
        offset += GlobalConst.LABEL_H + GlobalConst.MARGIN * 2
        
        // First attribute label
        lblFirst.translatesAutoresizingMaskIntoConstraints = true
        lblFirst.frame = CGRect(x: 0, y: offset,
                               width: GlobalConst.SCREEN_WIDTH,
                               height: GlobalConst.LABEL_H)
        lblFirst.textColor = GlobalConst.TEXT_COLOR_GRAY
        lblFirst.font = UIFont.systemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        offset += GlobalConst.LABEL_H + GlobalConst.MARGIN
        // First attribute value label
        lblFirstValue.translatesAutoresizingMaskIntoConstraints = true
        lblFirstValue.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.LABEL_H)
        lblFirstValue.textColor = GlobalConst.MAIN_COLOR
        lblFirstValue.font = UIFont.boldSystemFont(ofSize: GlobalConst.NOTIFY_FONT_SIZE)
        offset += GlobalConst.LABEL_H + GlobalConst.MARGIN * 2
        
        // Second attribute label
        lblSecond.translatesAutoresizingMaskIntoConstraints = true
        lblSecond.frame = CGRect(x: 0, y: offset,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.LABEL_H)
        lblSecond.textColor = GlobalConst.TEXT_COLOR_GRAY
        lblSecond.font = UIFont.systemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        offset += GlobalConst.LABEL_H + GlobalConst.MARGIN
        // Second attribute value label
        lblSecondValue.translatesAutoresizingMaskIntoConstraints = true
        lblSecondValue.frame = CGRect(x: 0, y: offset,
                                     width: GlobalConst.SCREEN_WIDTH,
                                     height: GlobalConst.LABEL_H)
        lblSecondValue.textColor = GlobalConst.MAIN_COLOR
        lblSecondValue.font = UIFont.boldSystemFont(ofSize: GlobalConst.NOTIFY_FONT_SIZE)
        offset += GlobalConst.LABEL_H + GlobalConst.MARGIN * 2
        
        // Rating view
        let avatarSize = GlobalConst.ACCOUNT_AVATAR_H / 2
        if let parent = BaseViewController.getCurrentViewController() {
            NAVIGATOR_HEIGHT = parent.getTopHeight()
            viewRating.translatesAutoresizingMaskIntoConstraints = true
            let viewHeight = GlobalConst.LABEL_H + avatarSize + GlobalConst.RATING_BAR_HEIGHT + GlobalConst.MARGIN * 5
            MOVING_DISTANCE = GlobalConst.SCREEN_HEIGHT - viewHeight - NAVIGATOR_HEIGHT
            viewRating.frame = CGRect(x: 0,
                                      y: MOVING_DISTANCE,
                                      width: GlobalConst.SCREEN_WIDTH, height: viewHeight)
            MOVING_DISTANCE += GlobalConst.LABEL_H
            self.frame = CGRect(x: 0, y: NAVIGATOR_HEIGHT, width: GlobalConst.SCREEN_WIDTH,
                                height: MOVING_DISTANCE * 2 + viewHeight - GlobalConst.LABEL_H)
        }
        
        // Reply label
        lblReply.translatesAutoresizingMaskIntoConstraints = true
        lblReply.frame = CGRect(x: 0, y: 0,
                                 width: GlobalConst.SCREEN_WIDTH,
                                 height: GlobalConst.LABEL_H)
        lblReply.textColor = GlobalConst.TEXT_COLOR_GRAY
        lblReply.text = DomainConst.CONTENT00448
        lblReply.font = UIFont.systemFont(ofSize: GlobalConst.LARGE_FONT_SIZE)
        offset = GlobalConst.LABEL_H + GlobalConst.MARGIN
        
        // Avatar image
        imgAvatar.translatesAutoresizingMaskIntoConstraints = true
        imgAvatar.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - avatarSize) / 2,
                                 y: offset,
                                 width: avatarSize,
                                 height: avatarSize)
        imgAvatar.image = ImageManager.getImage(named: DomainConst.CONTACT_IMG_NAME)
        offset += GlobalConst.ACCOUNT_AVATAR_H / 2 + GlobalConst.MARGIN
        // Rating bar
        ratingBar.translatesAutoresizingMaskIntoConstraints = true
        let size = GlobalConst.LABEL_HEIGHT * 1.5
        let width = size * (CGFloat)(ratingBar.getStarNumber()) + (ratingBar.getStarSpace() * (CGFloat)(ratingBar.getStarNumber() - 1))
        ratingBar.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - width) / 2,
                                 y: offset,
                                 width: width,
                                 height: size)
        
        //ratingBar.setBackgroundColor(color: GlobalConst.BACKGROUND_COLOR_GRAY)
        ratingBar.delegate = self
        viewRating.addSubview(ratingBar)
        
        // Failed view
        let bottomViewHeight = MOVING_DISTANCE - GlobalConst.BUTTON_H - GlobalConst.MARGIN
                                - GlobalConst.EDITTEXT_H * 3
        viewFailed.frame = CGRect(x: 0,
                                  y: viewRating.frame.maxY,
                                  width: GlobalConst.SCREEN_WIDTH, height: bottomViewHeight)
        viewFailed.isHidden = true
        
        // Failed label
        lblFailed.translatesAutoresizingMaskIntoConstraints = true
        lblFailed.frame = CGRect(x: 0, y: 0,
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.LABEL_H)
        lblFailed.textColor = GlobalConst.TEXT_COLOR_GRAY
        lblFailed.text = DomainConst.CONTENT00449
        lblFailed.font = UIFont.systemFont(ofSize: GlobalConst.BIG_FONT_SIZE)
        offset = GlobalConst.LABEL_H + GlobalConst.MARGIN
        createFailedSelection(offset: offset)
        
        // Success view
        viewSuccess.frame = CGRect(x: 0,
                                  y: viewRating.frame.maxY,
                                  width: GlobalConst.SCREEN_WIDTH, height: bottomViewHeight)
        viewSuccess.isHidden = true
        // Success label
        lblSuccess.translatesAutoresizingMaskIntoConstraints = true
        lblSuccess.frame = CGRect(x: 0, y: 0,
                                 width: GlobalConst.SCREEN_WIDTH,
                                 height: GlobalConst.LABEL_H * 2)
        lblSuccess.textColor = GlobalConst.TEXT_COLOR_GRAY
        lblSuccess.text = DomainConst.CONTENT00450
        lblSuccess.font = UIFont.systemFont(ofSize: GlobalConst.BIG_FONT_SIZE)
        lblSuccess.numberOfLines = 0
        lblSuccess.lineBreakMode = .byWordWrapping
        offset = GlobalConst.LABEL_H * 2 + GlobalConst.MARGIN
        
        // Note textfield
        txtNote.translatesAutoresizingMaskIntoConstraints = true
        txtNote.frame = CGRect(x: GlobalConst.MARGIN,
                               y: viewFailed.frame.maxY,
                               width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN,
                               height: GlobalConst.EDITTEXT_H * 3)
        txtNote.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        txtNote.text = DomainConst.CONTENT00457
        CommonProcess.setBorder(view: txtNote, radius: GlobalConst.BUTTON_CORNER_RADIUS)
        txtNote.delegate = self
        
        // Setup button Send
        btnSend.translatesAutoresizingMaskIntoConstraints = true
        btnSend.frame = CGRect(
            x: (GlobalConst.SCREEN_WIDTH) / 2  - GlobalConst.BUTTON_H,
            y: self.frame.height - GlobalConst.BUTTON_H - GlobalConst.MARGIN / 2,
            width: GlobalConst.BUTTON_H * 2,
            height: GlobalConst.BUTTON_H)
        btnSend.setTitle(DomainConst.CONTENT00180, for: .normal)
        btnSend.backgroundColor    = GlobalConst.BUTTON_COLOR_RED
        btnSend.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnSend.tintColor          = UIColor.white
        btnSend.addTarget(self, action: #selector(btnSendTapped(_:)), for: .touchUpInside)
        
        // Swipe
        _swipeGestTop = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(swipeHandler(_:)))
        _swipeGestTop.direction = .down
        view.addGestureRecognizer(_swipeGestTop)
        _swipeGestBottom = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(swipeHandler(_:)))
        _swipeGestBottom.direction = .up
        view.addGestureRecognizer(_swipeGestBottom)
        view.makeComponentsColor()
    }
    
    /**
     * Loads a XIB file into a view and returns this view.
     * - returns: UIView
     */
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        /* Usage for swift < 3.x
         let bundle = NSBundle(forClass: self.dynamicType)
         let nib = UINib(nibName: String(self.dynamicType), bundle: bundle)
         let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
         */
        
        return view
    }
    
    /**
     * Handle tap on Send button
     */
    internal func btnSendTapped(_ sender: AnyObject) {
        if delegate != nil {
            delegate?.requestRating(sender)
        }
    }
    
    /**
     * Handle tap on Close button
     */
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.isHidden = true
    }
    
    /**
     * Handle tap on Hotline button
     */
    @IBAction func btnHotlineTapped(_ sender: Any) {
        if let parent = BaseViewController.getCurrentViewController() {
            parent.makeACall(phone: self.btnHotline.accessibilityValue!)
        }
    }
    
    /**
     * Handle change rating value
     */
    func rating(_ sender: AnyObject) {
        let value = ratingBar.getRatingValue()
        if self.frame.minX == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.frame = CGRect(x: 0, y: self.NAVIGATOR_HEIGHT - self.MOVING_DISTANCE,
                                    width: self.frame.width,
                                    height: self.frame.height)
            }, completion: { finished in
                if value <= 3 {
                    self.viewFailed.isHidden = false;
                    self.viewSuccess.isHidden = true;
                    self.txtNote.frame = CGRect(x: self.txtNote.frame.minX,
                                                y: self.viewFailed.frame.maxY,
                                                width: self.txtNote.frame.width,
                                                height: self.txtNote.frame.height)
                } else {
                    self.viewFailed.isHidden = true;
                    self.viewSuccess.isHidden = false;
                }
            })
        }
    }
    
    /**
     * Handle swipe gesture
     */
    func swipeHandler(_ sender: UIGestureRecognizer) {
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.down:
                UIView.animate(withDuration: 0.3, animations: {
                    self.frame = CGRect(x: 0, y: self.NAVIGATOR_HEIGHT,
                                        width: self.frame.width,
                                        height: self.frame.height)
                })
            case UISwipeGestureRecognizerDirection.up:
                UIView.animate(withDuration: 0.3, animations: {
                    self.frame = CGRect(x: 0, y: self.NAVIGATOR_HEIGHT - self.MOVING_DISTANCE,
                                        width: self.frame.width,
                                        height: self.frame.height)
                })
            default:
                break
            }
        }
    }
    
    /**
     * Set data for labels
     * - parameter time:        Time value
     * - parameter first:       First label value
     * - parameter firstValue:  First value
     * - parameter second:      Second label value
     * - parameter secondValue: Second value
     */
    public func setLabels(time: String, first: String, firstValue: String,
                           second: String, secondValue: String) {
        self.lblTime.text = time
        lblFirst.text = first
        lblFirstValue.text = firstValue
        lblSecond.text = second
       lblSecondValue.text = secondValue
    }
    
    /**
     * Create failed selection view
     * - parameter offset: Y offset
     */
    private func createFailedSelection(offset: CGFloat) {
        var curOffset = offset
        let bottomViewHeight = MOVING_DISTANCE - GlobalConst.BUTTON_H - GlobalConst.MARGIN * 2 - GlobalConst.LABEL_H - GlobalConst.EDITTEXT_H * 3
        // Attemp list config
        var listConfig = [ConfigBean]()
        listConfig.append(ConfigBean(id: DomainConst.MENU_ITEM_PROFILE_IMG_NAME, name: DomainConst.CONTENT00451))
        listConfig.append(ConfigBean(id: DomainConst.CONFIG_MENU_IMG_NAME, name: DomainConst.CONTENT00452))
        listConfig.append(ConfigBean(id: DomainConst.MENU_ITEM_REPORT_IMG_NAME, name: DomainConst.CONTENT00453))
        listConfig.append(ConfigBean(id: DomainConst.TICKET_ICON_IMG_NAME, name: DomainConst.CONTENT00454))
        listConfig.append(ConfigBean(id: DomainConst.MENU_ITEM_SUPPORT_IMG_NAME, name: DomainConst.CONTENT00455))
        listConfig.append(ConfigBean(id: DomainConst.REPORT_SUM_ICON_IMG_NAME, name: DomainConst.CONTENT00456))
        // Attemp list image
        var listImg = [(String, String)]()
        listImg.append((DomainConst.MENU_ITEM_PROFILE_IMG_NAME, DomainConst.MENU_ITEM_PROFILE_IMG_NAME))
        listImg.append((DomainConst.CONFIG_MENU_IMG_NAME,       DomainConst.CONFIG_MENU_IMG_NAME))
        listImg.append((DomainConst.MENU_ITEM_REPORT_IMG_NAME,  DomainConst.MENU_ITEM_REPORT_IMG_NAME))
        listImg.append((DomainConst.TICKET_ICON_IMG_NAME, DomainConst.TICKET_ICON_IMG_NAME))
        listImg.append((DomainConst.MENU_ITEM_SUPPORT_IMG_NAME, DomainConst.MENU_ITEM_SUPPORT_IMG_NAME))
        listImg.append((DomainConst.REPORT_SUM_ICON_IMG_NAME, DomainConst.REPORT_SUM_ICON_IMG_NAME))
        
        // Calculate size
        let count       = listConfig.count
        let btnHeight   = bottomViewHeight / 2
        let btnWidth    = GlobalConst.SCREEN_WIDTH / CGFloat(count / 2)
        // Loop through all item
        for i in 0..<(count / 2) {
            // Calculate frame of button
            let frame = CGRect(x: CGFloat(i) * btnWidth,
                               y: curOffset,
                               width: btnWidth,
                               height: btnHeight)
            let btn = CategoryButton(frame: frame, icon: listImg[i].0,
                                     iconActive: listImg[i].1,
                                     title: listConfig[i].name.uppercased(),
                                     id: listConfig[i].id,
                                     font: UIFont.systemFontSize)
            
            btn.addTarget(self, action: #selector(failedSelectHandler), for: .touchUpInside)
            self.viewFailed.addSubview(btn)
        }
        curOffset += btnHeight
        // Loop through all item
        for i in (count / 2)..<count {
            // Calculate frame of button
            let frame = CGRect(x: CGFloat(i - count / 2) * btnWidth,
                               y: curOffset,
                               width: btnWidth,
                               height: btnHeight)
            let btn = CategoryButton(frame: frame, icon: listImg[i].0,
                                     iconActive: listImg[i].1,
                                     title: listConfig[i].name.uppercased(),
                                     id: listConfig[i].id,
                                     font: UIFont.systemFontSize)
            
            btn.addTarget(self, action: #selector(failedSelectHandler), for: .touchUpInside)
            self.viewFailed.addSubview(btn)
        }
    }
    
    /**
     * Failed select handler
     */
    internal func failedSelectHandler(_ sender: AnyObject) {
        (sender as! CategoryButton).isSelected = !(sender as! CategoryButton).isSelected
    }
    
    /**
     * Asks the delegate if editing should begin in the specified text view.
     */
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == DomainConst.CONTENT00457 {
            textView.text = DomainConst.BLANK
        }
        return true
    }
    
    /**
     * Asks the delegate if editing should stop in the specified text view.
     */
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text == DomainConst.BLANK {
            textView.text = DomainConst.CONTENT00457
        }
        return true
    }
    
    /**
     * Handle start editing
     * - parameter textField: Current focus textfield
     */
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if let parent = BaseViewController.getCurrentViewController() {
            self.keyboardTopY = parent.keyboardTopY
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: self.frame.minY - (GlobalConst.SCREEN_HEIGHT - self.keyboardTopY),
                                width: self.frame.width,
                                height: self.frame.height)
        })
    }
    
    /**
     * Tells the delegate that editing stopped for the specified text field.
     */
    public func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: self.NAVIGATOR_HEIGHT - self.MOVING_DISTANCE,
                                width: self.frame.width,
                                height: self.frame.height)
        })
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.endEditing(true)
    }
    
    /**
     * Tells the responder when one or more fingers touch down in a view or window.
     */
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.txtNote.isFirstResponder {
            hideKeyboard()
        }
    }
    
    /**
     * Set hotline number
     * - parameter hotline: Hotline string
     */
    public func setHotline(hotline: String) {
        self.btnHotline.accessibilityValue = hotline
    }
    
    /**
     * Get content
     * - returns: Content string
     */
    public func getContent() -> String {
        if txtNote.text == DomainConst.CONTENT00457 {
            return DomainConst.BLANK
        }
        return txtNote.text
    }
    
    /**
     * Get rating value
     * - returns: Rating value
     */
    public func getRatingValue() -> Int {
        return self.ratingBar.getRatingValue()
    }
}
