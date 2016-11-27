//
//  CollectionViewCell1.swift
//  TestCollectionView
//
//  Created by HungHa on 10/13/16.
//  Copyright © 2016 HungHa. All rights reserved.
//

import UIKit

class CollectionImageViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView1: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView1.translatesAutoresizingMaskIntoConstraints = true
        //imageView1.frame  = CGRect(x: 0,  y: 0,  width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        imageView1.contentMode = UIViewContentMode.scaleAspectFill
    }

}
