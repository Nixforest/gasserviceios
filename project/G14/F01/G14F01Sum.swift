//
//  G14F01Sum.swift
//  project
//
//  Created by SPJ on 12/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G14F01Sum: StepSummary {
    /** Content view */
    private var _detailView:    DetailInformationColumnView = DetailInformationColumnView()    
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        // Set parent
        self.setParentView(parent: parent)
        let offset = updateContentLayout()
        self.setup(mainView: _detailView,
                   title: DomainConst.CONTENT00550,
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
        listValues.append((DomainConst.CONTENT00364, G14F01S01._selectedValue))
        if G14F01S02._target.name.isEmpty {
            G14F01S02._target.name = "CUA00012-Nha hang Phong Cua AAAAAA"
        }
        listValues.append((G14F01S02.getTargetNameTitle(), G14F01S02._target.name))
        return _detailView.updateData(listValues: listValues)
    }
}
