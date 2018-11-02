//
//  G20F01S01VC.swift
//  project
//
//  Created by SPJ on 10/9/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework
//import VVWaterWaveView
//++ BUG0224-SPJ (KhoiVT 20180930) Gasservice - ForeCast Amount Gas
class G20F01S01VC: BaseParentViewController {

    @IBOutlet weak var imgViewNotification: UIImageView!
    
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var viewForecast: UIView!
    @IBOutlet weak var img_Gas_Percent_10: UIImageView!
    @IBOutlet weak var img_Gas_Percent_20: UIImageView!
    @IBOutlet weak var img_Gas_Percent_30: UIImageView!
    @IBOutlet weak var img_Gas_Percent_40: UIImageView!
    @IBOutlet weak var img_Gas_Percent_50: UIImageView!
    @IBOutlet weak var img_Gas_Percent_60: UIImageView!
    @IBOutlet weak var img_Gas_Percent_70: UIImageView!
    @IBOutlet weak var img_Gas_Percent_80: UIImageView!
    @IBOutlet weak var img_Gas_Percent_90: UIImageView!
    @IBOutlet weak var img_Gas_Percent_100: UIImageView!
    
    @IBOutlet weak var lblLastOrder: UILabel!
    @IBOutlet weak var lblPercent: UILabel!
    
    @IBOutlet weak var lblDays: UILabel!
    
    @IBOutlet weak var imgWarning: UIImageView!
    
    @IBOutlet weak var lblWarningTitle: UILabel!
    
    @IBOutlet weak var lblWarningContent: UILabel!
    internal var _data:              ForecastBean  = ForecastBean()
    var level : Float = 1
    
    
    @IBAction func order(_ sender: Any) {
        if BaseModel.shared.isCustomerUser() {
            self.pushToView(name: G05Const.G05_F01_S02_VIEW_CTRL)
            //++ BUG0094-SPJ (NguyenPT 20170519) Add function create order by Coordinator
        } else if BaseModel.shared.isCoordinator() {
            if TempDataRespModel.isEmpty() {
                TempDataRequest.request(action: #selector(finishTempDataRequest(_:)),
                                        view: self,
                                        agent_id: DomainConst.BLANK)
            } else {
                self.pushToView(name: G05F03VC.theClassName)
            }
            //-- BUG0094-SPJ (NguyenPT 20170519) Add function create order by Coordinator
        } else {
            self.showAlert(message: DomainConst.CONTENT00279)
        }
    }
    
