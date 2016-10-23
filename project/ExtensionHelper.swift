//
//  ExtensionHelper.swift
//  project
//
//  Created by Nixforest on 10/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
/**
 * Download image async extension
 */
extension UIImageView {
    /**
     * Get image from url
     * - parameter link: Image url
     * - parameter mode: Image view content mode
     */
    func getImgFromUrl(link: String, contentMode mode: UIViewContentMode) {
        // Reset image
        self.image = nil // Here you can put nil to have a blank image or a placeholder image
        contentMode = mode
        let serverUrl: URL  = URL(string: link)!
        let request         = NSMutableURLRequest(url: serverUrl)
        request.httpMethod  = GlobalConst.HTTP_POST_REQUEST
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        // Execute task
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                let data = data , error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }).resume()
    }
}
/**
 * Draw border extension for layer
 */
extension CALayer {
    /**
     * Add border
     * - parameter egde:        Edge want to draw border
     * - parameter color:       Color of border
     * - parameter thickness:   Thickness of border
     */
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(
                x: 0,
                y: self.frame.height - thickness,
                width: UIScreen.main.bounds.width,
                height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(
                x: self.frame.width - thickness,
                y: 0,
                width: thickness,
                height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
    /**
     * Add border with gray color and thickness = 1
     * - parameter egde:        Edge want to draw border
     */
    func addBorder(edge: UIRectEdge) {
        addBorder(edge: edge, color: GlobalConst.BACKGROUND_COLOR_GRAY, thickness: 1)
    }
}
