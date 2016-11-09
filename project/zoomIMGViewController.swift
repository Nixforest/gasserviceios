//
//  zoomIMGViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class zoomIMGViewController: UIViewController, UIScrollViewDelegate {
    // MARK: Properties
    /** Navigation bar */
    @IBOutlet weak var infomationNavBar: UINavigationItem!
    /** Back button */
    @IBOutlet weak var backButton: UIButton!
    // ScrollView
    var scrollView = UIScrollView()
    //ImageView
    var imageView = UIImageView()
    //ButtonExit
//    let btnExit = UIButton()
    //IMG Picked
    static var imgPicked:UIImage? = nil
    
    // MARK: Actions
    /**
     * Handle back buton tapped
     * - parameter sender:AnyObject
     */
    @IBAction func backButtonTapped(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infomationNavBar.title = GlobalConst.CONTENT00212
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: GlobalConst.BUTTON_COLOR_RED]
        
        let backOrigin = UIImage(named: "back.png");
        let tintedBackLogo = backOrigin?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedBackLogo, for: UIControlState())
        backButton.tintColor = ColorFromRGB().getColorFromRGB(0xF00020)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.setTitle("", for: UIControlState())
        let backNavBar = UIBarButtonItem()
        backNavBar.customView = backButton
        infomationNavBar.setLeftBarButton(backNavBar, animated: false)
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        var offset: CGFloat = height + GlobalConst.MARGIN
        
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
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.frame = scrollView.frame
        imageView.image = zoomIMGViewController.imgPicked
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        scrollView.addSubview(imageView)
        
        //BtnExit Setup
//        btnExit.translatesAutoresizingMaskIntoConstraints = true
//        btnExit.backgroundImage(for: .normal)
//        let exit = UIImage(named: GlobalConst.DELETE_IMG_NAME)
//        let tintedBack = exit?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//        btnExit.setImage(tintedBack, for: UIControlState())
//        btnExit.tintColor = GlobalConst.BUTTON_COLOR_RED
//        btnExit.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
//        btnExit.setTitle("", for: UIControlState())
//        btnExit.addTarget(self, action: #selector(btnExitTapped), for: UIControlEvents.touchUpInside)
//        self.view.addSubview(btnExit)
        // Do any additional setup after loading the view.
    }
//    func btnExitTapped() {
//        zoomIMGViewController.imgPicked = nil
//        _ = self.navigationController?.popViewController(animated: true)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return self.imageView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
