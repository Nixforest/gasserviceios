//
//  G12F01S01VC.swift
//  project
//
//  Created by SPJ on 9/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G12F01S01VC: ParentExtViewController {
    // MARK: Properties
    /** Category view */
    var categoryView:           UIView      = UIView()
    /** List of category button */
    var listButton:             [UIButton]  = [UIButton]()
    /** Label Order */
    var lblOrder:               UILabel     = UILabel()
    
    // MARK: Constant
    // Category button
    var CATEGORY_BUTTON_REAL_SIZE_HD    = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_HD
    var CATEGORY_BUTTON_REAL_SIZE_FHD   = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_FHD
    var CATEGORY_BUTTON_REAL_SIZE_FHD_L = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_FHD_L
    
    // Order label
    var ORDER_LABEL_REAL_Y_POS_HD       = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_HD
    var ORDER_LABEL_REAL_Y_POS_FHD      = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_FHD
    var ORDER_LABEL_REAL_Y_POS_FHD_L    = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_FHD_L
    
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        self.createNavigationBar(title: "1900 1565")
//        openLogin()
    }
    
    /**
     * Handle update constants
     */
    override func updateConst() {
        super.updateConst()
        // Category button
        CATEGORY_BUTTON_REAL_SIZE_HD    = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_HD
        CATEGORY_BUTTON_REAL_SIZE_FHD   = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_FHD
        CATEGORY_BUTTON_REAL_SIZE_FHD_L = GlobalConst.BUTTON_CATEGORY_SIZE_NEW * BaseViewController.H_RATE_FHD_L
        
        // Order label
        ORDER_LABEL_REAL_Y_POS_HD       = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_HD
        ORDER_LABEL_REAL_Y_POS_FHD      = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_FHD
        ORDER_LABEL_REAL_Y_POS_FHD_L    = GlobalConst.ORDER_LABEL_Y_POS * BaseViewController.H_RATE_FHD_L
    }
    
    /**
     * Handle set background image
     */
    override func setBackgroundImage() {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPHONE_IMG_NAME)
            break
        case .pad:
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
            case .landscapeLeft, .landscapeRight:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_LANDSCAPE_IMG_NAME)
            default:
                self.updateBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
            }
            break
        default:
            self.setBackground(bkg: DomainConst.LOGIN_BKG_IPAD_IMG_NAME)
        }
    }
    
    /**
     * Create children views
     */
    override func createChildrenViews() {
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            createCategoryViewHD()
            createOrderHD()
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                createCategoryViewFHD()
                createOrderFHD()
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                createCategoryViewFHD_L()
                createOrderFHD_L()
                break
            default:
                break
            }
            
            break
        default:
            break
        }
        self.view.addSubview(categoryView)
        self.view.addSubview(lblOrder)
    }
    
    /**
     * Update children views
     */
    override func updateChildrenViews() {
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            updateCategoryViewHD()
            updateOrderHD()
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                updateCategoryViewFHD()
                updateOrderFHD()
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                updateCategoryViewFHD_L()
                updateOrderFHD_L()
                break
            default:
                break
            }
            
            break
        default:
            break
        }
    }
    
    // MARK: Event handler
    /**
     * Handle when tap on category buttons
     * - parameter sender: Button object
     */
    func enableButton(_ sender: AnyObject) {
        // Handle by button identify
        switch ((sender as! UIButton).accessibilityIdentifier!) {
        case DomainConst.CATEGORY_TYPE_VIP, DomainConst.CATEGORY_TYPE_UTILITY:
            showAlert(message: DomainConst.CONTENT00197)
            return
        case DomainConst.CATEGORY_TYPE_GAS:
            break
        default:
            break
        }
        // Release selection from all button
        for btn in self.listButton {
            btn.isSelected = false
        }
        // Select current tapped button
        (sender as! UIButton).isSelected = true
    }
    
    // MARK: Utilities
    /**
     * Handle open login view
     */
    private func openLogin() {
        let login = G00LoginExtVC(nibName: G00LoginExtVC.theClassName, bundle: nil)
        self.present(login, animated: true, completion: finishOpenLogin)
    }
    
    /**
     * Handle when finish open login view
     */
    internal func finishOpenLogin() -> Void {
        print("finishOpenLogin")
    }
    
    /**
     * Create category view
     * - parameter x: X position
     * - parameter y: Y position
     * - parameter w: Width of view
     * - parameter h: Height of view
     */
    private func createCategoryView(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.categoryView.frame = CGRect(x: x, y: y, width: w, height: h)
        self.categoryView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        createCategoryContent()
    }
    
    /**
     * Create category content
     */
    private func createCategoryContent() {
        // Attemp list config
        var listConfig = [ConfigBean]()
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_VIP, name: "  VIP"))
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_GAS, name: "  GAS"))
        listConfig.append(ConfigBean(id: DomainConst.CATEGORY_TYPE_UTILITY, name: "PHỤ KIỆN"))
        // Attemp list image
        var listImg = [(String, String)]()
        listImg.append((DomainConst.CATEGORY_VIP_ICON_IMG_NAME, DomainConst.CATEGORY_VIP_ICON_IMG_NAME))
        listImg.append((DomainConst.CATEGORY_GAS_ICON_IMG_NAME, DomainConst.CATEGORY_GAS_ICON_IMG_NAME))
        listImg.append((DomainConst.CATEGORY_DETAIL_ICON_IMG_NAME, DomainConst.CATEGORY_DETAIL_ICON_IMG_NAME))
        let btnWidth = categoryView.frame.height - GlobalConst.MARGIN
        let margin = GlobalConst.MARGIN
        let count = listConfig.count
        let btnSpace    = (UIScreen.main.bounds.width - 2 * margin - btnWidth) / (CGFloat)(count - 1)
        
        for i in 0..<count {
            // Calculate frame of button
            let frame = CGRect(x: margin + CGFloat(i) * btnSpace, y: margin / 2,
                               width: btnWidth,
                               height: btnWidth + GlobalConst.MARGIN)
            let btn = CategoryButton(frame: frame, icon: listImg[i].0, iconActive: listImg[i].1, title: listConfig[i].name, id: listConfig[i].id)
            
            btn.addTarget(self, action: #selector(enableButton), for: .touchUpInside)
            // Select default button
            if listConfig[i].id == DomainConst.CATEGORY_TYPE_GAS {
                btn.isSelected = true
            }
            listButton.append(btn)
            self.categoryView.addSubview(btn)
        }
    }
    
    /**
     * Update category content
     */
    private func updateCategoryContent() {
        let btnWidth = categoryView.frame.height - GlobalConst.MARGIN
        let margin = GlobalConst.MARGIN
        let count = listButton.count
        let btnSpace    = (UIScreen.main.bounds.width - 2 * margin - btnWidth) / (CGFloat)(count - 1)
        
        for i in 0..<count {
            // Calculate frame of button
            listButton[i].frame = CGRect(x: margin + CGFloat(i) * btnSpace, y: margin / 2,
                               width: btnWidth,
                               height: btnWidth + GlobalConst.MARGIN)
        }
    }
    
    /**
     * Create category view (in HD mode)
     */
    private func createCategoryViewHD() {
        createCategoryView(x: 0, y: getTopHeight(),
                           w: UIScreen.main.bounds.width,
                           h: CATEGORY_BUTTON_REAL_SIZE_HD)
    }
    
    /**
     * Create category view (in Full HD mode)
     */
    private func createCategoryViewFHD() {
        createCategoryView(x: 0, y: getTopHeight(),
                           w: UIScreen.main.bounds.width,
                           h: CATEGORY_BUTTON_REAL_SIZE_FHD)
    }
    
    /**
     * Create category view (in Full HD Landscape mode)
     */
    private func createCategoryViewFHD_L() {
        createCategoryView(x: 0, y: getTopHeight(),
                           w: UIScreen.main.bounds.width,
                           h: CATEGORY_BUTTON_REAL_SIZE_FHD_L)
    }
    
    /**
     * Update category view (in HD mode)
     */
    private func updateCategoryViewHD() {
        CommonProcess.updateViewPos(view: categoryView,
                                    x: 0, y: getTopHeight(),
                                    w: UIScreen.main.bounds.width,
                                    h: CATEGORY_BUTTON_REAL_SIZE_HD)
        updateCategoryContent()
    }
    
    /**
     * Update category view (in Full HD mode)
     */
    private func updateCategoryViewFHD() {
        CommonProcess.updateViewPos(view: categoryView,
                                    x: 0,
                                    y: getTopHeight(),
                                    w: UIScreen.main.bounds.width,
                                    h: CATEGORY_BUTTON_REAL_SIZE_FHD)
        updateCategoryContent()
    }
    
    /**
     * Update category view (in Full HD Landscape mode)
     */
    private func updateCategoryViewFHD_L() {
        CommonProcess.updateViewPos(view: categoryView,
                                    x: 0,
                                    y: getTopHeight(),
                                    w: UIScreen.main.bounds.width,
                                    h: CATEGORY_BUTTON_REAL_SIZE_FHD_L)
        updateCategoryContent()
    }
    
    /**
     * Create order label
     */
    private func createOrderLabel() {
        lblOrder.text           = DomainConst.CONTENT00130.uppercased()
        lblOrder.textColor      = UIColor.red
        lblOrder.font           = UIFont.boldSystemFont(ofSize: GlobalConst.NOTIFY_FONT_SIZE)
        lblOrder.textAlignment  = .center
    }
    
    private func createOrderHD() {
        createOrderLabel()
        lblOrder.frame = CGRect(x: 0,
                                y: ORDER_LABEL_REAL_Y_POS_HD,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H * 2)
        
    }
    
    private func createOrderFHD() {
        createOrderLabel()
        lblOrder.frame = CGRect(x: 0,
                                y: ORDER_LABEL_REAL_Y_POS_FHD,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H * 2)
        
    }
    
    private func createOrderFHD_L() {
        createOrderLabel()
        lblOrder.frame = CGRect(x: 0,
                                y: ORDER_LABEL_REAL_Y_POS_FHD_L,
                                width: UIScreen.main.bounds.width,
                                height: GlobalConst.LABEL_H * 2)
        
    }
    
    private func updateOrderHD() {
        CommonProcess.updateViewPos(view: lblOrder,
                                    x: 0, y: ORDER_LABEL_REAL_Y_POS_HD,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H * 2)
    }
    
    private func updateOrderFHD() {
        CommonProcess.updateViewPos(view: lblOrder,
                                    x: 0, y: ORDER_LABEL_REAL_Y_POS_FHD,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H * 2)
    }
    
    private func updateOrderFHD_L() {
        CommonProcess.updateViewPos(view: lblOrder,
                                    x: 0, y: ORDER_LABEL_REAL_Y_POS_FHD_L,
                                    w: UIScreen.main.bounds.width,
                                    h: GlobalConst.LABEL_H * 2)
    }
}
