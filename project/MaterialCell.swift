//
//  MaterialCell.swift
//  project
//
//  Created by SPJ on 7/18/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework  

protocol CellTextChangeDelegte{
    func UpdateQuantity(quantity : String, index: Int)
}
class MaterialCell: UITableViewCell {

    var index : Int = 0
    @IBOutlet weak var lblMaterialName: UILabel!
    
    @IBOutlet weak var btnReduce: UIButton!
    @IBOutlet weak var btnIncreate: UIButton!
    @IBOutlet weak var tf_quantity: UITextField!
    var delegate: CellTextChangeDelegte?
    
    // editting change
    @IBAction func tf_Quantity_Changed(_ sender: Any) {
        if(tf_quantity.text! != ""){
            let quantity : Int = Int(tf_quantity.text!)!
            if quantity < 0 {
                btnReduce.isHidden = true
                tf_quantity.text = "0"
            }
            else if quantity > 99 {
                tf_quantity.text = "99"
                btnIncreate.isHidden = true
            }
            else{
                btnReduce.isHidden = false
                btnIncreate.isHidden = false
            }
        }
        else{
            btnReduce.isHidden = true
            tf_quantity.text = "0"
        }
        delegate?.UpdateQuantity(quantity: tf_quantity.text!, index: index)
    }
    /*@IBAction func tf_Quantity_Editted(_ sender: Any) {
        if(tf_quantity.text! != ""){
            let quantity : Int = Int(tf_quantity.text!)!
            if quantity < 0 {
                btnReduce.isHidden = true
                tf_quantity.text = "0"
                }
            else if quantity > 99 {
                tf_quantity.text = "99"
                btnIncreate.isHidden = true
                }
            else{
                btnReduce.isHidden = false
                btnIncreate.isHidden = false
            }
        }
        else{
            btnReduce.isHidden = true
            tf_quantity.text = "0"
        }
        delegate?.UpdateQuantity(quantity: tf_quantity.text!, index: index)
        
    }*/
    //value change
    @IBAction func tf_Quantity_Changed() {
        let quantity : Int = Int(tf_quantity.text!)!
        if(quantity == 0){
            btnReduce.isHidden = true
        }
        else if(quantity == 99){
            btnIncreate.isHidden = true
        }
        else{
            btnReduce.isHidden = false
            btnIncreate.isHidden = false
        }
        delegate?.UpdateQuantity(quantity: String(quantity), index: index)

    }
    
    @IBAction func btn_Reduce(_ 
        sender: Any) {
        var quantity: Int = Int(tf_quantity.text!)!
        quantity -= 1
        tf_quantity.text = String(quantity)
        tf_quantity.sendActions(for: UIControlEvents.valueChanged)
    }
    @IBAction func btn_Increase(_ sender: Any) {
        var quantity: Int = Int(tf_quantity.text!)!
        quantity += 1
        tf_quantity.text = String(quantity)
        tf_quantity.sendActions(for: UIControlEvents.valueChanged)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        //lblMaterialName.text = "asdfklasdfksafjsalkfdjlkasdfalskdfj"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
