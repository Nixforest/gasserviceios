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
    
    let aResponseTime:[String] = ["0 phút", "5 phút", "10 phút", "15 phút", "20 phút", "25 phút", "30 phút", "35 phút", "40 phút", "45 phút", "50 phút", "55 phút", "1 tiếng", "2 tiếng", "3 tiếng", "4 tiếng ", "5 tiếng", "6 tiếng", "7 tiếng", "8 tiếng", "9 tiếng", "10 tiếng", "11 tiếng", "12 tiếng", "13 tiếng", "14 tiếng", "15 tiếng", "16 tiếng", "17 tiếng", "18 tiếng", "19 tiếng", "20 tiếng", "21 tiếng", "22 tiếng", "23 tiếng", "24 tiếng", "25 tiếng", "26 tiếng", "27 tiếng", "28 tiếng", "29 tiếng", "30 tiếng", "31 tiếng", "32 tiếng", "33 tiếng", "34 tiếng", "35 tiếng", "36 tiếng", "37 tiếng", "38 tiếng", "39 tiếng", "40 tiếng", "41 tiếng", "42 tiếng", "43 tiếng", "44 tiếng", "45 tiếng", "46 tiếng", "47 tiếng", "48 tiếng"]
    
    
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
