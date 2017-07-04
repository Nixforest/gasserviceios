//
//  G07F02S02.swift
//  project
//
//  Created by SPJ on 7/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F02S02: StepContent {
    /** Content view */
    private var contentView:        UIView              = UIView()
    /** Address control */
    public static var _fullAddress: FullAddressPicker   = FullAddressPicker()

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
        G07F02S02._fullAddress.setup()
        offset += G07F02S02._fullAddress.frame.height
        contentView.addSubview(G07F02S02._fullAddress)
        
        // Set parent
        self.setParentView(parent: parent)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00301,
                   contentHeight: offset,
                   width: w, height: h)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name:NSNotification.Name(rawValue: G07F02S02.theClassName),
                                               object: nil)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Update data for this view
     */
    internal func updateData(_ notification: Notification) {
    }
    
    /**
     * Get full address
     * - returns: Full address string
     */
    public static func getFullAddress() -> String {
        return G07F02S02._fullAddress.getData().getFullAddress()
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        if G07F02S02._fullAddress.getData().provinceId.isEmpty {
            G07F02S02._fullAddress.getData().provinceId = G07F02VC._data.province_id
            //G07F02S02._fullAddress.setProvinceValue(id: G07F02VC._data.province_id)
        }
        if G07F02S02._fullAddress.getData().districtId.isEmpty {
            G07F02S02._fullAddress.getData().districtId = G07F02VC._data.district_id
            //G07F02S02._fullAddress.setDistrictValue(id: G07F02VC._data.district_id)
        }
        if G07F02S02._fullAddress.getData().wardId.isEmpty {
            G07F02S02._fullAddress.getData().wardId = G07F02VC._data.ward_id
        }
        if G07F02S02._fullAddress.getData().streetId.isEmpty {
            G07F02S02._fullAddress.getData().streetId = G07F02VC._data.street_id
        }
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        return true
    }
}
