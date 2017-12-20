//
//  StudentListTableViewController.swift
//  RateMyStudentDB
//
//  Created by Teerapat Thong-o on 20/12/17.
//  Copyright © 2017 Teerapat Thong-o. All rights reserved.
//

import UIKit
import CoreData

class StudentListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var myStudentList : [Student] = []
    var delSearch = true
    
    
    var myFilteredStudentList : [Student] = []
    let mySearchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RateMyStudentDB"
        // เพิ่มโค้ดเพื่อสร้าง SearchBar และกำหนดการแสดงผล
        mySearchController.searchResultsUpdater = self
        mySearchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = mySearchController.searchBar
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func filterStudentContentForSearchText(searchText: String) {
        myFilteredStudentList = myStudentList.filter({ myStudent in return myStudent.StudentName.contains(searchText)})
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterStudentContentForSearchText(searchText: mySearchController.searchBar.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // เคลียร์ Array ก่อนจะแสดงผล
        myStudentList.removeAll()
        
        // สร้าง Object ของ AppDelegate เพื่อเรียกใช้ persistentContainer
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        // สร้างตัวเรียกข้อมูลขึ้นมาจากฐานข้อมูล
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentTB")
        
        do {
            let myFetchResults = try myContext.fetch(myFetchRequest)
            if myFetchResults.count > 0 {
                for myResult in myFetchResults as! [NSManagedObject] {
                    let myStudentName = myResult.value(forKey: "studentName") as! String
                    let myStudentRatingScore = myResult.value(forKey: "studentRatingScore") as! Int
                    let myStudentImage = UIImage(data: myResult.value(forKey: "studentImage") as! Data)!
                    
                    let myStudentInfo = Student(StudentName: myStudentName, StudentRatingScore: myStudentRatingScore, StudentImage: myStudentImage)
                    
                    myStudentList.append(myStudentInfo)
                }
            }
        } catch let error as NSError {
            print(error.description)
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if ((mySearchController.isActive) && (mySearchController.searchBar.text != "")) {
            return myFilteredStudentList.count
        }
        
        return myStudentList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentTableViewCell
        let myStudent : Student
        
        if mySearchController.isActive && mySearchController.searchBar.text != "" {
            myStudent = myFilteredStudentList[indexPath.row]
        } else {
            myStudent = myStudentList[indexPath.row]
        }
        
        // Configure the call
        cell.lblName.text = myStudent.StudentName
        cell.lblScore.text = "\(myStudent.StudentRatingScore)"
        cell.myImage.image = myStudent.StudentImage
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // สร้าง Object ของ AppDelegate เพื่อเรียกใช้ persistentContainer
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        if editingStyle == .delete {
            // ลบข้อมูลในฐานข้อมูล
            // เรียกข้อมูลที่จะลบขึ้นมาจากฐานข้อมูล
            let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentTB")
            
            let myStudent : Student
            if mySearchController.isActive && mySearchController.searchBar.text != "" {
                myStudent = myFilteredStudentList[indexPath.row]
            } else {
                myStudent = myStudentList[indexPath.row]
            }
            // กำหนดเงื่อนไขการดึงข้อมูล
            let myPredicate = NSPredicate(format: "studentName == %@", myStudent.StudentName)
            myFetchRequest.predicate = myPredicate
            
            do {
                let myFetchResults = try myContext.fetch(myFetchRequest)
                if myFetchResults.count > 0 {
                    let myResult = myFetchResults.first as! NSManagedObject
                    
                    // ลบข้อมูลออกจากฐานข้อมูล
                    myContext.delete(myResult)
                }
                
            } catch let error as NSError {
                print(error.description)
            }
            
            // ลบออกจาก Data Source Array
            if mySearchController.isActive && mySearchController.searchBar.text != "" {
                myFilteredStudentList.remove(at: indexPath.row)
            } else {
                myStudentList.remove(at: indexPath.row)
            }
            
            // ลบออกจาก TableView
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try myContext.save()
            } catch let error as NSError {
                print(error.description)
            }
            
            viewWillAppear(true)
            
        }
        /* else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }  */
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "rateSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let myRateStudentVC = segue.destination as! RateStudentViewController
            
            if mySearchController.isActive && mySearchController.searchBar.text != "" {
                myRateStudentVC.theStudent = myFilteredStudentList[indexPath.row]
            } else {
                myRateStudentVC.theStudent = myStudentList[indexPath.row]
            }
        }
    }
    
    
}
