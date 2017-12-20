//
//  ViewController.swift
//  MyShoppingList
//
//  Created by user on 9/30/2560 BE.
//  Copyright © 2560 teerapat. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController,
    UITableViewDataSource, UITableViewDelegate,
    ShoppingItemViewControllerDelegate {
    
    var myShoppingList : [ShoppingItem] = []
    
@IBOutlet weak var myTableView: UITableView!
    
    
    
    // MARK: - ShoppingItemViewControllerDelegate
    func addShoppingItem(newShoppingItem : ShoppingItem){
        myShoppingList.append(newShoppingItem)
        myTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func cancelShoppingItem(){
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - TableViewDataSource + Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //แก้ไข
    func tableView(_ tableView: UITableView, canMoveRowAt
        indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt
        sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempShoppingItem = myShoppingList[sourceIndexPath.row]
        myShoppingList.remove(at: sourceIndexPath.row)
        myShoppingList.insert(tempShoppingItem, at:
            destinationIndexPath.row)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        let myVC = segue.destination as! ShoppingItemViewController
        if segue.identifier == "NewItem"{
            myVC.myNewItem = -1
        }
        else{
            let indexPath = myTableView.indexPathForSelectedRow!
            myVC.myShoppingItem = myShoppingList[indexPath.row]
            myVC.myNewItem = indexPath.row
        }
        myVC.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        return myShoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "Cell", for: indexPath)
        
        // Configure the cell...
        let myShoppingDetail = "จํานวน \(myShoppingList[indexPath.row].shoppingProductNumber) @\(myShoppingList[indexPath.row].shoppingProductUnitPrice) บาท"
        cell.textLabel?.text =
        myShoppingList[indexPath.row].shoppingProductName
        cell.detailTextLabel?.text = myShoppingDetail
        
        return cell
    }
    
   
    // Override to support conditional editing of the table view.
     func tableView(_ tableView: UITableView, canEditRowAt
        indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCellEditingStyle, forRowAt indexPath:
        IndexPath) {
        if editingStyle == .delete {
            //ลบข้อมูลออกจาก Array
            myShoppingList.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - ShoppingItemViewControllerDelegate
    func addShoppingItem(newShoppingItem : ShoppingItem, newItem :
        Int){
        if newItem == -1 {
            myShoppingList.append(newShoppingItem)
        }
        else{
            myShoppingList[newItem] = newShoppingItem
        }
        myTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyShoppingList"
        myTableView.delegate = self
        myTableView.dataSource = self
        self.navigationItem.leftBarButtonItem = editButtonItem
        
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        myTableView.setEditing(editing, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



