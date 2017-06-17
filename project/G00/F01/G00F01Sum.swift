//
//  G00F01Sum.swift
//  project
//
//  Created by SPJ on 6/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00F01Sum: StepSummary {
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
                   title: DomainConst.CONTENT00444,
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
        listValues.append((DomainConst.CONTENT00087, G00F01S01._selectedValue.name))
        listValues.append((DomainConst.CONTENT00443, G00F01S01._selectedValue.email))
        listValues.append((DomainConst.CONTENT00240, G00F01S02._target.name))
        listValues.append((DomainConst.CONTENT00088, G00F01S03._address))
        return _detailView.updateData(listValues: listValues)
        
    }
}
