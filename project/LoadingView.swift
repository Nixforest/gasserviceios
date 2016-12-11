//
//  LoadingView.swift
//  project
//
//  Created by Nixforest on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
public class LoadingView{
    /** Overlay view */
    var overlayView = UIView()
    /** Activity indicator */
    var activityIndicator = UIActivityIndicatorView()
    /** Instance */
    class var shared: LoadingView {
        struct Static {
            static let instance: LoadingView = LoadingView()
        }
        return Static.instance
    }
    
    /**
     * Show overlay view
     * - parameter view: Parent view
     */
    public func showOverlay(view: UIView) {
        // Create overlay vew
        overlayView.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor(white: 0x444444, alpha: 0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        // Create indicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        // Add indicator into overlay view
        overlayView.addSubview(activityIndicator)
        
        // Add overlay view to main view (cross-thread)
        DispatchQueue.main.async {
            view.addSubview(self.overlayView)
        }
        //view.addSubview(overlayView)
        // Run animating
        activityIndicator.startAnimating()
    }
    
    /**
     * Show overlay view
     */
    public func showOverlay() {
        var currentView: UIViewController? = nil
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            currentView = navigationController.visibleViewController
            // Create overlay vew
            overlayView.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT)
            overlayView.center = (currentView?.view.center)!
            overlayView.backgroundColor = UIColor(white: 0x444444, alpha: 0.7)
            overlayView.clipsToBounds = true
            overlayView.layer.cornerRadius = 10
            
            // Create indicator
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.activityIndicatorViewStyle = .whiteLarge
            activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
            
            // Add indicator into overlay view
            overlayView.addSubview(activityIndicator)
            
            // Add overlay view to main view (cross-thread)
            DispatchQueue.main.async {
                currentView?.view.addSubview(self.overlayView)
            }
            //view.addSubview(overlayView)
            // Run animating
            activityIndicator.startAnimating()
        }
    }
    
    /**
     * Hide overlay view
     */
    public func hideOverlayView() {
        // Stop animating
        activityIndicator.stopAnimating()
        
        // Remove overlay view from main view (cross-thread)
        DispatchQueue.main.async {
            self.overlayView.removeFromSuperview()
        }
        //overlayView.removeFromSuperview()
    }
}