    internal func finishTempDataRequest(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = TempDataRespModel(jsonString: dataStr)
        if model.isSuccess() {
            self.pushToView(name: G05F03VC.theClassName)
        } else {
            showAlert(message: model.message)
        }
    }
    
    
    @IBAction func uphold(_ sender: Any) {
        self.showToast(message: "CATEGORY_TYPE_UPHOLD")
        //++ BUG0159-SPJ (KhoiVT 20171113) Change [Basemodel._userInfo] from optional to normal variable
        if BaseModel.shared.user_info.getName().isBlank {
            //-- BUG0159-SPJ (KhoiVT 20171113) Change [Basemodel._userInfo] from optional to normal variable
            // User information does not exist
            //++ BUG0046-SPJ (NguyenPT 20170301) Use action for Request server completion
            //RequestAPI.requestUserProfile(action: #selector(finishRequestUserProfile(_:)), view: self)
            UserProfileRequest.requestUserProfile(action: #selector(finishRequestUserProfile(_:)), view: self)
            //-- BUG0046-SPJ (NguyenPT 20170301) Use action for Request server completion
        } else {
            self.pushToView(name: DomainConst.G01_F01_VIEW_CTRL)
        }
    }
    
    internal func finishRequestUserProfile(_ notification: Notification) {
        //++ BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
        let data = (notification.object as! String)
        let model = UserProfileRespModel(jsonString: data)
        if model.isSuccess() {
            BaseModel.shared.setUserInfo(userInfo: model.record)
        } else {
            showAlert(message: model.message)
            return
        }
        //-- BUG0047-SPJ (NguyenPT 20170724) Refactor BaseRequest class
        self.pushToView(name: DomainConst.G01_F01_VIEW_CTRL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(title: DomainConst.CONTENT00598)
        
        viewNotification.layer.cornerRadius = self.view.frame.height * 0.056
        //hideWarning
        hideWarning()
        requestData()
    }
    
    public func rotateLevel(levelGas : Float){
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = -1 * CGFloat(levelGas) * CGFloat.pi / 5
        rotate.duration = 2.0
        rotate.isCumulative = false
        rotate.fillMode = kCAFillModeForwards
        rotate.isRemovedOnCompletion = false
        self.imgViewNotification.layer.add(rotate, forKey: "transform.rotation")
    }
    
    public func hideWarning(){
        imgWarning.isHidden = true
        lblWarningTitle.isHidden = true
        lblWarningContent.isHidden = true
    }
    
    public func appearWarning(){
        imgWarning.isHidden = false
        lblWarningTitle.isHidden = false
        lblWarningContent.isHidden = false
    }
    
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        ForecastViewRequest.request(action: action,
                                    view: self
        )
    }
    
    override func setData(_ notification: Notification) {
        let dataStr = (notification.object as! String)
        let model = ForecastViewResponseModel(jsonString: dataStr)
        if model.isSuccess() {
            _data = model.record
            let formattedString = NSMutableAttributedString()
            formattedString
                .bold(String(_data.gas_percent), lblPercent.font.pointSize)
                .bold("%",lblPercent.font.pointSize * 0.75)
            let formattedString1 = NSMutableAttributedString()
            formattedString1
                .bold(String(_data.days_forecast), lblDays.font.pointSize)
                .small(" NGÀY",lblDays.font.pointSize * 0.85)
            lblPercent.attributedText = formattedString
            lblDays.attributedText = formattedString1
            let currentFontSize = lblLastOrder.font.pointSize
            let yourAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: currentFontSize)]
            let yourOtherAttributes = [NSForegroundColorAttributeName: GlobalConst.BUTTON_COLOR_RED, NSFontAttributeName: UIFont.systemFont(ofSize: currentFontSize)]
            
            let partOne = NSMutableAttributedString(string: "Ngày đặt gas lần trước:  ", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: _data.last_order, attributes: yourOtherAttributes)
            
            let combination = NSMutableAttributedString()
            
            combination.append(partOne)
            combination.append(partTwo) 
            lblLastOrder.attributedText = combination
            //_data.gas_percent = 78
            if _data.gas_percent <= 15{
                appearWarning()
            }
            else{
                hideWarning()
            }
            if _data.gas_percent < 15 {
                self.level = 1
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_10)
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_90.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 15 && _data.gas_percent < 25{
                level = 2
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_20)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_90.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 25 && _data.gas_percent < 35{
                level = 3
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_30)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_90.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 35 && _data.gas_percent < 45{
                level = 4
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_40)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_90.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 45 && _data.gas_percent < 55{
                level = 5
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_50)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_90.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 55 && _data.gas_percent < 65{
                level = 6
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_60)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_90.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 65 && _data.gas_percent < 75{
                level = 7
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_70)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_90.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 75 && _data.gas_percent < 85{
                level = 8
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_80)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_90.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 85 && _data.gas_percent < 95{
                level = 9
                rotateLevel(levelGas: self.level)
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_90)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_100.isHidden = true
            }
            else if _data.gas_percent >= 95 && _data.gas_percent <= 100{
                level = 10
                rotateLevel(levelGas: self.level)
                img_Gas_Percent_10.isHidden = true
                img_Gas_Percent_20.isHidden = true
                img_Gas_Percent_30.isHidden = true
                img_Gas_Percent_40.isHidden = true
                img_Gas_Percent_50.isHidden = true
                img_Gas_Percent_60.isHidden = true
                img_Gas_Percent_70.isHidden = true
                img_Gas_Percent_80.isHidden = true
                img_Gas_Percent_90.isHidden = true
                self.viewForecast.bringSubview(toFront: img_Gas_Percent_100)
            }
        }
        else{
            showAlert(message: model.message)
        }
    }
}
//-- BUG0224-SPJ (KhoiVT 20180930) Gasservice - ForeCast Amount Gas
