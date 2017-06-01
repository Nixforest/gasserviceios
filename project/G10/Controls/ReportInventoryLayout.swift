//
//  ReportInventoryLayout.swift
//  project
//
//  Created by Nix Nixforest on 6/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class ReportInventoryLayout: ReportCollectionViewLayout {
    override func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize {
        // Update weights value
        setWeights(value: [40, 15, 15, 15, 15])
        return CGSize(width: getWidthByColumnIdx(idx: columnIndex), height: GlobalConst.CONFIGURATION_ITEM_HEIGHT)
    }
}
