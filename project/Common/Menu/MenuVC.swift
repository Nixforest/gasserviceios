//
//  MenuVC.swift
//  project
//
//  Created by SPJ on 9/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class MenuVC: BaseMenuViewController {
    // MARK: Properties
    /** Label name */
    var lblName:            UILabel     = UILabel()
    /** Label phone */
    var lblPhone:           UILabel     = UILabel()
    /** Label address */
    var lblAddress:         UILabel     = UILabel()
    /** Button edit */
    var btnEdit:            UIButton    = UIButton()
    /** Label separator */
    var lblSeparator:       UILabel     = UILabel()
    
    // MARK: Override methods
    override func viewDidLoad() {
        let topOffset = getTopPartHeight()
        updateTopPartHeight(value: topOffset + GlobalConst.LABEL_H * 5)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createLabel(lbl: lblName, text: "Huỳnh Lê Chung", offset: topOffset, isBold: true)
        createLabel(lbl: lblPhone, text: "0903816165", offset: lblName.frame.maxY)
        createLabel(lbl: lblAddress, text: "189/22 Hoàng Hoa Thám P.6 Q.Bình Thạnh",
                    offset: lblPhone.frame.maxY, isBold: false, height: GlobalConst.LABEL_H * 2)
        createLabel(lbl: lblSeparator, text: "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", offset: lblAddress.frame.maxY)
        createEditBtn()
        
        
        self.view.addSubview(lblName)
        self.view.addSubview(lblPhone)
        self.view.addSubview(lblAddress)
        self.view.addSubview(lblSeparator)
        self.view.addSubview(btnEdit)
        self.view.makeComponentsColor()
    }
    
    override func createBackground() {
        self.view.layer.contents = ImageManager.getImage(named: DomainConst.MENU_BKG_BODY_NEW_IMG_NAME)?.cgImage
    }
    
    override func createTopPart() {
        // Setting top image
        createTopView(topImgPath: DomainConst.MENU_BKG_TOP_NEW_IMG_NAME)
        // Setting logo
        createTopLogo(logo: DomainConst.LOGO_LOGIN_ICON_IMG_NAME)
    }

    override func openLogin() {
        let loginView = G00LoginExtVC(nibName: G00LoginExtVC.theClassName, bundle: nil)
        if let controller = BaseViewController.getCurrentViewController() {
            controller.present(loginView, animated: true, completion: finishOpenLogin)
        }
    }
    // MARK: Event handler
    internal func btnEditTapped(_ sender: AnyObject) {
        showAlert(message: "btnEditTapped")
    }
    
    // MARK: Utilities
    private func createLabel(lbl: UILabel, text: String,
                             offset: CGFloat,
                             isBold: Bool = false,
                             height: CGFloat = GlobalConst.LABEL_H) {
        lbl.frame = CGRect(x: GlobalConst.MARGIN, y: offset,
                               width: GlobalConst.POPOVER_WIDTH - 2 * GlobalConst.MARGIN,
                               height: height)
        lbl.text = text
        lbl.textColor = UIColor.white
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        if isBold {
            lbl.font = GlobalConst.BASE_BOLD_FONT
        } else {
            lbl.font = GlobalConst.BASE_FONT
        }
    }
    
    private func createEditBtn() {
        let btnSize = GlobalConst.LABEL_H
        btnEdit.frame = CGRect(x: GlobalConst.POPOVER_WIDTH - btnSize - GlobalConst.MARGIN,
                               y: lblSeparator.frame.minY - btnSize,
                               width: btnSize, height: btnSize)
        btnEdit.setImage(ImageManager.getImage(named: DomainConst.EDIT_BUTTON_ICON_IMG_NAME),
                         for: UIControlState())
        btnEdit.imageView?.contentMode = .scaleAspectFit
        btnEdit.addTarget(self, action: #selector(btnEditTapped(_:)),
                          for: .touchUpInside)
    }
    
    internal func finishOpenLogin() -> Void {
        print("finishOpenLogin")
    }

}
