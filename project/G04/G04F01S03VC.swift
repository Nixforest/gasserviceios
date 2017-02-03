//
//  G04F01S03.swift
//  project
//
//  Created by SPJ on 1/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G04F01S03VC: MaterialSelectViewController {
    /** Not select promotion button */
    private var _btnNotSelect: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // NavBar setup
        setupNavigationBar(title: DomainConst.CONTENT00238, isNotifyEnable: BaseModel.shared.checkIsLogin(), isHiddenBackBtn: false)
        
        // Update layout
        let maxY = self.updateLayout(bottomHeight: GlobalConst.BUTTON_H + 2 * GlobalConst.MARGIN)
        // Button Confirm
        self._btnNotSelect.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
                                        y: maxY + GlobalConst.MARGIN,
                                        width: GlobalConst.BUTTON_W,
                                        height: GlobalConst.BUTTON_H)
        self._btnNotSelect.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        self._btnNotSelect.setTitle(DomainConst.CONTENT00244.uppercased(), for: UIControlState())
        self._btnNotSelect.setTitleColor(UIColor.white, for: UIControlState())
        self._btnNotSelect.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self._btnNotSelect.addTarget(self, action: #selector(btnNotSelectTapped), for: .touchUpInside)
        self._btnNotSelect.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
        self._btnNotSelect.setImage(ImageManager.getImage(named: DomainConst.CANCEL_IMG_NAME), for: UIControlState())
        self._btnNotSelect.imageView?.contentMode = .scaleAspectFit
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
        MapViewController._promoteSelected = self.getData(index: indexPath.row)
        self.backButtonTapped(self)
    }
    
    /**
     * Handle tap on Not select button
     */
    func btnNotSelectTapped(_ sender: AnyObject) {
        MapViewController._promoteSelected = MaterialBean.init()
        self.backButtonTapped(self)
    }
}
