//
//  G11F00S03VC.swift
//  project
//
//  Created by SPJ on 8/18/18.
//  Copyright © 2018 admin. All rights reserved.
//
//++ BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
import UIKit
import harpyframework

class G11F00S03VC: BaseChildViewController, UIPickerViewDelegate {
    /** Selected value */
    static var _selectedValue: (title: String, content: String) = (DomainConst.BLANK, DomainConst.BLANK)
    /** List image add to this order */
    internal var _images:            [UIImage]           = [UIImage]()
    /** Testfield Title */
    @IBOutlet weak var tfTitle: UITextField!
    /** Image collection view */
    @IBOutlet weak var cltImg: UICollectionView!
    /** PickerView Admin */
    @IBOutlet weak var pkv: UIPickerView!
    /** data Admin */
    private var _dataAdmin :           [ConfigBean] = [ConfigBean]()
    /** id Handler */
    private var _handlerId :           String = DomainConst.BLANK
    /** TextView Content */
    @IBOutlet weak var tvContent: UITextView!
    /** Button Create */
    @IBOutlet weak var btnCreate: UIButton!
    /** Create Ticket*/
    @IBAction func createTicket(_ sender: Any) {
        TicketCreateRequest.request(action: #selector(finishCreateTicket(_:)),
                                    view: self,
                                    id: _handlerId,
                                    title: tfTitle.text!,
                                    message: tvContent.text, images:_images)
    }
    @IBOutlet weak var marginTopFromPkv: NSLayoutConstraint!
    /** Height PickerView*/
    @IBOutlet weak var pkvHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        //Create title
        self.createNavigationBar(title: DomainConst.CONTENT00589)
        // Picker view
        pkv.delegate = self
        // Data for Picker View driver
        
        _dataAdmin.append(ConfigBean(id: "", name: "Chọn người xử lý"))
        CacheDataRespModel.record.getListTicketHandler().forEach { (admin) in
            _dataAdmin.append(admin)
        }
        // Add action Add Image button to navigation bar
        self.createRightNavigationItem(icon: DomainConst.ADD_MATERIAL_ICON_IMG_NAME,
                                       action: #selector(addImageButtonTapped(_:)), target: self)
        //collectionview
        cltImg.dataSource = self
        cltImg.delegate = self
        //textview
        let color = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        tvContent.layer.borderColor = color
        tvContent.layer.borderWidth = 1.0
        tvContent.layer.cornerRadius = 5.0
        //check User Customer Role 4
        if BaseModel.shared.getRoleId() == "4"{
            marginTopFromPkv.constant = 0
            pkvHeight.constant = 0
        }
        //get Available Content
        if !G11F00S03VC._selectedValue.content.isBlank {
            tvContent.text = G11F00S03VC._selectedValue.content
        }// custom button
        btnCreate.layer.cornerRadius = 15
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        G11F00S03VC._selectedValue.content = DomainConst.BLANK
    }
    /**
     * Handle when finish create ticket
     */
    internal func finishCreateTicket(_ notification: Notification) {
        let data = (notification.object as! String)
        let model = BaseRespModel(jsonString: data)
        if model.isSuccess() {
            // Clear data at steps
            self.clearData()
            showAlert(message: model.message,
                      okHandler: {
                        alert in
                        //self.backButtonTapped(self)
                        self.pushToView(name: G11F00S01VC.theClassName)
            })
        } else {    // Error
            self.showAlert(message: model.message)
        }
    }
    
    /**
     * Handle tap on create Customer Request Button
     * - parameter sender: AnyObject
     */
    internal func addImageButtonTapped(_ sender: AnyObject) {
        // Show alert
        let alert = UIAlertController(title: DomainConst.CONTENT00437,
                                      message: DomainConst.BLANK,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: DomainConst.CONTENT00202,
                                   style: .cancel,
                                   handler: nil)
        let actionTakePicture = UIAlertAction(title: "Chụp ảnh",
                                              style: .default, handler: {
                                                action in
                                                self.addImageFromCamera()
        })
        let actionGetPicture = UIAlertAction(title: "Chọn ảnh từ thư viện",
                                             style: .default, handler: {
                                                action in
                                                self.addImageFromLibrary()
        })
        alert.addAction(cancel)
        alert.addAction(actionTakePicture)
        alert.addAction(actionGetPicture)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sender as! UIButton
            presenter.sourceRect = sender.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Handle add image from camera
     */
    internal func addImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.camera
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: {
                self.cltImg.reloadData()
            })
        }
    }
    
    /**
     * Handle add image from library
     */
    internal func addImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: {
                self.cltImg.reloadData()
            })
        }
    }
    
    // MARK: - Picker View Delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView)->Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        return _dataAdmin.count
    }
    // goes in lieu of titleForRow if customization is desired
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
            pickerLabel.textColor = .darkGray
            pickerLabel.textAlignment = .center
            pickerLabel.text = String(_dataAdmin[row].name)
            pickerLabel.font = UIFont(name:"Helvetica", size: 17)
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _handlerId = _dataAdmin[row].id
    }


}

// MARK: UIImagePickerControllerDelegate
extension G11F00S03VC: UIImagePickerControllerDelegate {
    /**
     * Tells the delegate that the user picked a still image or movie.
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self._images.append(image)            
        }
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: UINavigationControllerDelegate
extension G11F00S03VC: UINavigationControllerDelegate {
    // Implement methods
}

// MARK: UICollectionViewDataSource
extension G11F00S03VC: UICollectionViewDataSource {
    /**
     * Asks your data source object for the number of items in the specified section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return _data.record.images.count
        //return _data.record.images.count + self._images.count
        return self._images.count
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get current cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell4", for: indexPath) as! ImageCell
        cell.imgPicture.image = self._images[indexPath.row]
        cell.btnDeletePicture.layer.cornerRadius = 12
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 2
        cell.delegate = self
        //cell.imageView.frame  = CGRect(x: 0,  y: 0,  width: GlobalConst.ACCOUNT_AVATAR_H / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        /*if indexPath.row < _data.record.images.count {
         cell.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].thumb, contentMode: cell.imageView.contentMode)
         } else {
         cell.imageView.image = self._images[indexPath.row - _data.record.images.count]
         }*/
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension G11F00S03VC: UICollectionViewDelegate {
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell4", for: indexPath) as! ImageCell
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = cell.imgPicture.image
        zoomIMGViewController.setPickedImg(img: self._images[indexPath.row])
        /*if indexPath.row < _data.record.images.count {
         zoomIMGViewController.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].large, contentMode: cell.imageView.contentMode)
         } else {
         zoomIMGViewController.setPickedImg(img: self._images[indexPath.row - _data.record.images.count])
         }*/
        // Move to rating view
        self.pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        print("Perform")
    }
}
extension G11F00S03VC: ImageDelegte{
    func deleteImage(cell: ImageCell) {
        if let indexPath = cltImg?.indexPath(for: cell){
            _images.remove(at: indexPath.row)
            cltImg?.deleteItems(at: [indexPath])
        }
    }
}
//-- BUG0202-SPJ (KhoiVT 20180818) Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
