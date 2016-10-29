//
//  StepContent.swift
//  project
//
//  Created by Nixforest on 10/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class StepContent: UIView {
    // MARK: Properties
    /** Step done delegate */
    var stepDoneDelegate: StepDoneDelegate?
    /** Title */
    var _lblTitle: UILabel          = UILabel()
    /** Scroll view */
    var _scrollView: UIScrollView   = UIScrollView()
    /** Main view */
    var _mainView: UIView?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: Methods
    /**
     * Default initializer.
     */
    init() {
        super.init(frame: UIScreen.main.bounds)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    /**
     * Setup layout for content view
     * - parameter mainView: Main view
     */
    func setup(mainView: UIView, title: String, contentHeight: CGFloat,
               width: CGFloat, height: CGFloat) {
        self.frame = CGRect(
            x: 0, y: 0,
            width: width, height: height)
        // Label title
        _lblTitle.translatesAutoresizingMaskIntoConstraints = true
        _lblTitle.frame = CGRect(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: GlobalConst.LABEL_HEIGHT)
        _lblTitle.text               = title
        _lblTitle.textAlignment      = NSTextAlignment.center
        _lblTitle.font               = UIFont.boldSystemFont(ofSize: 15.0)
        self.addSubview(_lblTitle)
        
        // Main view
        var mainViewHeight: CGFloat = 0
        if contentHeight < (self.frame.height - _lblTitle.frame.height) {
            mainViewHeight = self.frame.height - _lblTitle.frame.height
        } else {
            mainViewHeight = contentHeight
        }
        _mainView = mainView
        _mainView?.translatesAutoresizingMaskIntoConstraints = true
        _mainView?.frame = CGRect(
            x: 0, y: 0,
            width: self.frame.width,
            height: mainViewHeight)
        
        // Scrollview
        _scrollView.translatesAutoresizingMaskIntoConstraints = true
        _scrollView.frame = CGRect(
            x: 0,
            y: _lblTitle.frame.maxY,
            width: self.frame.width,
            height: self.frame.height - _lblTitle.frame.height)
        _scrollView.contentSize = CGSize(
            width: (_mainView?.frame.width)!,
            height: (_mainView?.frame.height)!)
        _scrollView.addSubview(_mainView!)
        
        self.addSubview(_scrollView)
    }
}
