//
//  UpholdDetailEmployeeViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdDetailEmployeeViewController: CommonViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var txtvCustomerName: UITextView!
    @IBOutlet weak var lblBusinessEmployee: UILabel!
    @IBOutlet weak var lblUpholdEmployee: UILabel!
    @IBOutlet weak var txtvAddress: UITextView!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblProblem: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblCreator: UILabel!
    @IBOutlet weak var lblCreatedDate: UILabel!
    @IBOutlet weak var lblCode: UILabel!

    
    
    /**
     * Background setting
     */
    @IBOutlet weak var viewBackground: UIView!
    /**
     @IBOutlet weak var viewBackground: UIView!
     * Segment ScrollView Control
     */
    @IBOutlet weak var sgmScrollViewChange: UISegmentedControl!
    /**
     * Information ScrollView
     */
    @IBOutlet weak var scrViewInformation: UIScrollView!

    @IBOutlet var viewInformation: UIView!
    /**
     * Uphold History TableView
     */
    @IBOutlet weak var tblViewHistory: UITableView!
    @IBOutlet weak var btnCreateReply: UIButton!
    
    /**
     * Segment ScrollView Control Action
     */
    @IBAction func sgmScrollViewChangeAction(_ sender: AnyObject) {
        switch sgmScrollViewChange.selectedSegmentIndex
        {
            case 0:
                
                tblViewHistory.isHidden = true
                scrViewInformation.isHidden = false
                btnCreateReply.isHidden = true
            case 1:
                
                scrViewInformation.isHidden = true
                tblViewHistory.isHidden = false
                btnCreateReply.isHidden = false
        default:
            break
        }

    }
    @IBAction func btnCreateUpholdReplyTapped(_ sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: "ReplyUpholdViewController")
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBackground.translatesAutoresizingMaskIntoConstraints = true
        viewBackground.frame = CGRect(x: 0, y: GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT))
        viewBackground.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        viewBackground.backgroundColor = UIColor.white
        
        sgmScrollViewChange.translatesAutoresizingMaskIntoConstraints = true
        sgmScrollViewChange.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.BUTTON_HEIGHT)
        sgmScrollViewChange.setTitle(GlobalConst.CONTENT00072, forSegmentAt: 0)
        sgmScrollViewChange.setTitle(GlobalConst.CONTENT00071, forSegmentAt: 1)
        sgmScrollViewChange.tintColor = GlobalConst.BUTTON_COLOR_RED
        
        //viewBackground.addSubview(sgmScrollViewChange)
        
        scrViewInformation.translatesAutoresizingMaskIntoConstraints = true
        scrViewInformation.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.BUTTON_HEIGHT , width: (GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.BUTTON_HEIGHT))
        
        scrViewInformation.delegate = self
        
        Bundle.main.loadNibNamed("UpholdDetailEmployeeInfoView", owner: self, options: nil)
                scrViewInformation.addSubview(viewInformation)
        //viewBackground.addSubview(scrViewInformation)

        btnCreateReply.translatesAutoresizingMaskIntoConstraints = true
        btnCreateReply.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH * 2, y: GlobalConst.PARENT_BORDER_WIDTH * 2 + GlobalConst.BUTTON_HEIGHT, width: (GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4), height: GlobalConst.BUTTON_HEIGHT - GlobalConst.PARENT_BORDER_WIDTH * 2)
        btnCreateReply.isHidden = true
        btnCreateReply.setTitle(GlobalConst.CONTENT00065, for: .normal)
        btnCreateReply.setTitleColor(UIColor.white, for: .normal)
        btnCreateReply.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnCreateReply.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        
        tblViewHistory.translatesAutoresizingMaskIntoConstraints = true
        tblViewHistory.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.BUTTON_HEIGHT + GlobalConst.BUTTON_HEIGHT, width: (GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.BUTTON_HEIGHT * 2))
        tblViewHistory.isHidden = true
        
        self.tblViewHistory.register(UINib(nibName: "UpholdDetailEmployeeHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "UpholdDetailEmployeeHistoryTableViewCell")
        tblViewHistory.dataSource = self
        tblViewHistory.delegate = self
        
        //viewBackground.addSubview(scrViewUpholdHistory)

        
        
        // Do any additional setup after loading the view.
    }
    
    

    override func viewDidLayoutSubviews() {
        viewInformation.frame = CGRect(x: 0, y: 0, width: scrViewInformation.frame.size.width, height: scrViewInformation.frame.size.height)
        scrViewInformation.contentSize = CGSize(width: viewInformation.frame.size.width, height: viewInformation.frame.size.height)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let count:Int = 5
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
                let cell:UpholdDetailEmployeeHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UpholdDetailEmployeeHistoryTableViewCell") as! UpholdDetailEmployeeHistoryTableViewCell
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height:CGFloat = 300
        return height
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
