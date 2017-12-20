//
//  AddStudentViewController.swift
//  RateMyStudentDB
//
//  Created by Teerapat Thong-o on 20/12/17.
//  Copyright © 2017 Teerapat Thong-o. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class AddStudentViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var myImageController : UIImagePickerController?
    var isNewImage = false
    

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtStudent: UITextField!
    @IBOutlet weak var txtScore: UITextField!
    
    @IBAction func saveMethod(_ sender: Any) {
        // สร้าง Object ของ AppDelegate เพื่อเรียกใช้ persistentContainer
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        // สร้าง Object ข้อมูล StudentTB
        let newStudent = NSEntityDescription.insertNewObject(forEntityName: "StudentTB", into: myContext)
        newStudent.setValue(txtStudent.text!, forKey: "studentName")
        newStudent.setValue(Int(txtScore.text!), forKey: "studentRatingScore")
        
        let theImageData = UIImagePNGRepresentation(imgView.image!)! as NSData
        newStudent.setValue(theImageData, forKey: "studentImage")
        
        // บันทึกลงฐานข้อมูล
        do {
            try myContext.save()
            print("บันทึกข้อมูลแล้ว!")
        } catch {
            print("ไม่สามารถบันทึกข้อมูลได้")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelMethod(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraMethod(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            myImageController = UIImagePickerController()
            if let theController = myImageController {
                theController.sourceType = .camera
                theController.mediaTypes =  [String(kUTTypeImage)]
                theController.allowsEditing = true
                theController.delegate = self
                present(theController, animated: true, completion: nil)
                isNewImage = true
            }
        } else {
            let alertController = UIAlertController(title: "Camera", message: "ไม่สามารถเปิดกล้องได้", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "ปิดหน้าต่าง", style: .cancel, handler: nil)
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func selectImgMethod(_ sender: Any) {
        myImageController = UIImagePickerController()
        if let theController = myImageController {
            theController.sourceType = .savedPhotosAlbum
            theController.mediaTypes = [String(kUTTypeImage)]
            theController.allowsEditing = true
            theController.delegate = self
            present(theController, animated: true, completion: nil)
            isNewImage = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // ปิด album controller
        picker.dismiss(animated: true, completion: nil)
        
        //นำรูปที่เลือกไปแสดงใน ImageView
        let theImage = info[UIImagePickerControllerEditedImage] as! UIImage
        imgView.image = theImage
        
        // ถ้ารูปใหม่ ก็ทำการเก็บไว้ใน Camera Roll
        if isNewImage {
            UIImageWriteToSavedPhotosAlbum(theImage, self, nil, nil)
            isNewImage = false
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
