//
//  OrderReceivedByPeopleCell.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/21/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import UIKit

class OrderReceivedByPeopleCell: UITableViewCell {
    
    @IBOutlet weak var UsernameLbl: UILabel!
    @IBOutlet weak var ItemsOrderedLbl: UILabel!
    
    func configureCell(orderVM: OrderVM) {
        self.UsernameLbl.text = orderVM.userName
        self.ItemsOrderedLbl.text = orderVM.containees.map{$0.quantity + " " + $0.name}.joined(separator: ", ")
    }
    
}
