//
//  HomeTableViewCell.swift
//  project
//
//  Created by Lâm Phạm on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G00HomeCell: UITableViewCell {
    /** Image view */
    @IBOutlet weak var homeCellImageView: UIImageView!
    /** Title of cell */
    @IBOutlet weak var titleLbl: UILabel!

    /**
     * Awake from nib
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /**
     * Handle when select cell
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //++ BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    /**
     * Handle set data for item
     * - parameter icon: Icon path
     * - parameter text: Title label content
     */
    public func setData(icon: String, text: String) {
        let img = ImageManager.getImage(named: icon)
        let tinted = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        homeCellImageView.tintColor = UIColor.white
        homeCellImageView.image = tinted
        homeCellImageView.translatesAutoresizingMaskIntoConstraints = true
        homeCellImageView.frame = CGRect(x: GlobalConst.ACCOUNT_AVATAR_H / 4,
                            y: GlobalConst.ACCOUNT_AVATAR_H / 8,
                            width: GlobalConst.ACCOUNT_AVATAR_H / 4,
                            height: GlobalConst.ACCOUNT_AVATAR_H / 4)
        homeCellImageView.backgroundColor = GlobalConst.MAIN_COLOR
        titleLbl.frame = CGRect(x: GlobalConst.MARGIN + homeCellImageView.frame.maxX + GlobalConst.ACCOUNT_AVATAR_H / 8,
                                y: 0,
                                width: GlobalConst.ACCOUNT_AVATAR_H,
                                height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        //++ BUG0217-SPJ (KhoiVT 20170808) Gasservice - Cho title Đơn hàng HGĐ và Đơn hàng bò mối lớn hơn các title còn lại trên menu
        titleLbl.font = titleLbl.font.withSize(17)
        //-- BUG0217-SPJ (KhoiVT 20170808) Gasservice - Cho title Đơn hàng HGĐ và Đơn hàng bò mối lớn hơn các title còn lại trên menu
        titleLbl.text = text
        titleLbl.textColor = UIColor.white
        titleLbl.backgroundColor = GlobalConst.MAIN_COLOR
        self.contentView.backgroundColor = GlobalConst.MAIN_COLOR
        self.contentView.layer.addBorder(edge: .bottom,
                                         color: UIColor.white,
                                         thickness: 1.0)
    }
    //-- BUG0121-SPJ (NguyenPT 20170712) Add menu to Home
    //++ BUG0217-SPJ (KhoiVT 20170808) Gasservice - Cho title Đơn hàng HGĐ và Đơn hàng bò mối lớn hơn các title còn lại trên menu
    /**
     * Handle set data for item
     * - parameter icon: Icon path
     * - parameter text: Title label content
     */
    public func setDataBigTitle(icon: String, text: String) {
        let img = ImageManager.getImage(named: icon)
        let tinted = img?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        homeCellImageView.tintColor = UIColor.white
        homeCellImageView.image = tinted
        homeCellImageView.translatesAutoresizingMaskIntoConstraints = true
        homeCellImageView.frame = CGRect(x: GlobalConst.ACCOUNT_AVATAR_H / 4,
                                         y: GlobalConst.ACCOUNT_AVATAR_H / 8,
                                         width: GlobalConst.ACCOUNT_AVATAR_H / 4,
                                         height: GlobalConst.ACCOUNT_AVATAR_H / 4)
        homeCellImageView.backgroundColor = GlobalConst.MAIN_COLOR
        titleLbl.frame = CGRect(x: GlobalConst.MARGIN + homeCellImageView.frame.maxX + GlobalConst.ACCOUNT_AVATAR_H / 8,
                                y: 0,
                                width: GlobalConst.CELL_MENU_WIDTH,
                                height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        titleLbl.font = titleLbl.font.withSize(20)
        titleLbl.text = text
        titleLbl.textColor = UIColor.white
        titleLbl.backgroundColor = GlobalConst.MAIN_COLOR
        self.contentView.backgroundColor = GlobalConst.MAIN_COLOR
        self.contentView.layer.addBorder(edge: .bottom,
                                         color: UIColor.white,
                                         thickness: 1.0)
    }
    //++ BUG0217-SPJ (KhoiVT 20170808) Gasservice - Cho title Đơn hàng HGĐ và Đơn hàng bò mối lớn hơn các title còn lại trên menu
}
