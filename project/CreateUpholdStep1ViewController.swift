//
//  CreateUpholdStep1ViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class CreateUpholdStep1ViewController: UIViewController {
    
        

    @IBOutlet weak var lblChooseProblem: UILabel!
    
    @IBOutlet weak var btnProblem1: UIButton!
    @IBOutlet weak var btnProblem2: UIButton!
    @IBOutlet weak var btnProblem3: UIButton!
    @IBOutlet weak var btnProblem4: UIButton!
    @IBOutlet weak var btnProblem5: UIButton!
    @IBOutlet weak var btnProblem6: UIButton!
    
    
    @IBAction func toNext(_ sender: AnyObject) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
    }
    
    /**
     * problem 1 choosen
     */
    @IBAction func btnProblem1Tapped(_ sender: AnyObject) {
        G01F01VC.sharedInstance.problemType = (btnProblem1.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
        print(G01F01VC.sharedInstance.problemType)
    }
    /**
     * problem 2 choosen
     */
    @IBAction func btnProblem2Tapped(_ sender: AnyObject) {
        G01F01VC.sharedInstance.problemType = (btnProblem2.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
        print(G01F01VC.sharedInstance.problemType)
    }
    /**
     * problem 3 choosen
     */
    @IBAction func btnProblem3Tapped(_ sender: AnyObject) {
        G01F01VC.sharedInstance.problemType = (btnProblem3.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
        print(G01F01VC.sharedInstance.problemType)
    }
    /**
     * problem 4 choosen
     */
    @IBAction func btnProblem4Tapped(_ sender: AnyObject) {
        G01F01VC.sharedInstance.problemType = (btnProblem4.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
        print(G01F01VC.sharedInstance.problemType)
    }
    /**
     * problem 5 choosen
     */
    @IBAction func btnProblem5Tapped(_ sender: AnyObject) {
        G01F01VC.sharedInstance.problemType = (btnProblem5.titleLabel?.text)!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
        print(G01F01VC.sharedInstance.problemType)
    }
    /**
     * problem 6 choosen
     */
    @IBAction func btnProblem6Tapped(_ sender: AnyObject) {
        
        var inputTextField: UITextField?
        inputTextField?.placeholder = "Nội dung"
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Sự cố khác", message: "", preferredStyle: .alert)
        //Add a text field
        actionSheetController.addTextField { textField -> Void in
            // you can use this text field
            inputTextField = textField
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Huỷ", style: .cancel) { action -> Void in
                //Do some stuff
            }
            actionSheetController.addAction(cancelAction)
            //Create and an option action
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                G01F01VC.sharedInstance.anotherProblemType = (inputTextField?.text)!
                NotificationCenter.default.post(name: Notification.Name(rawValue: "step1Done"), object: nil)
                print(G01F01VC.sharedInstance.problemType)

            }
            actionSheetController.addAction(okAction)
            }
        
        self.present(actionSheetController, animated: true, completion: nil)

        
    }
    
    /**
     *
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label
         */
        lblChooseProblem.translatesAutoresizingMaskIntoConstraints = true
        lblChooseProblem.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.LABEL_HEIGHT)
        lblChooseProblem.text = "Xin vui lòng chọn loại sự cố"
        lblChooseProblem.textAlignment = NSTextAlignment.center
        lblChooseProblem.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY

        /**
         * Choose Problem Button 1
         */
        btnProblem1.translatesAutoresizingMaskIntoConstraints = true
        btnProblem1.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem1.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem1.layer.borderColor = UIColor.green.cgColor
        btnProblem1.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem1.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem1.setTitle("Xì gas", for: .normal)
        btnProblem1.setTitleColor(UIColor.white, for: .normal)
        /**
         * Choose Problem Button 2
         */
        btnProblem2.translatesAutoresizingMaskIntoConstraints = true
        btnProblem2.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + ((GlobalConst.BUTTON_HEIGHT * 2/3)), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem2.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem2.layer.borderColor = UIColor.green.cgColor
        btnProblem2.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem2.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem2.setTitle("Bảo trì bếp", for: .normal)
        btnProblem2.setTitleColor(UIColor.white, for: .normal)
        /**
         * Choose Problem Button 3
         */
        btnProblem3.translatesAutoresizingMaskIntoConstraints = true
        btnProblem3.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + ((GlobalConst.BUTTON_HEIGHT * 2/3) * 2), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
       // btnProblem3.layer.borderColor = UIColor.green.cgColor
        btnProblem3.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem3.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem3.setTitle("Kiểm tra hệ thống", for: .normal)
        btnProblem3.setTitleColor(UIColor.white, for: .normal)
        /**
         * Choose Problem Button 4
         */
        btnProblem4.translatesAutoresizingMaskIntoConstraints = true
        btnProblem4.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + ((GlobalConst.BUTTON_HEIGHT * 2/3) * 3), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem4.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem4.layer.borderColor = UIColor.green.cgColor
        btnProblem4.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem4.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem4.setTitle("Hư bếp", for: .normal)
        btnProblem4.setTitleColor(UIColor.white, for: .normal)
        /**
         * Choose Problem Button 5
         */
        btnProblem5.translatesAutoresizingMaskIntoConstraints = true
        btnProblem5.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + ((GlobalConst.BUTTON_HEIGHT * 2/3) * 4), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem5.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem5.layer.borderColor = UIColor.green.cgColor
        btnProblem5.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem5.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem5.setTitle("Đi lại đường ống", for: .normal)
        btnProblem5.setTitleColor(UIColor.white, for: .normal)
        /**
         * Choose Problem Button 6
         */
        btnProblem6.translatesAutoresizingMaskIntoConstraints = true
        btnProblem6.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT + ((GlobalConst.BUTTON_HEIGHT * 2/3) * 5), width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT * 2/3)
        //btnProblem6.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        //btnProblem6.layer.borderColor = UIColor.green.cgColor
        btnProblem6.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnProblem6.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnProblem6.setTitle("Khác", for: .normal)
        btnProblem6.setTitleColor(UIColor.white, for: .normal)
        
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
