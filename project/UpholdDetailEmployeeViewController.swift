//
//  UpholdDetailEmployeeViewController.swift
//  project
//
//  Created by Lâm Phạm on 9/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpholdDetailEmployeeViewController: CommonViewController, UIPopoverPresentationControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    /** Segment ScrollView Control */
    @IBOutlet weak var sgmScrollViewChange: UISegmentedControl!
    /** Information ScrollView */
    @IBOutlet weak var scrViewInformation: UIScrollView!
    /** View informatino */
    @IBOutlet var viewInformation: UpholdDetailEmployeeInfoView!
    /** Uphold History TableView */
    @IBOutlet weak var tblViewHistory: UITableView!
    /** Create reply button */
    @IBOutlet weak var btnCreateReply: UIButton!
    
    // MARK: Actions
    /**
     * Segment ScrollView Control Action
     */
    @IBAction func sgmScrollViewChangeAction(_ sender: AnyObject) {
        switch sgmScrollViewChange.selectedSegmentIndex {
        case 0:     // Information tab
            tblViewHistory.isHidden     = true
            scrViewInformation.isHidden = false
            btnCreateReply.isHidden     = true
            
        case 1:     // History tab
            scrViewInformation.isHidden = true
            tblViewHistory.isHidden     = false
            btnCreateReply.isHidden     = false
        default:
            break
        }

    }
    
    /**
     * Handle tap create uphold reply button.
     */
    @IBAction func btnCreateUpholdReplyTapped(_ sender: AnyObject) {
        let configVC = mainStoryboard.instantiateViewController(withIdentifier: GlobalConst.REPLY_UPHOLD_VIEW_CTRL)
        self.navigationController?.pushViewController(configVC, animated: true)
    }
    
    /**
     * View did load.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab button
        let marginX = GlobalConst.PARENT_BORDER_WIDTH
        let height = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        sgmScrollViewChange.translatesAutoresizingMaskIntoConstraints = true
        sgmScrollViewChange.frame = CGRect(x: marginX, y: height,
            width: GlobalConst.SCREEN_WIDTH - marginX * 2,
            height: GlobalConst.BUTTON_H)
        sgmScrollViewChange.setTitle(GlobalConst.CONTENT00072, forSegmentAt: 0)
        sgmScrollViewChange.setTitle(GlobalConst.CONTENT00071, forSegmentAt: 1)
        sgmScrollViewChange.tintColor = GlobalConst.BUTTON_COLOR_RED
        
        //viewBackground.addSubview(sgmScrollViewChange)
        
        scrViewInformation.translatesAutoresizingMaskIntoConstraints = true
        scrViewInformation.frame = CGRect(
            x: marginX,
            y: sgmScrollViewChange.frame.maxY,
            width: GlobalConst.SCREEN_WIDTH - marginX * 2,
            height: GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.BUTTON_HEIGHT))
        
        scrViewInformation.delegate = self
        
        Bundle.main.loadNibNamed("UpholdDetailEmployeeInfoView", owner: self, options: nil)
        scrViewInformation.addSubview(viewInformation)
        //viewBackground.addSubview(scrViewInformation)

        btnCreateReply.translatesAutoresizingMaskIntoConstraints = true
        btnCreateReply.frame = CGRect(
            x: (GlobalConst.SCREEN_WIDTH - GlobalConst.BUTTON_W) / 2,
            y: sgmScrollViewChange.frame.maxY + GlobalConst.MARGIN_CELL_Y,
            width: GlobalConst.BUTTON_W,
            height: GlobalConst.BUTTON_H)
        btnCreateReply.isHidden = true
        btnCreateReply.setTitle(GlobalConst.CONTENT00065, for: .normal)
        btnCreateReply.setTitleColor(UIColor.white, for: .normal)
        btnCreateReply.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnCreateReply.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        
        
        tblViewHistory.translatesAutoresizingMaskIntoConstraints = true
        tblViewHistory.frame = CGRect(
            x: marginX, y: btnCreateReply.frame.maxY + GlobalConst.MARGIN_CELL_Y,
            width: GlobalConst.SCREEN_WIDTH - marginX * 2,
            height: GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.BUTTON_HEIGHT * 2))
        tblViewHistory.isHidden = true
        
        self.tblViewHistory.register(UINib(nibName: "UpholdDetailEmployeeHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "UpholdDetailEmployeeHistoryTableViewCell")
        tblViewHistory.dataSource = self
        tblViewHistory.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpholdDetailEmployeeViewController.setData(_:)), name:NSNotification.Name(rawValue: GlobalConst.NOTIFY_NAME_SET_DATA_UPHOLD_DETAIL_VIEW), object: nil)
        // Set data
        if Singleton.sharedInstance.sharedInt != -1 {
            // Check data is existed
            if Singleton.sharedInstance.upholdList.record.count > Singleton.sharedInstance.sharedInt {
                
                CommonProcess.requestUpholdDetail(upholdId: Singleton.sharedInstance.upholdList.record[Singleton.sharedInstance.sharedInt].id, replyId: Singleton.sharedInstance.upholdList.record[Singleton.sharedInstance.sharedInt].reply_id, view: self)
            }
        }
    }
    
    
    
    /**
     * Set data for controls
     */
    override func setData(_ notification: Notification) {
//        if currentViewType == DomainConst.TYPE_TROUBLE {
//            problemTableView.reloadData()
//        } else {
//            periodTableView.reloadData()
//        }
        print("set data")
        viewInformation.setData(model: Singleton.sharedInstance.currentUpholdDetail)
    }

    override func viewDidLayoutSubviews() {
        viewInformation.frame = CGRect(
            x: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X,
            y: GlobalConst.MARGIN_CELL_Y,
            width: scrViewInformation.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.MARGIN_CELL_X) * 2,
            //height: scrViewInformation.frame.size.height - GlobalConst.MARGIN_CELL_X * 3)
            height: GlobalConst.LABEL_HEIGHT * 14)
        viewInformation.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        viewInformation.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        viewInformation.clipsToBounds = true
        viewInformation.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        scrViewInformation.contentSize = CGSize(
            width: viewInformation.frame.size.width,
            height: viewInformation.frame.size.height + GlobalConst.LABEL_HEIGHT * 13 - (scrViewInformation.frame.size.height - GlobalConst.MARGIN_CELL_X * 3))
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
    
    /**
     * Override: show menu controller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popOverMenu" {
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    /**
     * ...
     */
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

}
