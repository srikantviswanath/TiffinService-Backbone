//
//  OrderConfirmCell.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/5/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import UIKit

class OrderConfirmCell : UITableViewCell {
    
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var UnitPrice: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    @IBOutlet weak var ItemTotal: UILabel!
    
    func configureCell(orderItem: OrderItem){
        self.ItemName.text = orderItem.name
        self.UnitPrice.text = "Unit Price: " + "$" + "\(orderItem.price!)"
        self.Quantity.text = "Qty: " + "\(orderItem.quantity!)"
        self.ItemTotal.text = "Item Total: " + "$" + "\(orderItem.price! * orderItem.quantity!)"
    }

}
