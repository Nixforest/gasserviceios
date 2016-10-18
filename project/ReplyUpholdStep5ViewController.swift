//
//  ReplyUpholdStep5ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdStep5ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, step5TableViewCellDelegate {
    

    var aImgPicked: [UIImage] = []
    

    @IBOutlet weak var lblStep5: UILabel!
    
    @IBOutlet weak var btnPickImageStep5: UIButton!
    
    @IBOutlet weak var viewPickImageStep5: UIView!
    
    @IBOutlet weak var tblvImgStep5: UITableView!
    
    @IBAction func btnPickImgStep5Tapped(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label
         */
        lblStep5.translatesAutoresizingMaskIntoConstraints = true
        lblStep5.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2, height: GlobalConst.LABEL_HEIGHT * 1.5)
        lblStep5.text = "Xin nhập thông tin Người nghiệm thu"
        lblStep5.textAlignment = NSTextAlignment.center
        lblStep5.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        /**
         * Button Pick IMG
         */
        btnPickImageStep5.translatesAutoresizingMaskIntoConstraints = true
        btnPickImageStep5.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: lblStep5.frame.size.height, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 4, height: GlobalConst.LABEL_HEIGHT * 1.5)
        btnPickImageStep5.backgroundColor = GlobalConst.BUTTON_COLOR_RED
        btnPickImageStep5.setTitle("Thêm hình ảnh", for: UIControlState.normal)
        btnPickImageStep5.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnPickImageStep5.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btnPickImageStep5.tag = 0

        /**
         * Cell define
         */
        self.tblvImgStep5.register(UINib(nibName: "step5TableViewCell", bundle: nil), forCellReuseIdentifier: "step5TableViewCell")
        /**
         * Tableview frame
         */
        
        viewPickImageStep5.translatesAutoresizingMaskIntoConstraints = true
        viewPickImageStep5.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: lblStep5.frame.size.height + btnPickImageStep5.frame.size.height, width: GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH * 2, height: GlobalConst.CELL_HEIGHT_SHOW * 3)
        viewPickImageStep5.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        tblvImgStep5.translatesAutoresizingMaskIntoConstraints = true
        tblvImgStep5.frame = CGRect(x: 0, y: 0, width: viewPickImageStep5.frame.size.width, height: viewPickImageStep5.frame.size.height)
        tblvImgStep5.dataSource = self
        tblvImgStep5.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Datasource
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:step5TableViewCell = tableView.dequeueReusableCell(withIdentifier: "step5TableViewCell") as! step5TableViewCell
        cell.indexRow = indexPath.row
        cell.delegate = self
        let  aImage :UIImage = aImgPicked[indexPath.row]
        cell.imgPicker.image = aImage
        
        // image picked
        cell.imgPicker.translatesAutoresizingMaskIntoConstraints = true
        cell.imgPicker.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: cell.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 3) - GlobalConst.BUTTON_HEIGHT, height: cell.frame.size.height - GlobalConst.PARENT_BORDER_WIDTH * 2)
        // Button Delete
        cell.btnDelete.translatesAutoresizingMaskIntoConstraints = true
        cell.btnDelete.frame = CGRect(x: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 5) - GlobalConst.BUTTON_HEIGHT, y: cell.frame.size.height / 2 - (GlobalConst.BUTTON_HEIGHT / 2), width: GlobalConst.BUTTON_HEIGHT, height: GlobalConst.BUTTON_HEIGHT)
        cell.btnDelete.setImage(UIImage(named: "delete.png"), for: .normal)
        let deleteImage = UIImage(named: "delete.png");
        let tintedImage = deleteImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.btnDelete.setImage(tintedImage, for: .normal)
        //cell.btnDelete.tintColor = UIColor.red
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aImgPicked.count
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            aImgPicked.append(image)
            ReplyUpholdViewController.valStep5.append(image)
        }
        print(aImgPicked.count)
        tblvImgStep5.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - step5TableViewCellDelegate
    func removeAtRow(row :Int) {
    print("remove row ",row)
        aImgPicked.remove(at: row)
        ReplyUpholdViewController.valStep5.remove(at: row)
        tblvImgStep5.reloadData()
    }

}
