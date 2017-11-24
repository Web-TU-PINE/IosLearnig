//
//  ShoppingItem.swift
//  MyShoppingList
//
//  Created by user on 9/30/2560 BE.
//  Copyright © 2560 ANT. All rights reserved.
//

import UIKit

class ShoppingItem: NSObject {
    var shoppingProductName : String
    var shoppingProductNumber : Int
    var shoppingProductUnitPrice : Double
    
    override init() {
        self.shoppingProductName = ""
        self.shoppingProductNumber = 0
        self.shoppingProductUnitPrice = 0.0
    }
    
    init(shoppingProductName : String, shoppingProductNumber : Int,
         shoppingProductUnitPrice : Double) {
        self.shoppingProductName = shoppingProductName
        self.shoppingProductNumber = shoppingProductNumber
        self.shoppingProductUnitPrice = shoppingProductUnitPrice
    }
}
