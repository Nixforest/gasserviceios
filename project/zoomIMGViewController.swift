//
//  zoomIMGViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/31/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class zoomIMGViewController: CommonViewController, UIScrollViewDelegate {
    // ScrollView
    var scrollView = UIScrollView()
    //ImageView
    var imageView = UIImageView()
    //ButtonExit
    let btnExit = UIButton()
    //IMG Picked
    static var imgPicked:UIImage? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hide NavBar
        self.navigationController?.navigationBar.isHidden = true
        
        //ScrollView SetUp
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.frame = CGRect(x: 0, y: 0, width: 375, height: 584)
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
        imageView.backgroundColor = UIColor.black
        scrollView.addSubview(imageView)
        
        //BtnExit Setup
        btnExit.translatesAutoresizingMaskIntoConstraints = true
        btnExit.backgroundImage(for: .normal)
        let exit = UIImage(named: GlobalConst.DELETE_IMG_NAME)
        let tintedBack = exit?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        btnExit.setImage(tintedBack, for: UIControlState())
        btnExit.tintColor = GlobalConst.BUTTON_COLOR_RED
        btnExit.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        btnExit.setTitle("", for: UIControlState())
        btnExit.addTarget(self, action: #selector(btnExitTapped), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnExit)
        // Do any additional setup after loading the view.
    }
    func btnExitTapped() {
        zoomIMGViewController.imgPicked = nil
        _ = self.navigationController?.popViewController(animated: true)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
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
