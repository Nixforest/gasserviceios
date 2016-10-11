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
        btnPickImageStep5.setTitle("pick", for: UIControlState.normal)
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
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aImgPicked.count
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
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
        tblvImgStep5.reloadData()
    }

}
