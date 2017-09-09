//
//  zoomIMGViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class zoomIMGViewController: UIViewController, UIScrollViewDelegate {
    // MARK: Properties
    /** Navigation bar */
    @IBOutlet weak var infomationNavBar: UINavigationItem!
    /** Back button */
    @IBOutlet weak var backButton: UIButton!
    /** ScrollView */
    var scrollView = UIScrollView()
    /** ImageView */
    static var imageView = UIImageView()
    /** IMG Picked */
    static var imgPicked: UIImage? = nil
    
    // MARK: Actions
    /**
     * Handle back buton tapped
     * - parameter sender:AnyObject
     */
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /**
     * View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infomationNavBar.title = DomainConst.CONTENT00212
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: GlobalConst.BUTTON_COLOR_RED]
        
        let backOrigin = ImageManager.getImage(named: DomainConst.BACK_IMG_NAME);
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBackLogo, for: UIControlState())
        backButton.tintColor = GlobalConst.BUTTON_COLOR_RED
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.setTitle("", for: UIControlState())
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        infomationNavBar.setLeftBarButton(backNavBar, animated: false)
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        
        //ScrollView SetUp
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.frame = CGRect(x: 0, y: 0,
                                  width: GlobalConst.SCREEN_WIDTH,
                                  height: GlobalConst.SCREEN_HEIGHT - height)
        scrollView.delegate = self
        scrollView.bouncesZoom = true
        scrollView.bounces = true
        self.view.addSubview(scrollView)
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0

        //ImageView SetUp
        zoomIMGViewController.imageView.translatesAutoresizingMaskIntoConstraints = true
        zoomIMGViewController.imageView.frame = scrollView.frame
        zoomIMGViewController.imageView.image = zoomIMGViewController.imgPicked
        zoomIMGViewController.imageView.contentMode = .scaleAspectFit
        zoomIMGViewController.imageView.backgroundColor = UIColor.white
        scrollView.addSubview(zoomIMGViewController.imageView)
        
        // Do any additional setup after loading the view.
        // Show loading view
        if zoomIMGViewController.imageView.image == nil {
//            LoadingView.shared.showOverlay()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return zoomIMGViewController.imageView
    }
    
    public static func setPickedImg(img: UIImage) {
        zoomIMGViewController.imgPicked = img
    }
}
