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
    var viewControllerDelegate: OrderConfirmVC!
    
    var preStepperQty: Int!
    
    @IBAction func QtyStepperPressed(sender: UIStepper) {
        let newQty = Int(QtyStepper.value).description
        self.QtyOrdered.text = newQty
        self.viewModelDelegate.quantity = self.QtyOrdered.text!
        self.ItemTotal.text = self.viewModelDelegate.itemTotal
        self.updateVCItemTotal(oldQty: self.preStepperQty, newQty: Int(newQty)!)
    }

    
    func configureCell(orderItemVM: OrderItemVM){
        self.ItemName.text = orderItemVM.name
        self.UnitPrice.text = orderItemVM.price
        self.QtyOrdered.text = orderItemVM.quantity
        self.preStepperQty = Int(orderItemVM.quantity)
        self.ItemTotal.text = orderItemVM.itemTotal
    }
    
    func updateVCItemTotal(oldQty: Int, newQty: Int) {
        self.preStepperQty = newQty
        if !(newQty == 0 && oldQty == 0) {
            if newQty > oldQty {
                self.viewControllerDelegate.orderTotalLbl.text = "$" + "\(Int(String(UnitPrice.text!.characters.dropFirst()))! + Int(String(viewControllerDelegate.orderTotalLbl.text!.characters.dropFirst()))!)"
            } else {
                self.viewControllerDelegate.orderTotalLbl.text = "$" + "\(Int(String(viewControllerDelegate.orderTotalLbl.text!.characters.dropFirst()))! - Int(String(UnitPrice.text!.characters.dropFirst()))!)"
            }
        }
    }

}
