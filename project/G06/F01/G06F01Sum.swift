//
//  G06F01Sum.swift
//  project
//
//  Created by SPJ on 3/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F01Sum: StepSummary {
    /** Content view */
    private var _detailView = DetailInformationColumnView()

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
                   title: DomainConst.CONTENT00297,
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
        listValues.append((DomainConst.CONTENT00087, G06F01S01._selectedValue.0))
        listValues.append((DomainConst.CONTENT00054, G06F01S01._selectedValue.1))
        listValues.append((DomainConst.CONTENT00240, G06F01S02._selectedValue.name))
        listValues.append((DomainConst.CONTENT00088, G06F01S03._address))
        listValues.append((DomainConst.CONTENT00109, G06F01S04._selectedValue.serial))
        listValues.append((DomainConst.CONTENT00303, G06F01S04._selectedValue.brand))
        listValues.append((DomainConst.CONTENT00116, G06F01S04._selectedValue.competitor))
        //++ BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        listValues.append((DomainConst.CONTENT00445, G06F01S04._selectedValue.ccsCode))
        //-- BUG0111-SPJ (NguyenPT 20170619) Add new field CCS code
        listValues.append((DomainConst.CONTENT00304, G06F01S04._selectedValue.timeUse.name))
        listValues.append((DomainConst.CONTENT00289, G06F01S05._selectedValue.name))
        var investment: [String] = [String]()
        for item in G06F01S06._selectedValue {
            investment.append(item.name)
        }
        listValues.append((DomainConst.CONTENT00163, investment.joined(separator: DomainConst.ADDRESS_SPLITER_WITH_SPACE)))
        return _detailView.updateData(listValues: listValues)
        
    }
}
