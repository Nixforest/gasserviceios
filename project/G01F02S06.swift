//
//  G01F02S06.swift
//  project
//
//  Created by Nixforest on 10/30/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F02S06: StepContent, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageTableViewCellDelegate {
    // MARK: Properties
    /** Selected value */
    static var _selectedValue: [UIImage] = [UIImage]()
    /** Button add new image */
    var _btnAddImg = UIButton()
    var _btnAddImgLibrary = UIButton()
    /** View pick new image */
    var _viewPickImg = UIView()
    /** Table view list image */
    var _tblListImg = UITableView()
    
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
    init(w: CGFloat, h: CGFloat, parent: BaseViewController) {
        super.init()
        var offset: CGFloat = GlobalConst.MARGIN
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        // Add new image button
        CommonProcess.createButtonLayout(btn: _btnAddImg,
                                   x: (w - GlobalConst.BUTTON_W) / 2,
                                   y: offset,
                                   text: DomainConst.CONTENT00234)
        _btnAddImg.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        _btnAddImg.tag = 0
        contentView.addSubview(_btnAddImg)
        offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        CommonProcess.createButtonLayout(btn: _btnAddImgLibrary,
                                         x: (w - GlobalConst.BUTTON_W) / 2,
                                         y: offset,
                                         text: DomainConst.CONTENT00235)
        _btnAddImgLibrary.addTarget(self, action: #selector(btnLibraryTapped), for: .touchUpInside)
        _btnAddImgLibrary.tag = 0
        contentView.addSubview(_btnAddImgLibrary)
        offset += GlobalConst.BUTTON_H + GlobalConst.MARGIN
        
        // Table view
        /** Cell define */
        self._tblListImg.register(UINib(nibName: DomainConst.G01_F02_S06_CELL, bundle: nil),
                                  forCellReuseIdentifier: DomainConst.G01_F02_S06_CELL)
        _viewPickImg.addSubview(_tblListImg)
        contentView.addSubview(_viewPickImg)
        
        // Set parent
        self.setParentView(parent: parent)
        
        self.setup(mainView: contentView, title: DomainConst.CONTENT00189,
                   contentHeight: offset,
                   width: w, height: h)
        
        _viewPickImg.translatesAutoresizingMaskIntoConstraints = true
        _viewPickImg.frame = CGRect(x: 0, y: offset,
                                    width: w, height: h - offset - self.getTitleHeight())
        _viewPickImg.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        _tblListImg.translatesAutoresizingMaskIntoConstraints = true
        _tblListImg.frame = CGRect(x: 0, y: 0, width: _viewPickImg.frame.size.width, height: _viewPickImg.frame.size.height)
        _tblListImg.separatorStyle = .none
        _tblListImg.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        _tblListImg.dataSource = self
        _tblListImg.delegate = self
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Handle save selected data.
     * Mark step done.
     */
    func btnTapped(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            
            self.getParentView().present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /**
     * Handle save selected data.
     * Mark step done.
     */
    func btnLibraryTapped(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            
            self.getParentView().present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    override func checkDone() -> Bool {
        return true
    }
    
    // MARK: - TableView Datasource
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: DomainConst.G01_F02_S06_CELL)
            as! ImageTableViewCell
        cell.indexRow = indexPath.row
        cell.delegate = self
        let aImage :UIImage     = G01F02S06._selectedValue[indexPath.row]
        cell.imgPicker.image    = aImage
        
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
        cell.btnDelete.setImage(UIImage(named: DomainConst.DELETE_IMG_NAME), for: .normal)
        let deleteImage = UIImage(named: DomainConst.DELETE_IMG_NAME);
        let tintedImage = deleteImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.btnDelete.setImage(tintedImage, for: .normal)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return G01F02S06._selectedValue.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell:ImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: DomainConst.G01_F02_S06_CELL) as! ImageTableViewCell
        return cell.frame.height
    }
    
    // MARK: - ImagePicker Delegate    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            G01F02S06._selectedValue.append(image)
            NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F02), object: nil)
        }
        self._tblListImg.reloadData()
        self.getParentView().dismiss(animated: true, completion: nil)
    }
    
    // MARK: - step5TableViewCellDelegate
    func removeAtRow(row :Int) {
        print("remove row ",row)
        G01F02S06._selectedValue.remove(at: row)
        self._tblListImg.reloadData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F02), object: nil)
    }
}
