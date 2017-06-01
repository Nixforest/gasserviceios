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
        // Get single weight width
        // Update weights value
        setWeights(value: [40, 10, 10, 10, 10])
        var widthOfWeight = ReportCollectionViewLayout.SINGLE_WEIGHT_WIDTH
        // If single weight width not calculated yet
        if widthOfWeight == 0.0 {
            // Update value of single weight width
            updateSingleWeightWidth()
            widthOfWeight = getSingleWeightWidth()
        }
        return CGSize(width: CGFloat(getWeightByColumnIdx(idx: columnIndex)) * widthOfWeight, height: GlobalConst.CONFIGURATION_ITEM_HEIGHT)
    }
}
