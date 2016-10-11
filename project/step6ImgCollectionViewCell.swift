//
//  step6ImgCollectionViewCell.swift
//  project
//
//  Created by Lâm Phạm on 10/8/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class step6ImgCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        imgCell.translatesAutoresizingMaskIntoConstraints = true
        imgCell.frame = CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)
        
    }

}
