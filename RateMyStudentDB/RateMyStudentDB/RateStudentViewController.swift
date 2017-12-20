//
//  ViewController.swift
//  RateMyStudentDB
//
//  Created by Teerapat Thong-o on 20/12/17.
//  Copyright © 2017 Teerapat Thong-o. All rights reserved.
//

import UIKit
import CoreData

class RateStudentViewController: UIViewController {
    
    var theStudent : Student = Student()
    

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblRatingScore: UILabel!
    
    
    @IBAction func addScoreMethod(_ sender: Any) {
        theStudent.addRatingScore(ratingScore: 10)
        saveStudentRecord()
    }
    @IBAction func minusScoreMethod(_ sender: Any) {
        theStudent.minusRatingScore(ratingScore: 10)
        saveStudentRecord()
    }
    @IBAction func resetScoreMethod(_ sender: Any) {
        theStudent.resetRatingScore()
        saveStudentRecord()
    }
    
    func saveStudentRecord() -> Void {
        // สร้าง Object ของ AppDelegate เพื่อเรียกใช้ persistentContainer
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        // เรียกข้อมูลที่จะ update ขึ้นมาจากฐานข้อมูล
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentTB")
        
        // กำหนดเงื่อนไขการดึงข้อมูล
        let myPredicate = NSPredicate(format: "studentName == %@", theStudent.StudentName)
        myFetchRequest.predicate = myPredicate
        do {
            let myFetchResults = try myContext.fetch(myFetchRequest)
            if myFetchResults.count > 0 {
                let myResult = myFetchResults.first as! NSManagedObject
                
                // ปรับปรุงข้อมูลใน Object
                myResult.setValue(theStudent.StudentName, forKey: "studentName")
                myResult.setValue(theStudent.StudentRatingScore, forKey: "studentRatingScore")
                
                let theImageData = UIImagePNGRepresentation(theStudent.StudentImage)! as NSData
                myResult.setValue(theImageData, forKey: "studentImage")
            }
        } catch let error as NSError {
            print(error.description)
        }
        
        // บันทึกการ Update ข้อมูลลงในฐานข้อมูล
        do {
            try myContext.save()
        } catch let error as NSError {
            print(error.description)
        }
        
        // กลับไปหน้าหลัก ต้องการใช้ Guard เพื่อป้องกันการ popViewController โดบไม่มี NavigationController
        guard ((navigationController?.popViewController(animated: true)) != nil ) else {
            print("No Navigation Controller")
            return
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = theStudent.StudentName
        imgView.image = theStudent.StudentImage
        lblRatingScore.text = "\(theStudent.StudentRatingScore)"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

