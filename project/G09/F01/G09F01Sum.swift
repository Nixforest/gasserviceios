//
//  G09F01Sum.swift
//  project
//
//  Created by SPJ on 5/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G09F01Sum: StepSummary {
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
                   title: DomainConst.CONTENT00389,
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
        if !G09F01VC._typeId.isEmpty {
            listValues.append((DomainConst.CONTENT00392, CacheDataRespModel.record.getCashBookTypeById(id: G09F01VC._typeId)))
        }
        listValues.append((DomainConst.CONTENT00364, G09F01S01.getSelectValue()))
        if G09F01S02._target.name.isEmpty {
            G09F01S02._target.name = "CUA00012-Nha hang Phong Cua AAAAAA"
        }
        listValues.append((G09F01S02.getTargetNameTitle(), G09F01S02._target.name))
        listValues.append((DomainConst.CONTENT00394, G09F01S03._selectedValue))
        listValues.append((DomainConst.CONTENT00081, G09F01S04.getSelectValue()))
        return _detailView.updateData(listValues: listValues)
    }
}
