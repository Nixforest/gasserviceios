//
//  G07F01S01VC.swift
//  project
//
//  Created by SPJ on 4/12/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G07F01S01VC: MaterialSelectViewController {
    /** Not select promotion button */
    private var _btnNotSelect: UIButton = UIButton()
    /** Current select */
    private static var _selected: MaterialBean = MaterialBean.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00238)
        // Update layout
        let maxY = self.updateLayout(bottomHeight: GlobalConst.BUTTON_H + 2 * GlobalConst.MARGIN)
        // Button Confirm
        CommonProcess.createButtonLayout(btn: self._btnNotSelect,
                                         x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                         y: maxY + GlobalConst.MARGIN,
                                         text: DomainConst.CONTENT00244.uppercased(),
                                         action: #selector(btnNotSelectTapped),
                                         target: self,
                                         img: DomainConst.CANCEL_IMG_NAME,
                                         tintedColor: UIColor.white)
        self._btnNotSelect.imageEdgeInsets = UIEdgeInsets(top: GlobalConst.MARGIN,
                                                          left: GlobalConst.MARGIN,
                                                          bottom: GlobalConst.MARGIN,
                                                          right: GlobalConst.MARGIN)
        self.view.addSubview(self._btnNotSelect)
    }
    
    /**
     * Set data for view
     * - parameter data: List of material bean
     */
    public static func setData(data: [MaterialBean]) {
        MaterialSelectViewController.setMaterialData(data: data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        G07F01S01VC._selected = self.getData(index: indexPath.row)
        self.backButtonTapped(self)
    }
    
    /**
     * Handle tap on Not select button
     */
    internal func btnNotSelectTapped(_ sender: AnyObject) {
        G07F01S01VC._selected = MaterialBean.init()
        self.backButtonTapped(self)
    }
    
    /**
     * Get current select
     * - returns: Current select item
     */
    public static func getCurrentSelected() -> MaterialBean {
        return G07F01S01VC._selected
    }
    
    /**
     * Set current select
     * - parameter data: Current select item
     */
    public static func setCurrentSelected(data: MaterialBean) {
        G07F01S01VC._selected = data
    }
}
