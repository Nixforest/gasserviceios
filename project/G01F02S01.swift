//
//  G01F02S01VC.swift
//  project
//
//  Created by Nixforest on 10/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class G01F02S01: StepContent {
    /** Selected value */
    var _selectedValue: ConfigBean = ConfigBean()
    // MARK: Properties
    var _listButton = [UIButton]

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
    /**
     * Default initializer.
     */
    init(w: Int, h: Int) {
        super.init()
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.backgroundColor = UIColor.brown
        if Singleton.sharedInstance.listUpholdType.count > 0 {
            for i in 0..<Singleton.sharedInstance.listUpholdType.count {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = true
                button.frame = CGRect(
                    x: (w - GlobalConst.BUTTON_W) / 2,
                    y: i * GlobalConst.BUTTON_H,
                    width: GlobalConst.BUTTON_W,
                    height: GlobalConst.BUTTON_H)
                button.tag = i
                button.setTitle(Singleton.sharedInstance.listUpholdType[i].name, for: .normal)
                button.setTitleColor(UIColor.white , for: .normal)
                button.backgroundColor = GlobalConst.BUTTON_COLOR_RED
                button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
                button.layer.cornerRadius = GlobalConst.LOGIN_BUTTON_CORNER_RADIUS
                _listButton.append(button)
                contentView.addSubview(buton)
            }
        }
        self.setup(mainView: contentView)
        return
    }
    func btnTapped(_ sender: AnyObject) {
        self._selectedValue = Singleton.sharedInstance.listUpholdType[sender.tag]
    }
}
