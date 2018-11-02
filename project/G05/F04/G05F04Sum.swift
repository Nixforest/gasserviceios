//
//  G05F04Sum.swift
//  project
//
//  Created by SPJ on 6/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G05F04Sum: StepSummary {
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
                   title: DomainConst.CONTENT00439,
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
        listValues.append((DomainConst.CONTENT00231, G05F04VC._orderInfo))
        listValues.append((DomainConst.CONTENT00081, G05F04S02._selectedValue))
        return _detailView.updateData(listValues: listValues)
    }
}
