//
//  G04F00S02VC.swift
//  project
//
//  Created by SPJ on 12/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G04F00S02VC: BaseViewController {
    // MARK: Properties
    /** Parent view */
    var _scrollView: UIScrollView = UIScrollView()
    /** Employee */
    var lblEmployee: UILabel = UILabel()
    /** Icon image view */
    var iconImg: UIImageView = UIImageView()
    /** Name */
    var lblName: UILabel = UILabel()
    /** Data */
    private static var _data:       OrderViewRespModel = OrderViewRespModel()
    
    // MARK: Methods
    /**
     * Set data of screen.
     * - parameter jsonString: JSON data
     */
    public func setData(jsonString: String) {
        G04F00S02VC._data = OrderViewRespModel(jsonString: jsonString)
    }
    /**
     * Handle when tap menu item
     */
    func asignNotifyForMenuItem() {
        NotificationCenter.default.addObserver(self, selector: #selector(configItemTap(_:)), name:NSNotification.Name(rawValue: G04Const.NOTIFY_NAME_G04_ORDER_VIEW_CONFIG_ITEM), object: nil)
    }
    
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu item tap
        asignNotifyForMenuItem()
        
        // Get height of status bar + navigation bar
        let height = self.getTopHeight()
        // Offset
        var offset: CGFloat = GlobalConst.MARGIN
        _scrollView.translatesAutoresizingMaskIntoConstraints = true
        _scrollView.frame = CGRect(
            x: 0,
            y: 0,
            width: GlobalConst.SCREEN_WIDTH,
            height: GlobalConst.SCREEN_HEIGHT - height)
        
        // Label Employee
        lblEmployee.translatesAutoresizingMaskIntoConstraints = true
        lblEmployee.frame = CGRect(x: 0,
                               y: offset,
                               width: GlobalConst.SCREEN_WIDTH,
                               height: GlobalConst.LABEL_H)
        lblEmployee.text = DomainConst.CONTENT00233
        lblEmployee.textAlignment = .center
        lblEmployee.textColor = GlobalConst.TEXT_COLOR
        lblEmployee.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self._scrollView.addSubview(lblEmployee)
        offset += lblEmployee.frame.height
        
        // Icon image
        iconImg.image = UIImage(named: "ic_custom_order_top.png")
        iconImg.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH - GlobalConst.LOGIN_LOGO_W / 2) / 2,
                               y: offset,
                               width: GlobalConst.LOGIN_LOGO_W / 2,
                               height: GlobalConst.LOGIN_LOGO_H / 2)
        iconImg.contentMode = .scaleAspectFit
        iconImg.translatesAutoresizingMaskIntoConstraints = true
        self._scrollView.addSubview(iconImg)
        offset += iconImg.frame.height
        
        // Label name
        lblName.translatesAutoresizingMaskIntoConstraints = true
        lblName.frame = CGRect(x: 0,
                               y: offset,
                               width: GlobalConst.SCREEN_WIDTH,
                               height: GlobalConst.LABEL_H)
        lblName.text = BaseModel.shared.user_info?.getName()
        lblName.textAlignment = .center
        lblName.textColor = GlobalConst.BUTTON_COLOR_RED
        self._scrollView.addSubview(lblName)
        offset += lblName.frame.height
        
        
        self._scrollView.contentSize = CGSize(
            width: GlobalConst.SCREEN_WIDTH,
            height: offset)
        self.view.addSubview(_scrollView)
        
        // NavBar setup
        setupNavigationBar(title: DomainConst.CONTENT00232, isNotifyEnable: BaseModel.shared.checkIsLogin())
        
        // Notify set data
        NotificationCenter.default.addObserver(self, selector: #selector(setData(_:)), name:NSNotification.Name(rawValue: G04Const.NOTIFY_NAME_G04_ORDER_VIEW_SET_DATA), object: nil)
        
        OrderViewRequest.requestOrderView(id: "99", view: self)
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

}
