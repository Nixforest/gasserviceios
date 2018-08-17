//
//  ImageCell.swift
//  project
//
//  Created by SPJ on 8/9/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

protocol ImageDelegte{
    func deleteImage(cell:ImageCell)
}
class ImageCell: UICollectionViewCell {
    var delegate: ImageDelegte?
    @IBAction func deleteImage(_ sender: Any) {
        delegate?.deleteImage(cell: self)
    }
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var btnDeletePicture: UIButton!
}
