//
//  CreateUpholdStep3ViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

//class G01F01S03VC: UIViewController {
//    
//    static let sharedInstance: G01F01S03VC = {
//        let instance = G01F01S03VC()
//        return instance
//    }()
//    
//    @IBOutlet weak var txtviewDescription: UITextView!
//    
//    @IBOutlet weak var viewInformation: UIView!
//    
//    @IBOutlet weak var lblProblem: UILabel!
//    @IBOutlet weak var lblContent: UILabel!
//    @IBOutlet weak var lblContact: UILabel!
//    
//    @IBOutlet weak var lblProblemDetail: UILabel!
//    @IBOutlet weak var lblContentDetail: UILabel!
//    @IBOutlet weak var lblContactDetail: UILabel!
//    
//    @IBOutlet weak var btnSendInfo: UIButton!
//    @IBAction func btnSendInfoTapped(_ sender: AnyObject) {
//        print(G01F01VC.sharedInstance.problemType, G01F01VC.sharedInstance.contactType)
//    }
//
//    @IBOutlet weak var next3: UIButton!
//    
//    @IBAction func toNext3(_ sender: AnyObject) {
//        G01F01VC.sharedInstance.isStep3Done = true
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "step3Done"), object: nil)
//    }
//    
//    func showDetail(_ notification: Notification)  {
//        lblProblemDetail.text = " " + G01F01VC.sharedInstance.problemType
//        lblContentDetail.text = " " + G01F01VC.sharedInstance.anotherProblemType
//        lblContactDetail.text = " " + G01F01VC.sharedInstance.contactType
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        /**
//         * Background
//         */
//        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
//        /**
//         * description
//         */
//        txtviewDescription.translatesAutoresizingMaskIntoConstraints = true
//        txtviewDescription.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.LABEL_HEIGHT * 2)
//        txtviewDescription.text = "Bạn đang gửi thông tin sự cố như bên dưới cho chúng tôi, xin hãy kiểm tra lại thông tin một lần nữa và nhấn nút Gửi nếu bạn đồng ý"
//        txtviewDescription.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
//        
//        viewInformation.translatesAutoresizingMaskIntoConstraints = true
//        viewInformation.backgroundColor = UIColor.white
//        viewInformation.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        viewInformation.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
//        viewInformation.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
//        viewInformation.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH , y: GlobalConst.PARENT_BORDER_WIDTH + txtviewDescription.frame.size.height, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 4), height: GlobalConst.SCREEN_HEIGHT - ((GlobalConst.BUTTON_HEIGHT * 2) + (GlobalConst.PARENT_BORDER_WIDTH * 3) + txtviewDescription.frame.size.height + GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT))
//        
//        /**
//         * information text
//         */
//        lblProblem.translatesAutoresizingMaskIntoConstraints = true
//        lblProblem.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (viewInformation.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
//        lblProblem.backgroundColor = UIColor.white
//        lblProblem.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        lblProblem.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//        lblProblem.text = " Sự cố"
//        
//        lblProblemDetail.translatesAutoresizingMaskIntoConstraints = true
//        lblProblemDetail.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblProblem.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH , width: (viewInformation.frame.size.width - lblProblem.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
//        lblProblemDetail.backgroundColor = UIColor.white
//        lblProblemDetail.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        lblProblemDetail.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//        
//        
//
//        /**
//         *
//         */
//        lblContent.translatesAutoresizingMaskIntoConstraints = true
//        lblContent.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT, width: (viewInformation.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
//        lblContent.backgroundColor = UIColor.white
//        lblContent.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        lblContent.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//        lblContent.text = " Nội dung"
//        
//        lblContentDetail.translatesAutoresizingMaskIntoConstraints = true
//        lblContentDetail.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblProblem.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT, width: (viewInformation.frame.size.width - lblProblem.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
//        lblContentDetail.backgroundColor = UIColor.white
//        lblContentDetail.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        lblContentDetail.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//        lblContentDetail.text = ""
//
//        /**
//         *
//         */
//        lblContact.translatesAutoresizingMaskIntoConstraints = true
//        lblContact.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 2), width: (viewInformation.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
//        lblContact.backgroundColor = UIColor.white
//        lblContact.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        lblContact.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//        lblContact.text = " Liên hệ"
//        
//        lblContactDetail.translatesAutoresizingMaskIntoConstraints = true
//        lblContactDetail.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblProblem.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 2), width: (viewInformation.frame.size.width - lblProblem.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
//        lblContactDetail.backgroundColor = UIColor.white
//        lblContactDetail.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        lblContactDetail.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
//        
//        
//        /**
//         * Button Send Info
//         */
//        btnSendInfo.translatesAutoresizingMaskIntoConstraints = true
//        btnSendInfo.frame = CGRect(x: (GlobalConst.SCREEN_WIDTH / 2) - (GlobalConst.BUTTON_HEIGHT) , y: GlobalConst.PARENT_BORDER_WIDTH + txtviewDescription.frame.size.height + viewInformation.frame.size.height, width: GlobalConst.BUTTON_HEIGHT * 2, height: GlobalConst.BUTTON_HEIGHT)
//        btnSendInfo.setTitle("Gửi", for: .normal)
//        btnSendInfo.backgroundColor = GlobalConst.BUTTON_COLOR_RED
//        btnSendInfo.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
//        //btnSendInfo.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
//        //btnSendInfo.layer.borderColor = UIColor.green.cgColor
//        btnSendInfo.tintColor = UIColor.white
//        
//        // Do any additional setup after loading the view.
//        NotificationCenter.default.addObserver(self, selector: #selector(G01F01S03VC.showDetail(_:)), name:NSNotification.Name(rawValue: "showDetail"), object: nil)
//    }
//    
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
class G01F01S03: StepSummary {
    // MARK: Properties
    /** Label status */
    var lblProblem: UILabel = UILabel()
    /** Status value */
    var tbxProblem: UITextView = UITextView()
    /** Label Time */
    var lblContent: UILabel = UILabel()
    /** Time value */
    var tbxContent: UITextView = UITextView()
    /** Label Reviewer */
    var lblContact: UILabel = UILabel()
    /** Reviewer value */
    var tbxContact: UITextView = UITextView()
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    /**
     * Default initializer.
     */
    init(w: CGFloat, h: CGFloat, parent: CommonViewController) {
        super.init()
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        // Update layout of content view
        let offset: CGFloat = updateLayout(w: w, h: h)
        // Set parent
        self._parent = parent
        
        contentView.addSubview(lblProblem)
        contentView.addSubview(tbxProblem)
        contentView.addSubview(lblContent)
        contentView.addSubview(tbxContent)
        contentView.addSubview(lblContact)
        contentView.addSubview(tbxContact)
        
        self.setup(mainView: contentView, title: GlobalConst.CONTENT00205, contentHeight: offset,
                   width: w, height: h)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_G01F01),
                                               object: nil)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData() {
        tbxProblem.text = G01F01S01._selectedValue.name
        tbxContent.text = G01F01S01._otherProblem
        tbxContact.text = G01F01S02._name + "\n" + G01F01S02._phone
        var offset: CGFloat = GlobalConst.LABEL_HEIGHT
        lblContent.isHidden = true
        tbxContent.isHidden = true
        if G01F01S01._selectedValue.name == DomainConst.OPTION_OTHER {
            lblContent.isHidden = false
            tbxContent.isHidden = false
            offset += GlobalConst.LABEL_HEIGHT
        }
        updateLayout(view: lblContact, offset: offset)
        updateLayout(view: tbxContact, offset: offset)
        offset += GlobalConst.LABEL_HEIGHT * 1.5
        self.updateLayout(contentHeight: offset)
    }
    
    func updateLayout(view: UIView, offset: CGFloat) {
        view.frame = CGRect(x: view.frame.origin.x, y: offset,
                            width: view.frame.width,
                            height: view.frame.height)
    }
    
    func updateLayout(w: CGFloat, h: CGFloat) -> CGFloat {
        var offset: CGFloat = 0
        
        // Label Problem
        CommonProcess.setLayoutLeft(lbl: lblProblem, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00147)
        lblProblem.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Problem value
        CommonProcess.setLayoutRight(lbl: tbxProblem, x: lblProblem.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT, text: G01F01S01._selectedValue.name)
        tbxProblem.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Content
        CommonProcess.setLayoutLeft(lbl: lblContent, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT, text: GlobalConst.CONTENT00063)
        lblContent.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Content value
        CommonProcess.setLayoutRight(lbl: tbxContent, x: lblContent.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT, text: G01F01S01._otherProblem)
        tbxContent.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Contact
        CommonProcess.setLayoutLeft(lbl: lblContact, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT * 1.5, text: GlobalConst.CONTENT00146)
        lblContact.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Contact value
        CommonProcess.setLayoutRight(lbl: tbxContact, x: lblContact.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT * 1.5,
                                     text: G01F02S04._selectedValue.name + "\n" + G01F02S04._selectedValue.phone)
        tbxContact.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT * 1.5
        
        return offset
    }
}
