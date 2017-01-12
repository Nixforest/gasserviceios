//
//  G01F02S07.swift
//  project
//
//  Created by Nixforest on 10/28/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import harpyframework

class G01F02S07: StepSummary, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Properties
    /** Report wrong value */
    var lblReportWrong: UILabel = UILabel()
    /** Label status */
    var lblStatus: UILabel = UILabel()
    /** Status value */
    var tbxStatus: UITextView = UITextView()
    /** Label Time */
    var lblTime: UILabel = UILabel()
    /** Time value */
    var tbxTime: UITextView = UITextView()
    /** Label Reviewer */
    var lblReviewer: UILabel = UILabel()
    /** Reviewer value */
    var tbxReviewer: UITextView = UITextView()
    /** Label Internal note */
    var lblInternal: UILabel = UILabel()
    /** Internal value */
    var tbxInternal: UITextView = UITextView()
    var cltviewStep5: UICollectionView! = nil
    
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
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = true
        // Update layout of content view
        let offset: CGFloat = updateLayout(w: w, h: h)
        // Set parent
        self.setParentView(parent: parent)
        
        // List image
        /**
         * Image CollectionView Step 5
         */
        /**
         * add xib file to CollectionView Cell
         */
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0)
        layout.itemSize = CGSize(width: GlobalConst.ACCOUNT_AVATAR_W / 2, height: GlobalConst.ACCOUNT_AVATAR_H / 2)
        self.cltviewStep5 = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        
        let frameworkBundle = Bundle(identifier: DomainConst.HARPY_FRAMEWORK_BUNDLE_NAME)
        self.cltviewStep5.register(UINib(nibName: DomainConst.COLLECTION_IMAGE_VIEW_CELL, bundle: frameworkBundle),
                                   forCellWithReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL)
        cltviewStep5.dataSource = self
        cltviewStep5.delegate = self
        cltviewStep5.alwaysBounceHorizontal = true
        cltviewStep5.bounces = true
        if let layout = cltviewStep5.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        contentView.addSubview(lblReportWrong)
        contentView.addSubview(lblStatus)
        contentView.addSubview(tbxStatus)
        contentView.addSubview(lblTime)
        contentView.addSubview(tbxTime)
        contentView.addSubview(lblReviewer)
        contentView.addSubview(tbxReviewer)
        contentView.addSubview(lblInternal)
        contentView.addSubview(tbxInternal)
        contentView.addSubview(cltviewStep5)
        self.setup(mainView: contentView, title: DomainConst.CONTENT00190, contentHeight: offset,
                   width: w, height: h)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name:NSNotification.Name(rawValue: DomainConst.NOTIFY_NAME_SET_DATA_G01F02),
                                               object: nil)
        return
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return G01F02S06._selectedValue.count
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DomainConst.COLLECTION_IMAGE_VIEW_CELL, for: indexPath) as! CollectionImageViewCell
        cell.imageView.frame  = CGRect(x: 0,  y: 0,  width: GlobalConst.ACCOUNT_AVATAR_H, height: GlobalConst.ACCOUNT_AVATAR_H)
        cell.imageView.image = G01F02S06._selectedValue[indexPath.row]
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
        zoomIMGViewController.imgPicked = G01F02S06._selectedValue[indexPath.row]
        self.getParentView().pushToView(name: DomainConst.ZOOM_IMAGE_VIEW_CTRL)

    }
    func updateData() {
        tbxStatus.text = G01F02S01._selectedValue.name
        tbxTime.text = G01F02S02._selectedValue.name
        tbxReviewer.text = G01F02S04._selectedValue.name + "\n" + G01F02S04._selectedValue.phone
        tbxInternal.text = G01F02S05._selectedValue
        if cltviewStep5 != nil {
            cltviewStep5.reloadData()
        }
        var offset: CGFloat = 0
        // Label Report wrong
        if G01F02S03._selectedValue != nil && !G01F02S03._selectedValue! {
            lblReportWrong.isHidden = false
            offset += GlobalConst.LABEL_HEIGHT
        } else {
            lblReportWrong.isHidden = true
        }
        updateLayout(view: lblStatus, offset: offset)
        updateLayout(view: tbxStatus, offset: offset)
        offset += GlobalConst.LABEL_HEIGHT
        updateLayout(view: lblTime, offset: offset)
        updateLayout(view: tbxTime, offset: offset)
        offset += GlobalConst.LABEL_HEIGHT
        updateLayout(view: lblReviewer, offset: offset)
        updateLayout(view: tbxReviewer, offset: offset)
        offset += GlobalConst.LABEL_HEIGHT * 1.5
        updateLayout(view: lblInternal, offset: offset)
        updateLayout(view: tbxInternal, offset: offset)
        offset += GlobalConst.LABEL_HEIGHT * 2
        //updateLayout(view: cltviewStep5, offset: offset)
        cltviewStep5.translatesAutoresizingMaskIntoConstraints = true
        cltviewStep5.frame = CGRect(x: 0,
                                    y: offset,
                                    width: self.frame.width,
                                    height: GlobalConst.ACCOUNT_AVATAR_H)
        cltviewStep5.backgroundColor = UIColor.white
        cltviewStep5.contentSize = CGSize(
            width: GlobalConst.ACCOUNT_AVATAR_H * (CGFloat)(G01F02S06._selectedValue.count),
            height: GlobalConst.ACCOUNT_AVATAR_H)
        //cltviewStep5.bounds = cltviewStep5.frame
        offset += GlobalConst.ACCOUNT_AVATAR_H
        self.updateLayout(contentHeight: offset)
    }
    
    func updateLayout(view: UIView, offset: CGFloat) {
        view.frame = CGRect(x: view.frame.origin.x, y: offset,
                            width: view.frame.width,
                            height: view.frame.height)
    }
    
    func updateLayout(w: CGFloat, h: CGFloat) -> CGFloat {
        var offset: CGFloat = 0
        lblReportWrong.isHidden = true
        // Label Report wrong
        lblReportWrong.translatesAutoresizingMaskIntoConstraints = true
        lblReportWrong.translatesAutoresizingMaskIntoConstraints = true
        lblReportWrong.frame = CGRect(
            x: GlobalConst.MARGIN_CELL_X,
            y: offset,
            width: w - GlobalConst.MARGIN_CELL_X * 2,
            height: GlobalConst.LABEL_HEIGHT
        )
        lblReportWrong.text               = DomainConst.CONTENT00191
        lblReportWrong.font               = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        if G01F02S03._selectedValue != nil && !G01F02S03._selectedValue! {
            lblReportWrong.isHidden = false
            offset += GlobalConst.LABEL_HEIGHT
        }
        
        // Label Status
        CommonProcess.setLayoutLeft(lbl: lblStatus, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00092)
        lblStatus.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Status value
        CommonProcess.setLayoutRight(lbl: tbxStatus, x: lblStatus.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT, text: G01F02S01._selectedValue.name)
        tbxStatus.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Time
        CommonProcess.setLayoutLeft(lbl: lblTime, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT, text: DomainConst.CONTENT00194)
        lblTime.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Time value
        CommonProcess.setLayoutRight(lbl: tbxTime, x: lblTime.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT, text: G01F02S02._selectedValue.name)
        tbxTime.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT
        
        // Label Reviewer
        CommonProcess.setLayoutLeft(lbl: lblReviewer, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT * 1.5, text: DomainConst.CONTENT00195)
        lblReviewer.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Reviewer value
        CommonProcess.setLayoutRight(lbl: tbxReviewer, x: lblReviewer.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT * 1.5,
                                     text: G01F02S04._selectedValue.name + "\n" + G01F02S04._selectedValue.phone)
        tbxReviewer.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT * 1.5
        
        // Label Intenal
        CommonProcess.setLayoutLeft(lbl: lblInternal, offset: offset,
                                    width: (w - GlobalConst.MARGIN_CELL_X * 2) / 3,
                                    height: GlobalConst.LABEL_HEIGHT * 2, text: DomainConst.CONTENT00151)
        lblInternal.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        // Intenal value
        CommonProcess.setLayoutRight(lbl: tbxInternal, x: lblInternal.frame.maxX, y: offset,
                                     width: (w - GlobalConst.MARGIN_CELL_X * 2) * 2 / 3,
                                     height: GlobalConst.LABEL_HEIGHT * 2, text: G01F02S05._selectedValue)
        tbxInternal.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        offset += GlobalConst.LABEL_HEIGHT * 2
        if cltviewStep5 != nil {
            cltviewStep5.translatesAutoresizingMaskIntoConstraints = true
            cltviewStep5.frame = CGRect(x: 0,
                                        y: offset,
                                        width: w * 2,
                                        height: GlobalConst.ACCOUNT_AVATAR_H)
            offset += GlobalConst.ACCOUNT_AVATAR_H
            cltviewStep5.backgroundColor = UIColor.white
            cltviewStep5.bounds = cltviewStep5.frame
        }
        
        return offset
    }
}
