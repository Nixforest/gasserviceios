//
//  G11F01Sum.swift
//  project
//
//  Created by Nix Nixforest on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G11F01Sum: StepSummary {
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
                   title: DomainConst.CONTENT00432,
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
        listValues.append((DomainConst.CONTENT00062, G11F01S01._selectedValue.title))
        listValues.append((DomainConst.CONTENT00063, G11F01S01._selectedValue.content))
        listValues.append((DomainConst.CONTENT00433, G11F01S02._selectedValue.name))
        return _detailView.updateData(listValues: listValues)
        
    }
}
