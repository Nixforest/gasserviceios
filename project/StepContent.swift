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
    /** Title */
    var _lblTitle: UILabel           = UILabel()
    /** Scroll view */
    var _scrollView: UIScrollView    = UIScrollView()
    /** Main view */
    var _mainView: UIView?//            = UIView()

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
    func setup(mainView: UIView) {
        // Label title
        _lblTitle.translatesAutoresizingMaskIntoConstraints = true
        _lblTitle.frame = CGRect(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: GlobalConst.LABEL_HEIGHT)
        //_lblTitle.text               = GlobalConst.CONTENT00181
        _lblTitle.textAlignment      = NSTextAlignment.center
        _lblTitle.font               = UIFont.boldSystemFont(ofSize: 15.0)
        _lblTitle.backgroundColor    = GlobalConst.BACKGROUND_COLOR_GRAY
        self.addSubview(_lblTitle)
        
        // Main view
        _mainView = mainView
        _mainView?.translatesAutoresizingMaskIntoConstraints = true
        _mainView?.frame = CGRect(
            x: 0, y: 0,
            width: self.frame.width,
            height: 800)
        //self.addSubview(_mainView!)
        
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
        CommonProcess.setBorder(view: _scrollView)
        self.addSubview(_scrollView)
    }
}
