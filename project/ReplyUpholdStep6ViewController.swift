//
//  ReplyUpholdStep6ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdStep6ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var lblHeaderStep6: UITextView!
    @IBOutlet weak var lblValStep2: UILabel!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblStep0: UILabel!
    @IBOutlet weak var lblValStep0: UILabel!
    @IBOutlet weak var lblStep1: UILabel!
    @IBOutlet weak var lblValStep1: UILabel!
    @IBOutlet weak var lblStep3: UILabel!
    @IBOutlet weak var lblValStep3: UILabel!
    @IBOutlet weak var lblStep4: UILabel!
    @IBOutlet weak var lblValstep4: UILabel!
    @IBOutlet weak var cltviewStep5: UICollectionView!
    
    // MARK: - show Value Step
    func showValue(_ notification: Notification) {
        lblValStep0.text = " " + ReplyUpholdViewController.valStep0
        lblValStep1.text = " " + ReplyUpholdViewController.valStep1
        lblValStep2.text = " " + ReplyUpholdViewController.valStep2
        lblValStep3.text = " " + ReplyUpholdViewController.valNameStep3 + " - " + ReplyUpholdViewController.valPhoneStep3
        lblValstep4.text = " " + ReplyUpholdViewController.valStep4
        cltviewStep5.reloadData()
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * Label
         */
        lblHeaderStep6.translatesAutoresizingMaskIntoConstraints = true
        lblHeaderStep6.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.LABEL_HEIGHT * 2)
        lblHeaderStep6.text = "Bạn đang gửi thông tin sự cố như bên dưới cho chúng tôi, xin hãy kiểm tra lại thông tin một lần nữa và nhấn nút Gửi nếu bạn đồng ý"
        lblHeaderStep6.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        /**
         * View Content
         */
        viewContent.translatesAutoresizingMaskIntoConstraints = true
        viewContent.backgroundColor = UIColor.white
        viewContent.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        viewContent.layer.borderColor = GlobalConst.BUTTON_COLOR_RED.cgColor
        viewContent.layer.cornerRadius = GlobalConst.BUTTON_CORNER_RADIUS
        viewContent.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH ,
                                   y: GlobalConst.PARENT_BORDER_WIDTH + lblHeaderStep6.frame.size.height,
                                   width: GlobalConst.SCREEN_WIDTH - (GlobalConst.PARENT_BORDER_WIDTH * 4),
                                   height: GlobalConst.SCREEN_HEIGHT - ((GlobalConst.BUTTON_HEIGHT * 2) + (GlobalConst.PARENT_BORDER_WIDTH * 3) + lblHeaderStep6.frame.size.height + GlobalConst.STATUS_BAR_HEIGHT + GlobalConst.NAV_BAR_HEIGHT))
        /**
         * Value Step 2
         */
        lblValStep2.translatesAutoresizingMaskIntoConstraints = true
        lblValStep2.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH, width: (viewContent.frame.size.width), height: GlobalConst.LABEL_HEIGHT)
        lblValStep2.backgroundColor = UIColor.white
        lblValStep2.text = ReplyUpholdViewController.valStep2
        /**
         * Value Step 0
         */
        lblStep0.translatesAutoresizingMaskIntoConstraints = true
        lblStep0.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT, width: (viewContent.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
        lblStep0.backgroundColor = UIColor.white
        lblStep0.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblStep0.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblStep0.text = " Trạng thái"
        
        lblValStep0.translatesAutoresizingMaskIntoConstraints = true
        lblValStep0.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblStep0.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH + GlobalConst.LABEL_HEIGHT, width: (viewContent.frame.size.width - lblStep0.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
        lblValStep0.backgroundColor = UIColor.white
        lblValStep0.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblValStep0.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblValStep0.text = ReplyUpholdViewController.valStep0
        
        /**
         * Value Step 1
         */
        lblStep1.translatesAutoresizingMaskIntoConstraints = true
        lblStep1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 2), width: (viewContent.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
        lblStep1.backgroundColor = UIColor.white
        lblStep1.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblStep1.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblStep1.text = " Thời gian"
        
        lblValStep1.translatesAutoresizingMaskIntoConstraints = true
        lblValStep1.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblStep0.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 2), width: (viewContent.frame.size.width - lblStep0.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
        lblValStep1.backgroundColor = UIColor.white
        lblValStep1.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblValStep1.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblValStep1.text = ReplyUpholdViewController.valStep1
        /**
         * Value Step 3
         */
        lblStep3.translatesAutoresizingMaskIntoConstraints = true
        lblStep3.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 3), width: (viewContent.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
        lblStep3.backgroundColor = UIColor.white
        lblStep3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblStep3.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblStep3.text = " Nghiệm thu"
        
        lblValStep3.translatesAutoresizingMaskIntoConstraints = true
        lblValStep3.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblStep0.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 3), width: (viewContent.frame.size.width - lblStep0.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
        lblValStep3.backgroundColor = UIColor.white
        lblValStep3.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblValStep3.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        
        /**
         * Value Step 4
         */
        lblStep4.translatesAutoresizingMaskIntoConstraints = true
        lblStep4.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 4), width: (viewContent.frame.size.width / 3), height: GlobalConst.LABEL_HEIGHT)
        lblStep4.backgroundColor = UIColor.white
        lblStep4.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblStep4.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblStep4.text = " Nội bộ"
        
        lblValstep4.translatesAutoresizingMaskIntoConstraints = true
        lblValstep4.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH + lblStep0.frame.size.width, y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 4), width: (viewContent.frame.size.width - lblStep0.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)), height: GlobalConst.LABEL_HEIGHT)
        lblValstep4.backgroundColor = UIColor.white
        lblValstep4.layer.borderWidth = GlobalConst.BUTTON_BORDER_WIDTH
        lblValstep4.layer.borderColor = GlobalConst.PARENT_BORDER_COLOR_GRAY.cgColor
        lblValstep4.text = ReplyUpholdViewController.valStep4
        /**
         * Image CollectionView Step 5
         */
        cltviewStep5.translatesAutoresizingMaskIntoConstraints = true
        cltviewStep5.frame = CGRect(x: GlobalConst.PARENT_BORDER_WIDTH,
                                    y: GlobalConst.PARENT_BORDER_WIDTH + (GlobalConst.LABEL_HEIGHT * 5) + GlobalConst.PARENT_BORDER_WIDTH,
                                    width: (viewContent.frame.size.width - (GlobalConst.PARENT_BORDER_WIDTH * 2)),
                                    height: viewContent.frame.size.height - (GlobalConst.LABEL_HEIGHT * 5) - (GlobalConst.PARENT_BORDER_WIDTH * 3))
        cltviewStep5.backgroundColor = UIColor.white
        cltviewStep5.dataSource = self
        cltviewStep5.bounds = cltviewStep5.frame
        cltviewStep5.alwaysBounceHorizontal = true
        cltviewStep5.bounces = true
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyUpholdStep6ViewController.showValue(_:)), name:NSNotification.Name(rawValue: "showValue"), object: nil)
        /**
         * add xib file to CollectionView Cell
         */
        //self.cltviewStep5.register(UINib(nibName: "your_xib_name", bundle: nil), forCellWithReuseIdentifier: "your_reusable_identifier")
        self.cltviewStep5!.register(UINib(nibName: "CollectionViewCell1", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ReplyUpholdViewController.valStep5.count
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        /*let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "step6ImgCollectionViewCell", for: indexPath as IndexPath) as! step6ImgCollectionViewCell
        cell.imgCell.image = ReplyUpholdViewController.valStep5[indexPath.row]
        cell.imgCell.contentMode = UIViewContentMode.scaleAspectFit
        cell.frame = CGRect(x: cltviewStep5.frame.size.height * CGFloat(indexPath.row), y: cell.frame.origin.y, width: cltviewStep5.frame.size.height, height: cltviewStep5.frame.size.height)
        cell.backgroundColor = UIColor.black
        return cell*/
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell1", for: indexPath) as! CollectionViewCell1
        cell.imageView1.frame  = CGRect(x: 0,  y: 0,  width: viewContent.frame.size.height - (GlobalConst.LABEL_HEIGHT * 5) - (GlobalConst.PARENT_BORDER_WIDTH * 3), height: viewContent.frame.size.height - (GlobalConst.LABEL_HEIGHT * 5) - (GlobalConst.PARENT_BORDER_WIDTH * 3))
        cell.imageView1.image = ReplyUpholdViewController.valStep5[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewContent.frame.size.height - (GlobalConst.LABEL_HEIGHT * 5) - (GlobalConst.PARENT_BORDER_WIDTH * 3),
                      height: viewContent.frame.size.height - (GlobalConst.LABEL_HEIGHT * 5) - (GlobalConst.PARENT_BORDER_WIDTH * 3))
    }

    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
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
