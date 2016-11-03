//
//  G01F03S02.swift
//  project
//
//  Created by Nixforest on 11/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class G01F03S02: StepContent {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: [Double] = [Double]()
    /** List of selection */
    var _listRating = [CosmosView]()
    /** List of label */
    var _listLabel = [UILabel]()
    
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
    init(w: CGFloat, h: CGFloat, parent: CommonViewController) {
        super.init()
        var offset: CGFloat = GlobalConst.MARGIN
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Add controls
        if Singleton.sharedInstance.listRatingType.count > 0 {
            for i in 0..<Singleton.sharedInstance.listRatingType.count {
                // Label title
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = true
                label.frame = CGRect(
                    x: 0,
                    y: offset,
                    width: self.frame.width,
                    height: GlobalConst.LABEL_HEIGHT)
                label.text               = Singleton.sharedInstance.listRatingType[i].name
                label.textAlignment      = NSTextAlignment.center
                label.font               = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
                contentView.addSubview(label)
                offset += GlobalConst.LABEL_HEIGHT
                
                // Rating bar
                let ratingBar = CosmosView()
                ratingBar.translatesAutoresizingMaskIntoConstraints = true
                ratingBar.frame = CGRect(
                    x: 0,
                    y: offset,
                    width: self.frame.width,
                    height: GlobalConst.LABEL_HEIGHT * 2)
                ratingBar.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
                if G01F03S02._selectedValue.count > (i + 1) {
                    ratingBar.rating = G01F03S02._selectedValue[i]
                } else {
                    ratingBar.rating = 0.0
                }
                
                _listRating.append(ratingBar)
                contentView.addSubview(ratingBar)
                offset += GlobalConst.LABEL_HEIGHT
                G01F03S02._selectedValue.append(0.0)
            }
        }
        // Set parent
        self._parent = parent
        
        self.setup(mainView: contentView, title: GlobalConst.CONTENT00207,
                   contentHeight: offset,
                   width: w, height: h)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if Singleton.sharedInstance.listRatingType.count > 0 {
            for i in 0..<Singleton.sharedInstance.listRatingType.count {
                G01F03S02._selectedValue[i] = self._listRating[i].rating
            }
        }
    }
    
    override func checkDone() -> Bool {
        if G01F03S02._selectedValue.count == 0 {
            self._parent?.showAlert(message: GlobalConst.CONTENT00207)
            return false
        } else {
            return true
        }
    }
}
