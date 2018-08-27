//
//  G07F00S02ExtCell.swift
//  project
//
//  Created by SPJ on 8/24/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
protocol G07CellTextChangeDelegte{
    func updateQuantity(quantity : String, index: Int)
    func updateSeri(seri : String, index: Int)
    func updateShell(shell : String, index: Int)    
    func updateWeight(weight : String, index: Int)

}
class G07F00S02ExtCell: UITableViewCell {
    var index : Int = 0
    var delegate: G07CellTextChangeDelegte?
    @IBOutlet weak var lblMaterialName: UILabel!
    
    @IBOutlet weak var tfQuantity: UITextField!
    
    @IBOutlet weak var tfQuantityWidth: NSLayoutConstraint!
    @IBOutlet weak var materialViewHeight: NSLayoutConstraint!
    @IBOutlet weak var MaterialView: UIView!
    @IBOutlet weak var materialViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imgGiftWidth: NSLayoutConstraint!
    @IBOutlet weak var imgGift: UIImageView!
    @IBOutlet weak var tfSeri: UITextField!
    @IBOutlet weak var lblPriceWidth: NSLayoutConstraint!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var tfWeight: UITextField!
    @IBOutlet weak var tfShell: UITextField!
    
    @IBAction func seriEdittingChanged(_ sender: Any) {
        delegate?.updateSeri(seri: tfSeri.text!, index: index)
    }
    
    @IBAction func shellEdittingChanged(_ sender: Any) {
        delegate?.updateShell(shell: tfShell.text!, index: index)
        
    }
    
    @IBAction func weightEdittingChanged(_ sender: Any) {
        delegate?.updateWeight(weight: tfWeight.text!, index: index)
    }
    
    @IBAction func quantityEdittingChanged(_ sender: Any) {
        delegate?.updateQuantity(quantity: tfQuantity.text!, index: index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*tfSeri.delegate = self
        tfShell.delegate = self
        tfWeight.delegate = self
        tfQuantity.delegate = self*/
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
