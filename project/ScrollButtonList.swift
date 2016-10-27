//
//  ScrollButtonList.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ScrollButtonList: UIScrollView {
    // MARK: Properties
    /** Scroll view */
    //var _scrollView = UIScrollView()
    /** Number of buttons */
    var _numberOfBtn = 0
    /** List buttons */
    var _arrayBtn = [UIButton]()
    /** List status */
    var _arrayStatus = [Bool]()
    /** Button tapped handler */
    var btnTapped: ((AnyObject) -> ())?
    /** Current active */
    var _currentActive = -1

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init() {
        super.init(frame: UIScreen.main.bounds);
        
        //for debug validation
        self.backgroundColor = UIColor.blue;
        print("My Custom Init");
        return;
    }
    func setup(height: CGFloat) {
        // List buttons
        for i in 0..._numberOfBtn {
            _arrayStatus.append(false)
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = true
            button.frame = CGRect(
                x: (self.frame.width - GlobalConst.SCROLL_BUTTON_LIST_HEIGHT) / 2 + (CGFloat)(i) * GlobalConst.SCROLL_BUTTON_LIST_HEIGHT,
                y: 0 - height,
                width: GlobalConst.SCROLL_BUTTON_LIST_HEIGHT,
                height: GlobalConst.SCROLL_BUTTON_LIST_HEIGHT)
            button.tag = i
            button.layer.cornerRadius = 0.5 * GlobalConst.SCROLL_BUTTON_LIST_HEIGHT
            button.setTitle(String(i + 1), for: .normal)
            button.setTitleColor(UIColor.white , for: .normal)
            button.backgroundColor = GlobalConst.SCROLLBUTTONLIST_BTN_BKG_COLOR_DISABLE
            button.addTarget(self, action: #selector(getter: btnTapped), for: .touchUpInside)
            button.isEnabled = false
            //_scrollView.addSubview(button)
            self.addSubview(button)
            _arrayBtn.append(button)
        }
        // Scroll view
//        _scrollView.translatesAutoresizingMaskIntoConstraints = true
//        _scrollView.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: self.frame.width,
//            height: self.frame.height)
//        _scrollView.contentSize = CGSize(
//            width: self.frame.width + (CGFloat)(self._numberOfBtn - 1) * GlobalConst.SCROLL_BUTTON_LIST_HEIGHT,
//            height: self.frame.height)
//        //_scrollView.backgroundColor = GlobalConst.SCROLLBUTTONLIST_BKG_COLOR
//        _scrollView.backgroundColor = UIColor.red
//        self.addSubview(_scrollView)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.contentSize = CGSize(
            width: self.frame.width + (CGFloat)(self._numberOfBtn - 1) * GlobalConst.SCROLL_BUTTON_LIST_HEIGHT,
            height: self.frame.height)
        self.backgroundColor = GlobalConst.SCROLLBUTTONLIST_BKG_COLOR
        //self.isScrollEnabled
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    func moveTo(current: Int) {
        if current < _numberOfBtn && current >= 0 {
            self._currentActive = current
            update()
        }
    }
    func moveNext() {
        if _currentActive == -1 {
            _currentActive += 1
            if _numberOfBtn > 0 {
                _arrayBtn[_currentActive].backgroundColor = GlobalConst.SCROLLBUTTONLIST_BTN_BKG_COLOR_SELECTING
            }
        } else if _currentActive < (_numberOfBtn - 1) {
            // Move next
            _currentActive += 1
            update(isMoveNext: true)
        }
    }
    func moveBack() {
        if _currentActive > 0 {
            // Move back
            _currentActive -= 1
            update()
        }
    }
    func update(isMoveNext: Bool = false) {
        if isMoveNext {
            _arrayStatus[_currentActive - 1] = true
            _arrayBtn[_currentActive - 1].backgroundColor = GlobalConst.SCROLLBUTTONLIST_BTN_BKG_COLOR_ENABLE
            _arrayBtn[_currentActive - 1].isEnabled = true
        } else {
            _arrayBtn[_currentActive].backgroundColor = GlobalConst.SCROLLBUTTONLIST_BTN_BKG_COLOR_SELECTING
        }
        self.scrollRectToVisible(CGRect(x: GlobalConst.SCROLL_BUTTON_LIST_HEIGHT * (CGFloat)(_currentActive), y: 0 - self.frame.height, width: self.frame.width, height: self.frame.height),
                                        animated: true)
    }
}
