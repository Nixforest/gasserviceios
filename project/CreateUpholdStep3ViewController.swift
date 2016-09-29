//
//  CreateUpholdStep3ViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class CreateUpholdStep3ViewController: UIViewController {
    
    static let sharedInstance: CreateUpholdStep3ViewController = {
        let instance = CreateUpholdStep3ViewController()
        return instance
    }()
    
    @IBOutlet weak var txtviewDescription: UITextView!
    
    @IBOutlet weak var viewInformation: UIView!
    
    @IBOutlet weak var lblProblem: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    
    @IBOutlet weak var lblProblemDetail: UILabel!
    @IBOutlet weak var lblContentDetail: UILabel!
    @IBOutlet weak var lblContactDetail: UILabel!
    
    @IBOutlet weak var btnSendInfo: UIButton!
    @IBAction func btnSendInfoTapped(_ sender: AnyObject) {
        print(CreateUpholdViewController.sharedInstance.problemType, CreateUpholdViewController.sharedInstance.contactType)
    }

    @IBOutlet weak var next3: UIButton!
    
    @IBAction func toNext3(_ sender: AnyObject) {
        CreateUpholdViewController.sharedInstance.isStep3Done = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "step3Done"), object: nil)
    }
    
    func showDetail(_ notification: Notification)  {
        lblProblemDetail.text = " " + CreateUpholdViewController.sharedInstance.problemType
        lblContactDetail.text = " " + CreateUpholdViewController.sharedInstance.contactType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Background
         */
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * description
         */
        txtviewDescription.translatesAutoresizingMaskIntoConstraints = true
        txtviewDescription.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.LABEL_HEIGHT * 2)
        txtviewDescription.text = "Bạn đang gửi thông tin sự cố như bên dưới cho chúng tôi, xin hãy kiểm tra lại thông tin một lần nữa và nhấn nút Gửi nếu bạn đồng ý"
        txtviewDescription.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        viewInformation.translatesAutoresizingMaskIntoConstraints = true
        viewInformation.backgroundColor = UIColor.white
        viewInformation.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        viewInformation.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        viewInformation.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        viewInformation.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH , y: GlobalConst.PARENT_BORDER_WIDTH + txtviewDescription.frame.size.height, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 4), height: GlobalConst.SCREEN_HEIGHT - ((GlobalConst.BUTTON_HEIGHT * 2) + (GlobalConst.PARENT_BORDER_WIDTH * 3) + txtviewDescription.frame.size.height + GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT))
        
        /**
         * information text
         */
        lblProblem.translatesAutoresizingMaskIntoConstraints = true
        lblProblem.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (viewInformation.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
        lblProblem.backgroundColor = UIColor.white
        lblProblem.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblProblem.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblProblem.text = " Sự cố"
        
        lblProblemDetail.translatesAutoresizingMaskIntoConstraints = true
        lblProblemDetail.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblProblem.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH , width: (viewInformation.frame.size.width - lblProblem.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
        lblProblemDetail.backgroundColor = UIColor.white
        lblProblemDetail.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblProblemDetail.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        

        /**
         *
         */
        lblContent.translatesAutoresizingMaskIntoConstraints = true
        lblContent.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT, width: (viewInformation.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
        lblContent.backgroundColor = UIColor.white
        lblContent.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContent.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblContent.text = " Nội dung"
        
        lblContentDetail.translatesAutoresizingMaskIntoConstraints = true
        lblContentDetail.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblProblem.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT, width: (viewInformation.frame.size.width - lblProblem.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
        lblContentDetail.backgroundColor = UIColor.white
        lblContentDetail.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContentDetail.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblContentDetail.text = ""

        /**
         *
         */
        lblContact.translatesAutoresizingMaskIntoConstraints = true
        lblContact.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 2), width: (viewInformation.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
        lblContact.backgroundColor = UIColor.white
        lblContact.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContact.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblContact.text = " Liên hệ"
        
        lblContactDetail.translatesAutoresizingMaskIntoConstraints = true
        lblContactDetail.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblProblem.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 2), width: (viewInformation.frame.size.width - lblProblem.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
        lblContactDetail.backgroundColor = UIColor.white
        lblContactDetail.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblContactDetail.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        
        /**
         * Button Send Info
         */
        btnSendInfo.translatesAutoresizingMaskIntoConstraints = true
        btnSendInfo.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT) , y: GlobalConst.PARENT_BORDER_WIDTH + txtviewDescription.frame.size.height + viewInformation.frame.size.height, width: GlobalConst.BUTTON_HEIGHT * 2, height: GlobalConst.BUTTON_HEIGHT)
        btnSendInfo.setTitle("Gửi", for: .normal)
        btnSendInfo.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnSendInfo.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        btnSendInfo.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        btnSendInfo.layer.borderColor = UIColor.green.cgColor
        btnSendInfo.tintColor = UIColor.white
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(CreateUpholdStep3ViewController.showDetail(_:)), name:NSNotification.Name(rawValue: "showDetail"), object: nil)
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
