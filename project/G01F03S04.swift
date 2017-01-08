//
//  G01F03S04.swift
//  project
//
//  Created by Nixforest on 11/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import harpyframework

class G01F03S04: StepSummary {
    // MARK: Properties
    /** Label Feeling */
    var lblFeeling: UILabel = UILabel()
    /** Status value */
    var tbxFeeling: UITextView = UITextView()
    /** List of selection */
    var _listRating = [RatingBar]()
    /** List of label */
    var _listLabel = [UILabel]()
    /** Label Time */
    var lblContent: UILabel = UILabel()
    /** Time value */
    var tbxContent: UITextView = UITextView()
    
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
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        // Update layout of content view
        let offset: CGFloat = updateLayout(w: w, h: h)
        // Set parent
        self._parent = parent
        
        contentView.addSubview(lblFeeling)
        contentView.addSubview(tbxFeeling)
        for item in self._listLabel {
            contentView.addSubview(item)
        }
        for item in self._listRating {
            contentView.addSubview(item)
        }
        contentView.addSubview(lblContent)
        contentView.addSubview(tbxContent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00209, contentHeight: offset,
                   width: w, height: h)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F03),
                                               object: nil)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData() {
        tbxFeeling.text = G01F03S01._selectedValue.name
        tbxContent.text = G01F03S03._selectedValue
        self.updateLayout()
        for i in 0..<G01F03S02._selectedValue.count {
            self._listRating[i]._rating = G01F03S02._selectedValue[i]
        }
    }
    func updateLayout() {
        lblContent.isHidden = G01F03S03._selectedValue.isEmpty
        tbxContent.isHidden = G01F03S03._selectedValue.isEmpty
    }
    func updateLayout(view: UIView, offset: CGFloat) {
        view.frame = CGRect(x: view.frame.origin.x, y: offset,
                            width: view.frame.width,
                            height: view.frame.height)
    }
    
    func updateLayout(w: CGFloat, h: CGFloat) -> CGFloat {
        var offset: CGFloat = 0
        
        // Add controls
        if BaseModel.shared.listRatingType.count > 0 {
            for i in 0..<BaseModel.shared.listRatingType.count {
                // Label title
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = true
                label.frame = CGRect(
                    x: GlobalConst.MARGIN_CELL_X,
                    y: offset,
                    width: self.frame.width,
                    height: GlobalConst.LABEL_HEIGHT)
                label.text               = BaseModel.shared.listRatingType[i].name
                //label.textAlignment      = NSTextAlignment.center
                label.font               = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
                self._listLabel.append(label)
                offset += GlobalConst.LABEL_HEIGHT
                
                // Rating bar
                let ratingBar = RatingBar()
                ratingBar.translatesAutoresizingMaskIntoConstraints = true
                let size = GlobalConst.LABEL_HEIGHT
                let width = size * (CGFloat)(ratingBar._starCount) + (ratingBar._spacing * (CGFloat)(ratingBar._starCount - 1))
                ratingBar.frame = CGRect(
                    x: (self.frame.width - width) / 2,
                    y: offset,
                    width: width,
                    height: size)
                //ratingBar.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
                ratingBar.setBackgroundColor(color: UIColor.white)
                ratingBar.setEnabled(isEnabled: true)
                ratingBar.isUserInteractionEnabled = false
                if G01F03S02._selectedValue.count > i {
                    ratingBar.setRatingValue(value: G01F03S02._selectedValue[i])
                }
                
                _listRating.append(ratingBar)
                offset += size
            }
        }
        
        // Label Feeling
        CommonProcess.setLayoutLeft(lbl: lblFeeling, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00210)
        lblFeeling.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Feeling value
        CommonProcess.setLayoutRight(lbl: tbxFeeling, x: lblFeeling.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT, text: G01F03S01._selectedValue.name)
        tbxFeeling.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Content
        CommonProcess.setLayoutLeft(lbl: lblContent, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT * 2, text: DomainConst.CONTENT00063)
        lblContent.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Content value
        CommonProcess.setLayoutRight(lbl: tbxContent, x: lblContent.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT * 2, text: G01F03S03._selectedValue)
        tbxContent.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT * 2
        
        lblContent.isHidden = G01F03S03._selectedValue.isEmpty
        tbxContent.isHidden = G01F03S03._selectedValue.isEmpty
        
        return offset
    }
}
