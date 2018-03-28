//
//  G06F00S05VC.swift
//  project
//
//  Created by SPJ on 3/29/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F00S05VC: ChildViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Properties
    /** Id */
    public static var _id:          String               = DomainConst.BLANK
    /** Image collection */
    var cltImg: UICollectionView! = nil
    /** Data */
    private var _data: WorkingReportViewRespModel = WorkingReportViewRespModel()
    var detailView: DetailInformationColumnView = DetailInformationColumnView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Navigation
        createNavigationBar(title: DomainConst.CONTENT00296)
        
        /**
         * add xib file to CollectionView Cell
         */
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize     = CGSize(width: GlobalConst.ACCOUNT_AVATAR_W / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        self.cltImg = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        self.cltImg.register(UINib(nibName: CollectionImageViewCell.theClassName, bundle: frameworkBundle),
                             forCellWithReuseIdentifier: CollectionImageViewCell.theClassName)
        cltImg.dataSource   = self
        cltImg.delegate     = self
        cltImg.alwaysBounceHorizontal = true
        cltImg.bounces = true
        if let layout = cltImg.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        let offset = getTopHeight() + GlobalConst.MARGIN_CELL_Y
        //var offset: CGFloat = 0
        detailView.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                  y: offset,
                                  width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                  height: GlobalConst.SCREEN_HEIGHT - offset)
//        self.view.addSubview(cltImg)
        // Request data from server
        if !G06F00S05VC._id.isEmpty {
            WorkingReportViewRequest.request(action: #selector(setData(_:)),
                                              view: self,
                                              id: G06F00S05VC._id)
        }
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
    
    
    /**
     * Set data after finish request server
     */
    override func setData(_ notification: Notification) {
        let data = (notification.object as? String)
        let model = WorkingReportViewRespModel(jsonString: data!)
        if model.isSuccess() {
            _data = model
            var listValues = [(String, String)]()
            listValues.append((DomainConst.CONTENT00091, model.record.getCode()))
            listValues.append((DomainConst.CONTENT00055, model.record.name))
            listValues.append((DomainConst.CONTENT00063, model.record.getReportContent()))
            //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
            listValues.append((G06F02S03.getTargetNameTitle(), model.record.getUserReport()))
            //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
            listValues.append((DomainConst.CONTENT00096, model.record.getCreatedDate()))
            var offset = detailView.setData(listValues: listValues)
            
            
            if cltImg != nil {
                cltImg.translatesAutoresizingMaskIntoConstraints = true
                cltImg.frame = CGRect(x: 0,
                                      y: offset + self.getTopHeight(),
                                      width: self.view.frame.width,
                                      height: GlobalConst.ACCOUNT_AVATAR_H)
                offset += GlobalConst.ACCOUNT_AVATAR_H
                cltImg.backgroundColor = UIColor.white
                cltImg.bounds = cltImg.frame
                
                cltImg.contentSize = CGSize(
                    width: GlobalConst.ACCOUNT_AVATAR_H * (CGFloat)(_data.record.images.count),
                    height: GlobalConst.ACCOUNT_AVATAR_H)
                
                self.cltImg.reloadData()
            }
            detailView.addSubview(cltImg)
            self.view.addSubview(detailView)
        }
        //++ BUG0092-SPJ (NguyenPT 20170517) Show error message
        else {
            showAlert(message: model.message)
        }
        //-- BUG0092-SPJ (NguyenPT 20170517) Show error message
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.record.images.count
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionImageViewCell.theClassName,
                                                      for: indexPath) as! CollectionImageViewCell
        cell.imageView.frame  = CGRect(x: 0,  y: 0,
                                       width: GlobalConst.ACCOUNT_AVATAR_H,
                                       height: GlobalConst.ACCOUNT_AVATAR_H)
        cell.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].large, contentMode: cell.imageView.contentMode)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: GlobalConst.ACCOUNT_AVATAR_H, height: GlobalConst.ACCOUNT_AVATAR_H)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = cell.imageView.image
        zoomIMGViewController.imageView.getImgFromUrl(link: _data.record.images[indexPath.row].large, contentMode: cell.imageView.contentMode)
        self.pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)
        
    }
}
