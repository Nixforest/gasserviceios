//
//  ReportCashbookLayout.swift
//  project
//
//  Created by SPJ on 6/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportCashbookLayout: ReportCollectionViewLayout {
    override func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize {
        // Update weights value
        setWeights(value: [30, 30, 10, 30, 30, 30])
        return CGSize(width: getWidthByColumnIdx(idx: columnIndex), height: GlobalConst.CONFIGURATION_ITEM_HEIGHT)
    }
}
