//
//  ContentCollectionViewCell.swift
//  CustomCollectionLayout
//
//  Created by JOSE MARTINEZ on 09/01/2015.
//  Copyright (c) 2015 brightec. All rights reserved.
//

import UIKit
import harpyframework

class ContentCollectionViewCell: UICollectionViewCell {
    //@IBOutlet weak var contentLabel: UILabel!
    var lbl = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.makeComponentsColor()
    }
    public func updateValue(value: String, leftMargin: CGFloat = 0.0) {
        lbl.frame = CGRect(x: leftMargin, y: 0, width: self.frame.width - leftMargin,
                           height: self.frame.height)
        lbl.font = GlobalConst.BASE_FONT
        lbl.textColor = UIColor.black
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        self.addSubview(lbl)
        lbl.text = value
    }
    public func updateValue(value: String, alignment: NSTextAlignment, bkgColor: UIColor, leftMargin: CGFloat = 0.0) {
        updateValue(value: value, leftMargin: leftMargin)
        lbl.textAlignment = alignment
        self.backgroundColor = bkgColor
    }
}
