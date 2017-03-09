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
    
    func configureCell(orderItemVM: OrderItemVM){
        self.ItemName.text = orderItemVM.name
        self.UnitPrice.text = orderItemVM.price
        self.Quantity.text = orderItemVM.quantity
        self.ItemTotal.text = orderItemVM.itemTotal
    }

}
