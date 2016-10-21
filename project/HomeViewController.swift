//
//  HomeViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/20/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var loginStatus:Bool = true
    
    var aList:[String] = [GlobalConst.CONTENT00130, GlobalConst.CONTENT00041, GlobalConst.CONTENT00099, GlobalConst.CONTENT00098, GlobalConst.CONTENT00100]
    var aListIcon:[String] = ["ordergas.png","CreateUpHold.jpeg", "UpHoldList.jpeg", "ServiceRating.jpeg", "Account.jpeg"]
    var aListText:[String] = ["Đặt Gas","Yêu cầu bảo trì", "Danh sách bảo trì", "Đánh giá dịch vụ", "Tài khoản"]
    
    @IBOutlet weak var tableViewHome: UITableView!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Background
        self.view.layer.borderWidth = GlobalConst.PARENT_BORDER_WIDTH
        self.view.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        //MARK: TableView Frame
        tableViewHome.translatesAutoresizingMaskIntoConstraints = true
        tableViewHome.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT, width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 2), height: GlobalConst.SCREEN_HEIGHT - (GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT + (GlobalConst.PARENT_BORDER_WIDTH * 2)))
        /**
         * Cell register
         */
        self.tableViewHome.register(UINib(nibName: "homeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeTableViewCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARKL TableView delegate
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aList.count
    }
    
    // MARK: TableViewDatasource
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:homeTableViewCell = tableViewHome.dequeueReusableCell(withIdentifier: "homeTableViewCell") as! homeTableViewCell
        let imgIcon:UIImageView = UIImageView(frame: CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.CELL_BORDER_WIDTH * 2, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.CELL_BORDER_WIDTH * 2, width: GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.CELL_BORDER_WIDTH) * 2, height: GlobalConst.CELL_HEIGHT_SHOW - (GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.CELL_BORDER_WIDTH) * 2))
        imgIcon.image = UIImage(named: aListIcon[(indexPath as NSIndexPath).row])
        cell.addSubview(imgIcon)
        let txtCellName:UILabel = UILabel(frame: CGRect(x: 110, y: 0, width: 200, height: 100))
        txtCellName.text = aListText[(indexPath as NSIndexPath).row]
        cell.addSubview(txtCellName)
        cell.tag = (indexPath as NSIndexPath).row
        tableViewHome.separatorStyle = UITableViewCellSeparatorStyle.none
        cell.layer.borderWidth = GlobalConst.CELL_BORDER_WIDTH
        cell.layer.borderColor = GlobalConst.CELL_BORDER_COLOR.cgColor
        
        //cell text color
        txtCellName.textColor = UIColor.white
        
        //cell background color
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x29B6F6)
        case 1:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x666666)
        case 2:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0xFAB102)
        case 3:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0xFF673E)
        case 4:
            cell.backgroundColor = ColorFromRGB().getColorFromRGB(0x8C60FF)
        default: break
        }
        //show cell
        if Singleton.sharedInstance.checkIsLogin() == false {
            switch (indexPath as NSIndexPath).row {
            case 2:
                cell.isHidden = true
            case 3:
                cell.isHidden = true
            case 4:
                cell.isHidden = true
            default: break
            }
        } else {
            switch (indexPath as NSIndexPath).row {
            case 2:
                cell.isHidden = false
            case 3:
                cell.isHidden = false
            case 4:
                cell.isHidden = false
            default: break
            }
        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight:CGFloat
        if loginStatus == false {
            if ((indexPath as NSIndexPath).row == 2) || ((indexPath as NSIndexPath).row == 3) || ((indexPath as NSIndexPath).row == 4) {
                rowHeight = GlobalConst.CELL_HEIGHT_HIDE
            } else {
                rowHeight = GlobalConst.CELL_HEIGHT_SHOW
            }
            
        } else {
            rowHeight = GlobalConst.CELL_HEIGHT_SHOW
        }
        return rowHeight
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: "CreateUpholdViewController")
            self.navigationController?.pushViewController(upholdListVC, animated: true)
        case 2:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let upholdListVC = mainStoryboard.instantiateViewController(withIdentifier: "UpholdListViewController")
            self.navigationController?.pushViewController(upholdListVC, animated: true)
            
        case 4:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let accountVC = mainStoryboard.instantiateViewController(withIdentifier: "AccountViewController")
            self.navigationController?.pushViewController(accountVC, animated: true)
        default:
            break
        }

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
