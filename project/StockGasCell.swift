//
//  StockGasCell.swift
//  project
//
//  Created by SPJ on 7/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import harpyframework  

protocol TextChangeDelegte{
    func UpdateSeri(seri : String, index: Int)
    func didBeginEdit()
}
class StockGasCell: UITableViewCell {

    @IBOutlet weak var lblNo: UILabel!
    var index :                 Int = 0
    var delegate:               TextChangeDelegte?
    @IBOutlet weak var tfNo:    UITextField!
    @IBOutlet weak var lblName: UILabel!
    @IBAction func tf_No_Change(_ sender: Any) {
        delegate?.UpdateSeri(seri: tfNo.text!, index: index)
    }
    
    @IBAction func didbeginEditS03(_ sender: Any) {
        delegate?.didBeginEdit()
    }
    @IBAction func didBeginEditSeri(_ sender: Any) {
        delegate?.didBeginEdit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
