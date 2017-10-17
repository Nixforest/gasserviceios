//
//  G12F01S03VC.swift
//  project
//
//  Created by SPJ on 9/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G12F01S03VC: ChildExtViewController {
    // MARK: Properties
    /** Current data */
    var _data:          [OrderDetailBean]   = [OrderDetailBean]()
    /** Collection view */
    var _cltMaterial:   UICollectionView!   = nil
    /** Title label */
    var _lblTitle:      UILabel             = UILabel()
    
    // MARK: Static values
    // MARK: Constant
    let TITLE_LABEL_HEIGHT                  = GlobalConst.LABEL_H * 2
    // MARK: Override methods
    /**
     * Called after the controller's view is loaded into memory.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createNavigationBar(title: DomainConst.CONTENT00524)
    }
    
    /**
     * Handle update constants
     */
    override func updateConst() {
        super.updateConst()
    }
    
    /**
     * Create children views
     */
    override func createChildrenViews() {
        super.createChildrenViews()
        createTitleLabel()
        createCollectionView()
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                break
            default:
                break
            }
            
            break
        default:
            break
        }
        self.view.addSubview(_lblTitle)
        self.view.addSubview(_cltMaterial)
    }
    
    /**
     * Update children views
     */
    override func updateChildrenViews() {
        super.updateChildrenViews()
        updateTitleLabel()
        updateCollectionView()
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                break
            default:
                break
            }
            
            break
        default:
            break
        }
    }
    
    // MARK: Event handler
    
    // MARK: Utilities
    /**
     * Get column number of collection view
     * - returns: Number of column base on current device type and orientation
     */
    private func getColumnNumber() -> Int {
        var retVal = 1
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            retVal = 3
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                retVal = 5
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                retVal = 8
                break
            default:
                break
            }
            
            break
        default:
            break
        }
        return retVal
    }
    
    private func getRowNumber() -> Int {
        var retVal = 1
        // Get current device type
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:        // iPhone
            retVal = 2
            break
        case .pad:          // iPad
            switch UIApplication.shared.statusBarOrientation {
            case .portrait, .portraitUpsideDown:        // Portrait
                retVal = 3
                break
            case .landscapeLeft, .landscapeRight:       // Landscape
                retVal = 2
                break
            default:
                break
            }
            
            break
        default:
            break
        }
        return retVal
    }
    
    func getCellWidth() -> CGFloat {
        return UIScreen.main.bounds.width / CGFloat(getColumnNumber() + 1)
    }
    
    func getCellHeight() -> CGFloat {
        return (UIScreen.main.bounds.height - _lblTitle.frame.maxY) / CGFloat(getRowNumber()) - GlobalConst.MARGIN
    }
    
    public func setData(data: [MaterialBean]) {
        for item in data {
            _data.append(OrderDetailBean(data: item))
        }
    }
    
    public func handleSelectCell(cell: MaterialCollectionViewCell,
                                 bean: OrderDetailBean) {
        cell.select(isSelected: (G12F01S01VC._gasSelected.material_id == bean.material_id))
    }
    
    // MARK: Title label
    public func createTitleLabel() {
        _lblTitle.frame = CGRect(x: 0,
                                 y: getTopHeight(),
                                 width: UIScreen.main.bounds.width,
                                 height: TITLE_LABEL_HEIGHT)
        _lblTitle.text = DomainConst.CONTENT00523
        _lblTitle.textAlignment = .center
        _lblTitle.textColor = UIColor.black
        _lblTitle.font = GlobalConst.BASE_FONT
        _lblTitle.lineBreakMode = .byWordWrapping
        _lblTitle.numberOfLines = 0
    }
    
    public func updateTitleLabel() {
        CommonProcess.updateViewPos(
            view: _lblTitle,
            x: 0, y: getTopHeight(),
            w: UIScreen.main.bounds.width,
            h: TITLE_LABEL_HEIGHT)
    }
    
    // MARK: Collection view
    private func createCollectionView() {
        // Create layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 0, left: GlobalConst.MARGIN,
            bottom: 0, right: GlobalConst.MARGIN)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(
            width: getCellWidth(),
            height: getCellHeight())
        
        // Create collection view
        let height = UIScreen.main.bounds.height - _lblTitle.frame.maxY
        _cltMaterial = UICollectionView(
            frame: CGRect(x: 0, y: _lblTitle.frame.maxY,
                          width: UIScreen.main.bounds.width,
                          height: height),
            collectionViewLayout: layout)
        _cltMaterial.register(MaterialCollectionViewCell.self,
                              forCellWithReuseIdentifier: "Cell")
        _cltMaterial.dataSource = self
        _cltMaterial.delegate   = self
        _cltMaterial.alwaysBounceVertical   = true
        _cltMaterial.bounces                = true
        if let currentLayout = _cltMaterial.collectionViewLayout as? UICollectionViewFlowLayout {
            currentLayout.scrollDirection = .vertical
        }
        _cltMaterial.backgroundColor = UIColor.white
        _cltMaterial.contentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: height)
    }
    
    private func updateCollectionView() {
        let height = UIScreen.main.bounds.height - _lblTitle.frame.maxY
        _cltMaterial.frame = CGRect(x: 0, y: _lblTitle.frame.maxY,
                                    width: UIScreen.main.bounds.width,
                                    height: height)
        _cltMaterial.contentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: height)
    }
}

// MARK: Protocol - UICollectionViewDataSource
extension G12F01S03VC: UICollectionViewDataSource {
    /**
     * Asks your data source object for the number of items in the specified section.
     */
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.count
    }
    
    /**
     * Asks your data source object for the cell that corresponds to the specified item in the collection view.
     */
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath) as! MaterialCollectionViewCell
        cell.setData(data: _data[indexPath.row],
                     width: getCellWidth() + 1, height: getCellHeight() + 1)
        handleSelectCell(cell: cell, bean: _data[indexPath.row])
        return cell
    }
}

// MARK: Protocol - UICollectionViewDelegateFlowLayout
extension G12F01S03VC: UICollectionViewDelegateFlowLayout {
    /**
     * Asks the delegate for the size of the specified item’s cell.
     */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: getCellWidth(),
                      height: getCellHeight())
    }
    
    /**
     * Asks the delegate for the spacing between successive rows or columns of a section.
     */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GlobalConst.MARGIN
    }
}

// MARK: Protocol - UICollectionViewDelegate
extension G12F01S03VC: UICollectionViewDelegate {
    /**
     * Tells the delegate that the item at the specified index path was selected.
     */
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        G12F01S01VC._gasSelected = _data[indexPath.row]
        self.backButtonTapped(self)
    }
}
