//
//  G14F00S01Cell.swift
//  project
//
//  Created by SPJ on 12/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G14F00S01Cell: UITableViewCell {
    /** Title */
    var _lblTitle:          UILabel = UILabel()
    /** Cylinder title */
    var _lblCylinder:       UILabel = UILabel()
    /** Mass */
    var _lblMass:           UILabel = UILabel()
    /** Customer */
    var _lblCustomer:       UILabel = UILabel()
    /** Status icon */
    var _imgStatus:         UIImageView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        createTitle()
        createCylinderLabel()
        createMassLabel()
        createCustomerLabel()
        createStatusImage()
        self.contentView.addSubview(_lblTitle)
        self.contentView.addSubview(_lblCylinder)
        self.contentView.addSubview(_lblMass)
        self.contentView.addSubview(_lblCustomer)
        self.contentView.addSubview(_imgStatus)
        self.makeComponentsColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     * Create title
     */
    private func createTitle() {
        _lblTitle.frame = CGRect(x: 0, y: 0,
                                 width: self.frame.width,
                                 height: GlobalConst.LABEL_H)
        _lblTitle.font = GlobalConst.BASE_BOLD_FONT
        _lblTitle.textAlignment = .center
    }
    
    /**
     * Create cylinder label
     */
    private func createCylinderLabel() {
        _lblCylinder.frame = CGRect(
            x: GlobalConst.MARGIN_CELL_X, y: _lblTitle.frame.maxY,
            width: self.frame.width - 2 * GlobalConst.MARGIN_CELL_X,
            height: GlobalConst.LABEL_H)
        _lblCylinder.font = GlobalConst.BASE_FONT
        _lblCylinder.textAlignment = .left
    }
    
    /**
     * Create mass label
     */
    private func createMassLabel() {
        _lblMass.frame = CGRect(
            x: GlobalConst.MARGIN_CELL_X, y: _lblCylinder.frame.maxY,
            width: self.frame.width - 2 * GlobalConst.MARGIN_CELL_X,
            height: GlobalConst.LABEL_H)
        _lblMass.font = GlobalConst.BASE_FONT
        _lblMass.textAlignment = .left        
    }
    
    /**
     * Create customer label
     */
    private func createCustomerLabel() {
        _lblCustomer.frame = CGRect(
            x: GlobalConst.MARGIN_CELL_X, y: _lblMass.frame.maxY,
            width: self.frame.width - 2 * GlobalConst.MARGIN_CELL_X,
            height: GlobalConst.LABEL_H * 2)
        _lblCustomer.font = GlobalConst.BASE_BOLD_FONT
        _lblCustomer.textColor = GlobalConst.MAIN_COLOR
        _lblCustomer.textAlignment = .left   
        _lblCustomer.lineBreakMode = .byWordWrapping
        _lblCustomer.numberOfLines = 0
    }
    
    /**
     * Create status image
     */
    private func createStatusImage() {
        _imgStatus.frame = CGRect(
            x: self.frame.width - GlobalConst.LABEL_H - GlobalConst.MARGIN,
            y: GlobalConst.LABEL_H * 2,
            width: GlobalConst.LABEL_H,
            height: GlobalConst.LABEL_H)
        _imgStatus.contentMode = .scaleAspectFit
    }
    
    /**
     * Set data for cell
     * - parameter data: GasRemainList bean
     */
    public func setData(data: GasRemainListBean) {
        _lblTitle.text = "\(data.name) - \(data.amount_gas)"
//        CommonProcess.makeMultiColorLabel(
//            lbl: _lblTitle,
//            lstString: [data.name],
//            colors: [UIColor.red])
        var color = GlobalConst.STATUS_GAREMAIN_COLOR_WAIT
        switch data.has_export {
        case DomainConst.STATUS_NOT_EXPORT:
            color = GlobalConst.STATUS_GAREMAIN_COLOR_NOT_EXPORT
            break
        case DomainConst.STATUS_EXPORT:
            color = GlobalConst.STATUS_GAREMAIN_COLOR_EXPORT
            break
        default:
             color = GlobalConst.STATUS_GAREMAIN_COLOR_WAIT
            break
        }
        CommonProcess.makeMultiColorLabel(
            lbl: _lblTitle,
            lstString: [data.name, data.amount_gas],
            colors: [GlobalConst.MAIN_COLOR, color])
        
        _lblCylinder.text = "\(data.date_input) \(data.materials_name)"
        _lblMass.text = "\(data.weight_info)"
        _lblCustomer.text = "\(data.customer_name)"
        var editImg = DomainConst.BLANK
        if data.allow_update == 1 {
            editImg = "editbtn.png"
        }
        _imgStatus.image = ImageManager.getImage(named: editImg)
        
    }
}
