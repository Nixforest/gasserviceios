//
//  G01F03S02.swift
//  project
//
//  Created by Nixforest on 11/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class G01F03S02: StepContent {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: [Int] = [Int]()
    /** List of selection */
    var _listRating = [RatingBar]()
    
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
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = GlobalConst.MARGIN
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Add controls
        if BaseModel.shared.listRatingType.count > 0 {
            for i in 0..<BaseModel.shared.listRatingType.count {
                // Label title
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = true
                label.frame = CGRect(x: GlobalConst.MARGIN,
                                     y: offset,
                                     width: self.frame.width,
                                     height: GlobalConst.LABEL_HEIGHT)
                label.text               = BaseModel.shared.listRatingType[i].name
                label.font               = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
                contentView.addSubview(label)
                offset += GlobalConst.LABEL_HEIGHT
                
                // Rating bar
                let ratingBar = RatingBar()
                ratingBar.translatesAutoresizingMaskIntoConstraints = true
                let size = GlobalConst.LABEL_HEIGHT * 1.5
                let width = size * (CGFloat)(ratingBar.getStarNumber()) + (ratingBar.getStarSpace() * (CGFloat)(ratingBar.getStarNumber() - 1))
                ratingBar.frame = CGRect(x: (self.frame.width - width) / 2,
                                         y: offset,
                                         width: width,
                                         height: size)
                
                ratingBar.setBackgroundColor(color: GlobalConst.BACKGROUND_COLOR_GRAY)
                if G01F03S02._selectedValue.count > i {
                    ratingBar.setRatingValue(value: G01F03S02._selectedValue[i])
                } else {
                    G01F03S02._selectedValue.append(0)
                }
                
                
                _listRating.append(ratingBar)
                contentView.addSubview(ratingBar)
                offset += size
            }
        }
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00207,
                   contentHeight: offset,
                   width: w, height: h)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle validate data
     */
    override func checkDone() -> Bool {
        for i in 0..<BaseModel.shared.listRatingType.count {
            G01F03S02._selectedValue[i] = self._listRating[i].getRatingValue()
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F03), object: nil)
        if G01F03S02._selectedValue.count == 0 {
            self.showAlert(message: DomainConst.CONTENT00207)
            return false
        } else {
            return true
        }
    }
}
