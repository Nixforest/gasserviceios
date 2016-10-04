//
//  ReplyUpholdStep1ViewController.swift
//  project
//
//  Created by Lâm Phạm on 10/2/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ReplyUpholdStep1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    static let sharedInstance: ReplyUpholdStep1ViewController = {
//        let instance = ReplyUpholdStep1ViewController()
//        return instance
//    }()

    var infoStep1 = String()
    
    let aResponseTime:[String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    
    
    @IBOutlet weak var lblStep1: UILabel!
    @IBOutlet weak var pkviewStep1: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        lblStep1.translatesAutoresizingMaskIntoConstraints = true
        lblStep1.frame = CGRect(x: 0, y: 0, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.LABEL_HEIGHT)
        lblStep1.text = "Xin vui lòng chọn Thời lượng xử lý"
        lblStep1.textAlignment = NSTextAlignment.center
        lblStep1.backgroundColor = GlobalConst.BACKGROUND_COLOR_GRAY
        
        pkviewStep1.translatesAutoresizingMaskIntoConstraints = true
        pkviewStep1.frame = CGRect(x: 0, y: GlobalConst.PARENT_BORDER_WIDTH + lblStep1.frame.size.height, width: GlobalConst.SCREEN_WIDTH, height: GlobalConst.SCREEN_HEIGHT / 3)
        pkviewStep1.backgroundColor = UIColor.black
        

        pkviewStep1.dataSource = self
        pkviewStep1.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Picker Delegate
    public func pickerView(_ pkviewStep1: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let width:CGFloat
        width = GlobalConst.SCREEN_WIDTH - GlobalConst.PARENT_BORDER_WIDTH
        return width
    }
    public func pickerView(_ pkviewStep1: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let height:CGFloat
        height = GlobalConst.BUTTON_HEIGHT
        return height
    }
    public func pickerView(_ pkviewStep1: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return aResponseTime[row]
    }
    public func pickerView(_ pkviewStep1: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        ReplyUpholdViewController.valStep1 = aResponseTime[row]
        print(ReplyUpholdViewController.valStep1)
    }
    func pickerView(_ pkviewStep1: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: aResponseTime[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    // MARK: - Picker DataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pkviewStep1: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return aResponseTime.count
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
