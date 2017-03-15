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
    @IBOutlet weak var QtyOrdered: UILabel!
    @IBOutlet weak var ItemTotal: UILabel!
    @IBOutlet weak var QtyStepper: UIStepper!
    
    var viewModelDelegate: OrderItemVM!
    
    @IBAction func QtyStepperPressed(sender: UIStepper) {
        self.QtyOrdered.text = Int(QtyStepper.value).description
        self.viewModelDelegate.quantity = self.QtyOrdered.text!
        self.ItemTotal.text = self.viewModelDelegate.itemTotal
    }

    
    func configureCell(orderItemVM: OrderItemVM){
        self.ItemName.text = orderItemVM.name
        self.UnitPrice.text = orderItemVM.price
        self.QtyOrdered.text = orderItemVM.quantity
        self.ItemTotal.text = orderItemVM.itemTotal
    }

}
