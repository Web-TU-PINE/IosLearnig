//
//  BMICalculatorViewController.swift
//  BMICalculator
//
//  Created by user on 11/24/2560 BE.
//  Copyright © 2560 teerapat. All rights reserved.
//

import UIKit

class BMICalculatorViewController: UIViewController {

    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtViewResult: UITextView!
    
    func bmiResultInterpretatio(bmiValue :Double) -> String{
        var result : String = " ค่า BMI  = \(bmiValue) \n"
        if bmiValue >= 40.0 {
            result += "พบแพทย์ด่วนไอสัส"
        }else if bmiValue >= 35.0 {
            result += "ไม่เบาหวานก็ความดันนะมึง"
        }else if bmiValue >= 28.5 {
            result += "เสี่ยงนะไอสัส"
        }else if bmiValue >= 23.5 {
            result += "น้ำหนักเกินหวะ ตวยเอ้ยยยยย"
        }else if bmiValue >= 18.5 {
            result += "ปกติเส้ย ชิวๆ"
        }else {
            result += "หัดแดกไรมั้งนะสัส"
        }
        txtWeight.text = ""
        txtHeight.text = ""
        
        return result
    }
    @IBAction func clearContentMethod(_ sender: Any) {
        txtWeight.text = ""
        txtHeight.text = ""
    }
    
    @IBAction func bmiCalculationMethod(_ sender: Any) {
            let myWeight = Double(txtWeight.text!)!
            let myHeight = Double(txtHeight.text!)! / 100.0
            let myBMIResult = myWeight / (myHeight * myHeight)
            txtViewResult.text = bmiResultInterpretatio(bmiValue: myBMIResult)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Back"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // เก็บ keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with   event: UIEvent?) {
        self.view.endEditing(true)
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
