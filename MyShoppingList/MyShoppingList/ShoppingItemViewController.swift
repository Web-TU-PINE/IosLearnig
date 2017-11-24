//
//  ShoppingItemViewController.swift
//  MyShoppingList
//
//  Created by user on 9/30/2560 BE.
//  Copyright © 2560 ANT. All rights reserved.
//

import UIKit

protocol ShoppingItemViewControllerDelegate {
    func addShoppingItem(newShoppingItem : ShoppingItem, newItem : Int)
    func cancelShoppingItem()
}

class ShoppingItemViewController: UIViewController {
    
    var delegate : ShoppingItemViewControllerDelegate?
    
    var myShoppingItem : ShoppingItem?
    var myNewItem : Int = 0
    
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtProductNumber: UITextField!
    @IBOutlet weak var txtProductUnitPrice: UITextField!
    @IBAction func saveMethod() {
        
        //ซ่อน Virtual Keyboard
        txtProductName.resignFirstResponder()
        txtProductNumber.resignFirstResponder()
        txtProductUnitPrice.resignFirstResponder()
        
        //ทําการตัดช่องว่าง
        let trimProductName = txtProductName.text?.trimmingCharacters(in: .whitespaces)
        let trimProductNumber = txtProductNumber.text?.trimmingCharacters(in: .whitespaces)
        let trimProductUnitPrice = txtProductUnitPrice.text?.trimmingCharacters(in: .whitespaces)
        
        if ((trimProductName?.characters.isEmpty)! ||
            (trimProductNumber?.characters.isEmpty)! ||
            (trimProductUnitPrice?.characters.isEmpty)!){
            
            //#1. สร้าง AlertController Object
            let alertController = UIAlertController(title:
                "MyShoppingList", message: "กรุณากรอกข้อมูล Shopping Item ให้ครบถ้วน",
                                  preferredStyle: .alert)
            
            //#2. สร้าง Button (Action) บน AlertController
            let cancelButton = UIAlertAction(title: "ปิดหน้าต่าง",
                                             style: .cancel, handler: nil)
            let clearButton = UIAlertAction(title: "เคลียร์ข้อมูล",
                                            style: .default, handler: { (action) in
                                                self.txtProductName.text = ""
                                                self.txtProductNumber.text = ""
                                                self.txtProductUnitPrice.text = ""
            })
            
            //#3. เพิ่ม Button ลงไปใน AlertController Object
            alertController.addAction(cancelButton)
            alertController.addAction(clearButton)
            
            //#4. แสดง AlertController Object
            self.present(alertController, animated: true,
                         completion: nil)
        }else{
            if myShoppingItem == nil {
                //สร้างใหม่
                myShoppingItem = ShoppingItem()
            }
                
        
        
        //อ่านค่าจาก TextField
        myShoppingItem?.shoppingProductName = txtProductName.text!
        myShoppingItem?.shoppingProductNumber =
            Int(txtProductNumber.text!)!
        myShoppingItem?.shoppingProductUnitPrice =
            Double(txtProductUnitPrice.text!)!
        
        //เรียกผู้ช่วยให้มาทํางานให้
        delegate?.addShoppingItem(newShoppingItem: myShoppingItem!,newItem: myNewItem)
        }}
    
    @IBAction func cancelMethod() {
        //เรียกผู้ช่วยให้มาทํางานให้
        delegate?.cancelShoppingItem()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let v = myShoppingItem {
            txtProductName.text = v.shoppingProductName
            txtProductNumber.text = "\(v.shoppingProductNumber)"
            txtProductUnitPrice.text = "\(v.shoppingProductUnitPrice)"
            
        }
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
