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
    
    @IBOutlet weak var lblTenVatTu: UILabel!
    @IBOutlet weak var lblSoLuong: UITextField!
    
    @IBAction func tf_Quantity_Edit(_ sender: Any) {
        if(lblSoLuong.text! != ""){
            let quantity : Int = Int(lblSoLuong.text!)!
            if quantity < 0 {
                btnReduce.isHidden = true
                lblSoLuong.text = "0"
            }
            else if quantity > 99 {
                lblSoLuong.text = "99"
                btnIncrease.isHidden = true
            }
            else{
                btnReduce.isHidden = false
                btnIncrease.isHidden = false
            }
            
        }
        else{
            btnReduce.isHidden = true
            lblSoLuong.text = "0"
        }
        delegate?.UpdateQuantity(quantity: lblSoLuong.text!, index: index)
    }
    
    
    @IBAction func tf_Quantity_Changed(_ sender: Any) {
        let quantity : Int = Int(lblSoLuong.text!)!
        if(quantity == 0){
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
        var quantity: Int = Int(lblSoLuong.text!)!
        quantity += 1
        lblSoLuong.text = String(quantity)
        lblSoLuong.sendActions(for: UIControlEvents.valueChanged)
    }
    
    @IBAction func btn_Reduce(_ sender: Any) {
        var quantity: Int = Int(lblSoLuong.text!)!
        quantity -= 1
        lblSoLuong.text = String(quantity)
        lblSoLuong.sendActions(for: UIControlEvents.valueChanged)
    }
    @IBOutlet weak var btn_Reduce: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
