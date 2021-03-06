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
    func didBeginEdit()
}
class MaterialCell: UITableViewCell, UITextFieldDelegate {

    var index : Int = 0
    @IBOutlet weak var lblMaterialName: UILabel!
    @IBOutlet weak var btnReduce: UIButton!
    @IBOutlet weak var btnIncreate: UIButton!
    @IBOutlet weak var tf_quantity: UITextField!
    var delegate: CellTextChangeDelegte?
    
    @IBAction func didBeginEdit(_ sender: Any) {
        delegate?.didBeginEdit()
    }
    
    // editting change
    @IBAction func tf_Quantity_Changed(_ sender: Any) {
        if(tf_quantity.text! != ""){
            if let quantity = Int(tf_quantity.text!){
                if quantity < 2 {
                    btnReduce.isHidden = true
                    tf_quantity.text = "1"
                }
                else if quantity > 999998 {
                    tf_quantity.text = "999999"
                    btnIncreate.isHidden = true
                }
                else{
                    btnReduce.isHidden = false
                    btnIncreate.isHidden = false
                }
            }
        }
        else{
            btnReduce.isHidden = true
            //tf_quantity.text = "1"
        }
        delegate?.UpdateQuantity(quantity: tf_quantity.text!, index: index)
    }
    //end edit quantity
    @IBAction func did_end(_ sender: Any) {
        if(tf_quantity.text! == ""){
            tf_quantity.text = "1"
        }
        delegate?.UpdateQuantity(quantity: tf_quantity.text!, index: index)
    }
    //value change
    @IBAction func tf_Quantity_Changed() {
        let quantity : Int = Int(tf_quantity.text!)!
        if(quantity == 1){
            btnReduce.isHidden = true
        }
        else if(quantity == 999999){
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
        if tf_quantity.text == ""{
            tf_quantity.text = "1"
        }
        else{
            var quantity: Int = Int(tf_quantity.text!)!
            quantity -= 1
            tf_quantity.text = String(quantity)
        }
        tf_quantity.sendActions(for: UIControlEvents.valueChanged)
    }
    @IBAction func btn_Increase(_ sender: Any) {
        if tf_quantity.text == ""{
            tf_quantity.text = "1"
        }
        else{
            var quantity: Int = Int(tf_quantity.text!)!
            quantity += 1
            tf_quantity.text = String(quantity)
        }
        tf_quantity.sendActions(for: UIControlEvents.valueChanged)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tf_quantity.delegate = self
    }
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nsString = NSString(string: textField.text!)
        let newText = nsString.replacingCharacters(in: range, with: string)
        return  newText.count <= 5
    }*/
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
