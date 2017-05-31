//
//  G10F00S02VC.swift
//  project
//
//  Created by SPJ on 5/31/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G10F00S02VC: ChildViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let contentCellIdentifier = "ContentCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    /** Static data */
    private var _data:              ReportInventoryRespModel   = ReportInventoryRespModel()
    private var _arrHeaderText: [(Int, String)] = [
        (0, "T.Đầu"),
        (1, "Nhập"),
        (2, "Xuất"),
        (3, "T.Cuối")
    ]
    // MARK: Utility methods
    /**
     * Request data from server
     */
    private func requestData(action: Selector = #selector(setData(_:))) {
        ReportRequest.request(action: action,
                              view: self,
                              from: CommonProcess.getCurrentDate(), to: CommonProcess.getCurrentDate(),
                              url: G10Const.PATH_APP_REPORT_INVENTORY)
    }
    
    private func updateData(bean: ReportInventoryRespBean) {
        _data.record.rows.removeAll()
        for item in bean.rows {
            _data.record.rows.append(item)
            _data.record.rows.append(contentsOf: item.children)
        }
        _data.record.allow_update_storecard_hgd = bean.allow_update_storecard_hgd
        _data.record.next_time_update_storecard_hgd = bean.next_time_update_storecard_hgd
    }
    
    // MARK: Override methods
    /**
     * Handle finish request data
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = ReportInventoryRespModel(jsonString: data)
        if model.isSuccess() {
            //_data.record = model.record
            updateData(bean: model.record)
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.reloadData()
//            let indexSet = IndexSet(integersIn: 0...(_data.record.rows.count - 1))
//            collectionView.reloadSections(indexSet)
        } else {
            showAlert(message: model.message)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationBar(title: DomainConst.CONTENT00403)
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: contentCellIdentifier)
        collectionView.frame = CGRect(x: 0, y: self.getTopHeight(),
                                width: GlobalConst.SCREEN_WIDTH,
                                height: GlobalConst.SCREEN_HEIGHT - self.getTopHeight())
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        requestData()
        self.view.makeComponentsColor()
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
    // MARK - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if _data.record.rows.count != 0 {
            return _data.record.rows.count + 1
        }
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /* Step 1 for a first row with twice the width:
         if section == 0 {
         // first row
         return 4
         } else {
         return 7
         }*/
        
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // This is the first row
        if (indexPath as NSIndexPath).section == 0 {
            if (indexPath as NSIndexPath).row == 0 {
                // This is the first cell of the first row. Label it.
                let dateCell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
                dateCell.backgroundColor = UIColor.white
                dateCell.updateValue(value: "Vật tư")
                
                return dateCell
            } else {
                // This is the rest of the first row.
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
//                contentCell.contentLabel.font = UIFont.systemFont(ofSize: 13)
//                contentCell.contentLabel.textColor = UIColor.black
//                contentCell.contentLabel.text = "Section"
                
                contentCell.updateValue(value: _arrHeaderText[indexPath.row - 1].1)
                if (indexPath as NSIndexPath).section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.white
                }
                
                return contentCell
            }
        } else {
            // These are the remaining rows
            if (indexPath as NSIndexPath).row == 0 {
                // This is the first column of each row. Label it accordingly.
                let dateCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
                if _data.record.rows.count > indexPath.section - 1 {
                    let data = _data.record.rows[indexPath.section - 1]
                    if !data.children.isEmpty {
                        dateCell.updateValue(value: data.name, alignment: .left, bkgColor: GlobalConst.REPORT_PARENT_COLOR)
                    } else {
                        var background = UIColor.white
                        if indexPath.section % 2 != 0 {
                            background = GlobalConst.BACKGROUND_COLOR_GRAY
                        }
                        dateCell.updateValue(value: data.name, alignment: .left, bkgColor: background, leftMargin: 10)
                    }
                }
                
                return dateCell
            } else {
                // These are all the remaining content cells (neither first column nor first row)
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
                
                if _data.record.rows.count > indexPath.section - 1 {
                    let data = _data.record.rows[indexPath.section - 1]
                    var value = DomainConst.BLANK
                    switch indexPath.row - 1 {
                    case 0:
                        value = data.beginQty
                    case 1:
                        value = data.inQty
                    case 2:
                        value = data.outQty
                    case 3:
                        value = data.endQty
                    default:
                        value = DomainConst.BLANK
                    }
                    if !data.children.isEmpty {
                        contentCell.updateValue(value: value, alignment: .center, bkgColor: GlobalConst.REPORT_PARENT_COLOR)
                    } else {
                        var background = UIColor.white
                        if indexPath.section % 2 != 0 {
                            background = GlobalConst.BACKGROUND_COLOR_GRAY
                        }
                        contentCell.updateValue(value: value, alignment: .center, bkgColor: background)
                    }
                }
                
                return contentCell
            }
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
