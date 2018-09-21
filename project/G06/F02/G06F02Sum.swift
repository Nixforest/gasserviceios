//
//  G06F02Sum.swift
//  project
//
//  Created by SPJ on 4/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G06F02Sum: StepSummary, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Properties
    /** Image collection */
    var cltImg: UICollectionView! = nil
    /** Label status */
    var lblStatus: UILabel          = UILabel()
    /** Status value */
    var tbxStatus: UITextView       = UITextView()
    //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
    /** Content view */
    private var _detailView:    DetailInformationColumnView = DetailInformationColumnView()
    //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field

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
        //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
//        let contentView = UIView()
//        contentView.translatesAutoresizingMaskIntoConstraints = true
//        // Update layout of content view
//        let offset: CGFloat = updateLayout(w: w, h: h)
//        // Set parent
//        self.setParentView(parent: parent)
        //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
        // List image
        /**
         * Image CollectionView Step 5
         */
        /**
         * add xib file to CollectionView Cell
         */
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize     = CGSize(width: GlobalConst.ACCOUNT_AVATAR_W / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        self.cltImg = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        
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
        //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
//        contentView.addSubview(lblStatus)
//        contentView.addSubview(tbxStatus)
//        contentView.addSubview(cltImg)
//        self.setup(mainView: contentView, title: DomainConst.CONTENT00309, contentHeight: offset,
//                   width: w, height: h)
        // Set parent
        self.setParentView(parent: parent)
        let offset = updateContentLayout()
        self.setup(mainView: _detailView,
                   title: DomainConst.CONTENT00309,
                   contentHeight: offset,
                   width: w, height: h)
        _detailView.addSubview(cltImg)
        //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //++ BUG0190-SPJ (NguyenPT 20180328) Add user report field
//    /**
//     * Update layout of content view
//     * - parameter w:   Width of view
//     * - parameter h:   Height of view
//     */
//    func updateLayout(w: CGFloat, h: CGFloat) -> CGFloat {
//        var offset: CGFloat = 0
//        // Label Status
//        CommonProcess.setLayoutLeft(lbl: lblStatus, offset: offset,
//                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
//                                    height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00063)
//        lblStatus.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
//        // Status value
//        CommonProcess.setLayoutRight(lbl: tbxStatus, x: lblStatus.frame.maxX, y: offset,
//                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
//                                     height: GlobalConst.LABEL_HEIGHT, text: G06F02S01._selectedValue)
//        tbxStatus.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
//        offset += GlobalConst.LABEL_HEIGHT
//        
//        if cltImg != nil {
//            cltImg.translatesAutoresizingMaskIntoConstraints = true
//            cltImg.frame = CGRect(x: 0,
//                                  y: offset,
//                                  width: w * 2,
//                                  height: GlobalConst.ACCOUNT_AVATAR_H)
//            offset += GlobalConst.ACCOUNT_AVATAR_H
//            cltImg.backgroundColor = UIColor.white
//            cltImg.bounds = cltImg.frame
//        }
//        
//        return offset
//    }
//    
//    override func updateContentLayout() -> CGFloat {
//        self.tbxStatus.text = G06F02S01._selectedValue
//        
//        cltImg.frame = CGRect(x: 0,
//                              y: GlobalConst.LABEL_HEIGHT * 2,
//                              width: self.frame.width,
//                              height: GlobalConst.ACCOUNT_AVATAR_H)
//        cltImg.backgroundColor = UIColor.white
//        cltImg.contentSize = CGSize(
//            width: GlobalConst.ACCOUNT_AVATAR_H * (CGFloat)(G01F02S06._selectedValue.count),
//            height: GlobalConst.ACCOUNT_AVATAR_H)
//        self.cltImg.reloadData()
//        return 0
//    }
    
    /**
     * Update layout of content
     * - returns: Offset after reload
     */
    override func updateContentLayout() -> CGFloat {
        var listValues = [(String, String)]()
        if !G06F02S01._selectedValue.isEmpty {
            listValues.append((DomainConst.CONTENT00063, G06F02S01._selectedValue))
        }
        if !G06F02S03._target.isEmpty() {
            listValues.append((G06F02S03.getTargetNameTitle(), G06F02S03._target.name))
        }
        let offset = _detailView.updateData(listValues: listValues)
        if cltImg != nil {
            cltImg.translatesAutoresizingMaskIntoConstraints = true
            cltImg.frame = CGRect(x: 0,
                                  y: offset + self.getParentView().getTopHeight(),
                                  width: self.frame.width,
                                  height: GlobalConst.ACCOUNT_AVATAR_H)
            cltImg.backgroundColor = UIColor.white
            cltImg.bounds = cltImg.frame
            
            cltImg.contentSize = CGSize(
                width: GlobalConst.ACCOUNT_AVATAR_H * (CGFloat)(G01F02S06._selectedValue.count),
                height: GlobalConst.ACCOUNT_AVATAR_H)
            
            self.cltImg.reloadData()
        }
        
        return offset
    }
    //-- BUG0190-SPJ (NguyenPT 20180328) Add user report field
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return G06F02S02._selectedValue.count
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionImageViewCell.theClassName,
                                                      for: indexPath) as! CollectionImageViewCell
        cell.imageView.frame  = CGRect(x: 0,  y: 0,
                                       width: GlobalConst.ACCOUNT_AVATAR_H,
                                       height: GlobalConst.ACCOUNT_AVATAR_H)
        cell.imageView.image = G06F02S02._selectedValue[indexPath.row]
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
        // handle tap events
        /** push to zoomIMGVC */
        zoomIMGViewController.imgPicked = G06F02S02._selectedValue[indexPath.row]
        self.getParentView().pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)
        
    }
}
