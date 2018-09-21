//
//  G00F01S03.swift
//  project
//
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00F01S03: StepContent {
    /** Full address */
    public static var _address:         String = DomainConst.BLANK
    private var contentView     = UIView()
    private var fullAddress:            FullAddressPicker = FullAddressPicker()

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
        var offset: CGFloat = GlobalConst.MARGIN
        contentView.translatesAutoresizingMaskIntoConstraints = true
        fullAddress.setup()
        offset += fullAddress.frame.height
        contentView.addSubview(fullAddress)
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00301,
                   contentHeight: offset,
                   width: w, height: h)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        G00F01S03._address = fullAddress.getData().getFullAddress()
        return true
    }
    
    /**
     * Hide keyboard
     */
    func hideKeyboard() {
        self.endEditing(true)
        self.contentView.endEditing(true)
    }
    
    /**
     * Tells the responder when one or more fingers touch down in a view or window.
     */
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    /**
     * Set address
     * - parameter address: Address to set
     */
    public func setAddress(address: FullAddressBean) {
        self.fullAddress.setData(bean: address)
    }
}
