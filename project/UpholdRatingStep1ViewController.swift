//
//  UpholdRatingStep1ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdRatingStep1ViewController: UIViewController {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblRating0: UILabel!
    @IBOutlet weak var lblRating1: UILabel!
    
    //@IBOutlet weak var ratingControl0: RatingControl!
    @IBOutlet weak var viewRating0: CosmosView!
    @IBOutlet weak var viewRating1: CosmosView!

    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initiate value
        viewRating0.rating = 0
        viewRating1.rating = 0
        // background
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label header
         */
        lblHeader.translatesAutoresizingMaskIntoConstraints = true
        lblHeader.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH , y: GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4, height: GlobalConst.LABEL_HEIGHT)
        lblHeader.text = "Đánh giá nhân viên bảo trì"
        lblHeader.textAlignment = NSTextAlignment.center
        lblHeader.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        lblHeader.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        lblHeader.textColor = UIColor.white
        /**
         * Label rating 0
         */
        lblRating0.translatesAutoresizingMaskIntoConstraints = true
        lblRating0.frame = CGRect(x: 0, y: lblHeader.frame.maxY * 2, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2, height: GlobalConst.LABEL_HEIGHT)
        lblRating0.text = "Thái độ tác phong nhân viên"
        lblRating0.textAlignment = NSTextAlignment.center
        /**
         * view Rating 0
         */
        viewRating0.translatesAutoresizingMaskIntoConstraints = true
        viewRating0.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (viewRating0.frame.size.width / 2), y: lblRating0.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH, width: 40 * 5.5, height: 40)
        viewRating0.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * label rating 1
         */
        lblRating1.translatesAutoresizingMaskIntoConstraints = true
        lblRating1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: viewRating0.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH, width: lblRating0.frame.size.width, height: GlobalConst.LABEL_HEIGHT)
        lblRating1.text = "Đánh giá nhân viên bảo trì"
        lblRating1.textAlignment = NSTextAlignment.center
        /**
         * view rating 1
         */
        viewRating1.translatesAutoresizingMaskIntoConstraints = true
        viewRating1.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (viewRating1.frame.size.width / 2), y: lblRating1.frame.maxY + GlobalConst.PARENT_BORDER_WIDTH, width: 40 * 5.5, height: 40)
        viewRating1.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UpholdRatingViewController.valStep1Rating0 = String(viewRating0.rating)
        UpholdRatingViewController.valStep1Rating1 = String(viewRating1.rating)
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
