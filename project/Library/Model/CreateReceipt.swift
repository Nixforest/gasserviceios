//
//  CreateReceipt.swift
//  dental
//
//  Created by Lâm Phạm on 3/13/18.
//  Copyright © 2018 SPJ. All rights reserved.
//

import UIKit
import harpyframework

class CreateReceipt: MasterModel {
    var status = 0
    var code = 0
    var message = ""
    var data: NSDictionary = NSDictionary()
}
class CreateReceipt_Request: MasterModel {
    var detail_id: String = ""
    var date: String = ""
    var discount: String = ""
    var customer_confirm: String = "0"
    var note: String = ""
    var receiptionist_id: String = "0"
}











