//
//  MaterialCell2.swift
//  project
//
//  Created by SPJ on 7/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MaterialCell2: UITableViewCell {
    var index : Int = 0
    var delegate: CellTextChangeDelegte?
    @IBOutlet weak var lblMaterialName: UILabel!
    @IBOutlet weak var tfQuantity: UITextField!
    @IBAction func didBeginEditQuantity(_ sender: Any) {
        delegate?.didBeginEdit()
    }
    @IBAction func tf_Quantity_Edit(_ sender: Any) {
        if(tfQuantity.text! != ""){
            if let quantity = Int(tfQuantity.text!){
                if quantity < 2 {
                    btnReduce.isHidden = true
                    tfQuantity.text = "1"
                }
                else if quantity > 98 {
                    tfQuantity.text = "99"
                    btnIncrease.isHidden = true
                }
                else{
                    btnReduce.isHidden = false
                    btnIncrease.isHidden = false
                }
            }
        }
        else{
            btnReduce.isHidden = true
            tfQuantity.text = "1"
        }
        delegate?.UpdateQuantity(quantity: tfQuantity.text!, index: index)
    }
    
    @IBAction func tf_Quantity_Changed(_ sender: Any) {
        let quantity : Int = Int(tfQuantity.text!)!
        if(quantity == 1){
            btnReduce.isHidden = true
        }
        else if(quantity == 99){
            btnIncrease.isHidden = true
        }
        else{
            btnReduce.isHidden = false
            btnIncrease.isHidden = false
        }
        delegate?.UpdateQuantity(quantity: String(quantity), index: index)

    }
    @IBOutlet weak var btnIncrease: UIButton!
    
    @IBOutlet weak var btnReduce: UIButton!
    
    @IBAction func btn_Increase(_ sender: Any) {
        var quantity: Int = Int(tfQuantity.text!)!
        quantity += 1
        tfQuantity.text = String(quantity)
        tfQuantity.sendActions(for: UIControlEvents.valueChanged)
    }
    
    @IBAction func btn_Reduce(_ sender: Any) {
        var quantity: Int = Int(tfQuantity.text!)!
        quantity -= 1
        tfQuantity.text = String(quantity)
        tfQuantity.sendActions(for: UIControlEvents.valueChanged)
    }
    @IBOutlet weak var btn_Reduce: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
