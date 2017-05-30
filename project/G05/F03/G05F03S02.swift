//
//  G05F03S02.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F03S02: StepContent, UITextViewDelegate {
    /** List of selector */
    public static var _lstSelector: [OrderVIPSelectorView]  = [OrderVIPSelectorView]()
    /** Note */
    public static var _note:        String                  = DomainConst.BLANK
    /** Label */
    private var _lblTitle:          UILabel                 = UILabel()
    /** Title view */
    private var _viewTitle:         UIView                  = UIView()
    /** Label */
    private var _lblType:           UILabel                 = UILabel()
    /** Label */
    private var _lblQuantity:       UILabel                 = UILabel()
    /** Note textfield */
    private var _tbxNote:           UITextView              = UITextView()
    /** Width of quantity colum */
    private let qtyColWidth:        CGFloat                 = GlobalConst.SCREEN_WIDTH / 7
                                                            + GlobalConst.STEPPER_LAYOUT_WIDTH
                                                            + GlobalConst.MARGIN
    /** Flag check keyboard is show or hide */
    private var _isKeyboardShow:    Bool                    = false

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = 0
        let contentView     = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        // --- Create content view ---
        G05F03S02._lstSelector.removeAll()
        let orderInfo = (DomainConst.NUMBER_ZERO_VALUE, DomainConst.NUMBER_ZERO_VALUE,
                         DomainConst.NUMBER_ZERO_VALUE, DomainConst.NUMBER_ZERO_VALUE,
                         DomainConst.BLANK, DomainConst.BLANK)//BaseModel.shared.getOrderVipDescription()
        let width = GlobalConst.SCREEN_WIDTH
        // Title view
        _viewTitle.frame = CGRect(x: 0, y: offset,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.BUTTON_H)
        _viewTitle.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        contentView.addSubview(_viewTitle)
        
        // Type label
        _lblType.frame = CGRect(x: GlobalConst.MARGIN,
                                y: offset,
                                width: width / 2,
                                height: GlobalConst.BUTTON_H)
        _lblType.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _lblType.textColor = UIColor.black
        _lblType.textAlignment = .center
        _lblType.text = DomainConst.CONTENT00254
        _lblType.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        contentView.addSubview(_lblType)
        
        // Quantity label
        _lblQuantity.frame = CGRect(x: width - qtyColWidth,
                                    y: offset,
                                    width: qtyColWidth,
                                    height: GlobalConst.BUTTON_H)
        _lblQuantity.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _lblQuantity.textColor = UIColor.black
        _lblQuantity.textAlignment = .center
        _lblQuantity.text = DomainConst.CONTENT00255
        _lblQuantity.backgroundColor = GlobalConst.BUTTON_COLOR_GRAY
        contentView.addSubview(_lblQuantity)
        offset = offset + _lblType.frame.height + GlobalConst.MARGIN_CELL_X
        
        // Selector list
        let selector = OrderVIPSelectorView()
        selector.setup(frame: CGRect(x: 0, y: offset,
                                     width: width,
                                     height: GlobalConst.BUTTON_H),
                       checkboxLabel: DomainConst.CONTENT00379,
                       config: ConfigBean(id: DomainConst.KEY_B50, name: orderInfo.0))
        G05F03S02._lstSelector.append(selector)
        contentView.addSubview(selector)
        offset = offset + selector.frame.height + GlobalConst.MARGIN_CELL_X
        
        let selector45 = OrderVIPSelectorView()
        selector45.setup(frame: CGRect(x: 0, y: offset,
                                       width: width,
                                       height: GlobalConst.BUTTON_H),
                         checkboxLabel: DomainConst.CONTENT00380,
                         config: ConfigBean(id: DomainConst.KEY_B45, name: orderInfo.1))
        G05F03S02._lstSelector.append(selector45)
        contentView.addSubview(selector45)
        offset = offset + selector45.frame.height + GlobalConst.MARGIN_CELL_X
        
        let selector12 = OrderVIPSelectorView()
        selector12.setup(frame: CGRect(x: 0, y: offset,
                                       width: width,
                                       height: GlobalConst.BUTTON_H),
                         checkboxLabel: DomainConst.CONTENT00381,
                         config: ConfigBean(id: DomainConst.KEY_B12, name: orderInfo.2))
        G05F03S02._lstSelector.append(selector12)
        contentView.addSubview(selector12)
        offset = offset + selector12.frame.height + GlobalConst.MARGIN_CELL_X
        
        let selector6 = OrderVIPSelectorView()
        selector6.setup(frame: CGRect(x: 0, y: offset,
                                      width: width,
                                      height: GlobalConst.BUTTON_H),
                        checkboxLabel: DomainConst.CONTENT00382,
                        config: ConfigBean(id: DomainConst.KEY_B6, name: orderInfo.3))
        G05F03S02._lstSelector.append(selector6)
        contentView.addSubview(selector6)
        offset = offset + selector6.frame.height + GlobalConst.MARGIN_CELL_X
        
        // Note textfield
        _tbxNote.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.EDITTEXT_W) / 2,
                                y: offset,
                                width: GlobalConst.EDITTEXT_W,
                                height: GlobalConst.EDITTEXT_H * 5)
        _tbxNote.font               = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        _tbxNote.backgroundColor    = UIColor.white
        _tbxNote.autocorrectionType = .no
        _tbxNote.translatesAutoresizingMaskIntoConstraints = true
        _tbxNote.returnKeyType      = .default
        _tbxNote.tag                = 0
        _tbxNote.text = orderInfo.5
        CommonProcess.setBorder(view: _tbxNote, radius: GlobalConst.BUTTON_CORNER_RADIUS)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        contentView.addGestureRecognizer(gesture)
        _tbxNote.delegate = self
        contentView.addSubview(_tbxNote)
        offset = offset + _tbxNote.frame.height + GlobalConst.MARGIN_CELL_X
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00367,
                   contentHeight: offset,
                   width: w, height: h)
    }
    
    // MARK: UITableViewDelegate
    /**
     * Add a done button when keyboard show
     */
    func addDoneButtonOnKeyboard() {
        // Create toolbar
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(hideKeyboard(_:)))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        // Add toolbar to keyboard
        self._tbxNote.inputAccessoryView = doneToolbar
        self.getParentView().keyboardTopY -= doneToolbar.frame.height
    }
    
    /**
     * Tells the delegate that editing of the specified text view has begun.
     */
    func textViewDidBeginEditing(_ textView: UITextView) {
        let delta = self._tbxNote.frame.maxY + self.frame.minY + self.getParentView().getTopHeight() - self.getParentView().keyboardTopY
        if delta > 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.getParentView().view.frame = CGRect(
                    x: self.getParentView().view.frame.origin.x,
                    y: self.getParentView().view.frame.origin.y - delta,
                    width: self.getParentView().view.frame.size.width,
                    height: self.getParentView().view.frame.size.height)
            })
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        G05F03S02._note = textView.text
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        // Hide keyboard
        self.getParentView().view.endEditing(true)
        // Move back view to previous location
        UIView.animate(withDuration: 0.3, animations: {
            self.getParentView().view.frame = CGRect(
                x: self.getParentView().view.frame.origin.x,
                y: 0,
                width: self.getParentView().view.frame.size.width,
                height: self.getParentView().view.frame.size.height)
        })
        // Turn off flag
        _isKeyboardShow = false
    }
    
    /**
     * Handle when focus edittext
     * - parameter textField: Textfield will be focusing
     */
    internal func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        _isKeyboardShow = true
        // Making A toolbar
        if textView == self._tbxNote {
            addDoneButtonOnKeyboard()
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    /**
     * Hide keyboard
     * - parameter sender: Gesture
     */
    func hideKeyboard(_ sender:UITapGestureRecognizer){
        hideKeyboard()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        return true
    }
}
