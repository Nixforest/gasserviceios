//
//  ReportOrderFamilyLayout.swift
//  project
//
//  Created by SPJ on 6/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportOrderFamilyLayout: ReportCollectionViewLayout {
    override func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize {
        // Update weights value
        setWeights(value: [40, 30, 10, 15, 30, 15, 15])
        return CGSize(width: getWidthByColumnIdx(idx: columnIndex), height: GlobalConst.CONFIGURATION_ITEM_HEIGHT)
    }

}
