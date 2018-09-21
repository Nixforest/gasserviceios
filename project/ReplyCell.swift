//
//  ReplyCell.swift
//  project
//
//  Created by SPJ on 8/21/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblReply: UILabel!
    @IBOutlet weak var cltv: UICollectionView!
    @IBOutlet weak public var cltvHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        cltv.delegate = dataSourceDelegate
        cltv.dataSource = dataSourceDelegate
        cltv.tag = row
        cltv.reloadData()
    }

}
