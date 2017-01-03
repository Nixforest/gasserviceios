//
//  RatingBar.swift
//  project
//
//  Created by Nixforest on 11/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class RatingBar: UIView {
    // MARK: Properties
    /** Spacing */
    let _spacing: CGFloat = 5
    /** Number of stars */
    var _starCount: Int = 5
    /** Width */
    var _width: CGFloat = 0
    /** Rating value */
    var _rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    /** Rating buttons */
    var _ratingButtons: [UIButton] = [UIButton]()
    
    // MARK: Initialization
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.addContent()
        return
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func addContent() {
        let filledStarImg = UIImage(named: DomainConst.RATING_IMG_NAME)
        let emptyStarImg = UIImage(named: DomainConst.RATING_EMPTY_IMG_NAME)
        
        // Create button
        for _ in 0..<self._starCount {
            let tintedFilled = filledStarImg?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            let tintedEmpty = emptyStarImg?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            button.translatesAutoresizingMaskIntoConstraints = true
            button.setImage(tintedEmpty, for: .normal)
            button.setImage(tintedFilled, for: .selected)
            button.setImage(tintedFilled, for: [.highlighted, .selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: #selector(RatingBar.ratingButtonTapped),
                             for: .touchDown)
            button.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
            button.tintColor = GlobalConst.BUTTON_COLOR_RED
            self._ratingButtons.append(button)
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        let buttonSize = CGFloat(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0,
                                 width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the buttn plus spacing
        for (index, button) in self._ratingButtons.enumerated() {
            buttonFrame.origin.x = (CGFloat)(index) * (buttonSize + self._spacing)
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override public var intrinsicContentSize: CGSize {
        let buttonSize = CGFloat(frame.size.height)
        let width = (buttonSize * (CGFloat)(self._starCount)) + (self._spacing * (CGFloat)(self._starCount - 1))
        _width = width
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button actions
    func ratingButtonTapped(button: UIButton) {
        self._rating = self._ratingButtons.index(of: button)! + 1
        updateButtonSelectionStates()
    }
    func setRatingValue(value: Int) {
        self._rating = value
        updateButtonSelectionStates()
    }
    func updateButtonSelectionStates() {
        for (index, button) in self._ratingButtons.enumerated() {
            // If index of a button is less than the rating, that button should be selected
            button.isSelected = index < self._rating
        }
    }
    
    func setBackgroundColor(color: UIColor) {
        for button in self._ratingButtons {
            button.backgroundColor = color
        }
        self.backgroundColor = color
    }
    
    func setEnabled(isEnabled: Bool) {
        for button in self._ratingButtons {
            button.isEnabled = isEnabled
        }
    }
}
