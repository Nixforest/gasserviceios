//
//  G08F01S05.swift
//  project
//
//  Created by SPJ on 6/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G08F01S05: G01F02S06 {
    /** Previous images */
    public static var _previousImage: [UpholdImageInfoItem] = [UpholdImageInfoItem]()
    /** Origin previous images */
    public static var _originPreviousImage: [UpholdImageInfoItem] = [UpholdImageInfoItem]()
    
    // MARK: - TableView Datasource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: DomainConst.G01_F02_S06_CELL)
            as! ImageTableViewCell
        cell.indexRow = indexPath.row
        cell.delegate = self
        
        if indexPath.row < G08F01S05._previousImage.count {
            cell.imgPicker.getImgFromUrl(link: G08F01S05._previousImage[indexPath.row].large,
                                         contentMode: cell.imgPicker.contentMode)
        } else {
            let aImage :UIImage     = G01F02S06._selectedValue[indexPath.row - G08F01S05._previousImage.count]
            cell.imgPicker.image    = aImage
        }
        
        // image picked
        cell.imgPicker.translatesAutoresizingMaskIntoConstraints = true
        cell.imgPicker.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                      y: GlobalConst.PARENT_BORDER_WIDTH,
                                      width: cell.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 3) - GlobalConst.BUTTON_HEIGHT,
                                      height: cell.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH * 2)
        // Button Delete
        cell.btnDelete.translatesAutoresizingMaskIntoConstraints = true
        cell.btnDelete.frame = CGRect(x: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 5) - GlobalConst.BUTTON_HEIGHT,
                                      y: cell.frame.size.height / 2 - (GlobalConst.BUTTON_HEIGHT / 2),
                                      width: GlobalConst.BUTTON_HEIGHT,
                                      height: GlobalConst.BUTTON_HEIGHT)
        cell.btnDelete.setImage(ImageManager.getImage(named: DomainConst.DELETE_IMG_NAME), for: .normal)
        let deleteImage = ImageManager.getImage(named: DomainConst.DELETE_IMG_NAME);
        let tintedImage = deleteImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.btnDelete.setImage(tintedImage, for: .normal)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return G01F02S06._selectedValue.count + G08F01S05._previousImage.count
    }
    
    // MARK: - step5TableViewCellDelegate
    override func removeAtRow(row :Int) {
        if row < G08F01S05._previousImage.count {
            G08F01S05._previousImage.remove(at: row)
        } else {
            G01F02S06._selectedValue.remove(at: row - G08F01S05._previousImage.count)
        }
        self._tblListImg.reloadData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F02), object: nil)
    }
}
