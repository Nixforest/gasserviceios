//
//  G05F03Sum.swift
//  project
//
//  Created by SPJ on 5/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F03Sum: StepSummary {
    // MARK: Properties
    /** Content view */
    private var _detailView:    DetailInformationColumnView = DetailInformationColumnView()

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
        // Set parent
        self.setParentView(parent: parent)
        let offset = updateContentLayout()
        self.setup(mainView: _detailView,
                   title: DomainConst.CONTENT00375,
                   contentHeight: offset,
                   width: w, height: h)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Update layout of content
     * - returns: Offset after reload
     */
    override func updateContentLayout() -> CGFloat {
        var listValues = [(String, String)]()
        listValues.append((DomainConst.CONTENT00079, G05F03S01._target.name))
        listValues.append((DomainConst.CONTENT00088, G05F03S01._target.customer_address))
        
        var b50 = DomainConst.NUMBER_ZERO_VALUE
        var b45 = DomainConst.NUMBER_ZERO_VALUE
        var b12 = DomainConst.NUMBER_ZERO_VALUE
        var b6 = DomainConst.NUMBER_ZERO_VALUE
        for item in G05F03S02._lstSelector {
            switch item.getSelectorValue().id {
            case DomainConst.KEY_B50:
                b50 = item.getSelectorValue().name
                break
            case DomainConst.KEY_B45:
                b45 = item.getSelectorValue().name
                break
            case DomainConst.KEY_B12:
                b12 = item.getSelectorValue().name
                break
            case DomainConst.KEY_B6:
                b6 = item.getSelectorValue().name
                break
            default:
                break
                
            }
        }
        if b50 != DomainConst.NUMBER_ZERO_VALUE {
            listValues.append((DomainConst.CONTENT00384, b50))
        }
        if b45 != DomainConst.NUMBER_ZERO_VALUE {
            listValues.append((DomainConst.CONTENT00385 , b45))
        }
        if b12 != DomainConst.NUMBER_ZERO_VALUE {
            listValues.append((DomainConst.CONTENT00386, b12))
        }
        if b6 != DomainConst.NUMBER_ZERO_VALUE {
            listValues.append((DomainConst.CONTENT00387, b6))
        }
        listValues.append((DomainConst.CONTENT00081, G05F03S02._note))
        listValues.append((DomainConst.CONTENT00240, G05F03S03._selectedValue.name))
        var phone = DomainConst.BLANK
        if !G05F03S04._selectedValue.isBlank {
            phone = G05F03S04._selectedValue
        } else {
            phone = G05F03S01._target.getActivePhone()
        }
        listValues.append((DomainConst.CONTENT00152, phone))
        return _detailView.updateData(listValues: listValues)
    }
}
