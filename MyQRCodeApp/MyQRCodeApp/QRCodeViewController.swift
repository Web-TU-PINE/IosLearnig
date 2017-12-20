//
//  QRCodeViewController.swift
//  MyQRCodeApp
//
//  Created by DrKeng on 9/25/2560 BE.
//  Copyright © 2560 ANT. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var txtContent: UITextField!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var myButton: UIButton!
    
    var qrCodeImage : CIImage?
    
    @IBAction func qrCodeGenerateMethod() {
        if qrCodeImage == nil {
            if !(txtContent.text?.isEmpty)!{
                //แปลงข้อความตัวอักษรให้เป็น Data
                let data = txtContent.text?.data(using: .utf8)
                
                //สร้าง Filter จาก CoreImage ให้เป็น CIQrCodeGenerator
                let filter = CIFilter(name: "CIQRCodeGenerator")
                filter?.setValue(data, forKey: "inputMessage")
                filter?.setValue("Q", forKey: "inputCorrectionLevel")
                //L,M,Q,H เป็นการกำหนดความยืดหยุ่น (Resilience) ต่อ Error
                
                qrCodeImage = filter?.outputImage
                
                //ปรับความชัดเจนของ qrCodeImage โดยดูสัดส่วนของความกว่้างและความสูง
                let scaleX = imgQRCode.frame.size.width / (qrCodeImage?.extent.size.width)!
                let scaleY = imgQRCode.frame.size.height / (qrCodeImage?.extent.size.height)!
                let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                let adjustedQRCodeImage = qrCodeImage?.transformed(by: transform)
                
                imgQRCode.image = UIImage(ciImage: adjustedQRCodeImage!)
                txtContent.resignFirstResponder()
                myButton.setTitle("เคลียร์ QR Code", for: .normal)
            }
        }
        else{
            imgQRCode.image = nil
            qrCodeImage = nil
            txtContent.text = ""
            myButton.setTitle("สร้าง QR Code", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

