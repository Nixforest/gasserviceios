//
//  G07F02Sum.swift
//  project
//
//  Created by SPJ on 7/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F02Sum: StepSummary {
    /** Content view */
    private var _detailView = DetailInformationColumnView()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    /**
     * Update layout of content
     * - returns: Offset after reload
     */
    override func updateContentLayout() -> CGFloat {
        var listValues = [(String, String)]()
        listValues.append((DomainConst.CONTENT00087, G07F02S01._selectedValue.0))
        listValues.append((DomainConst.CONTENT00054, G07F02S01._selectedValue.1))
        listValues.append((DomainConst.CONTENT00088, G07F02S02.getFullAddress()))
        return _detailView.updateData(listValues: listValues)
    }
}
