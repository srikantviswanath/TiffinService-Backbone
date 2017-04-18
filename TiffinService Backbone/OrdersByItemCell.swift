//
//  OrdersByItemCell.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 4/18/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import UIKit

class OrdersByItemCell: UITableViewCell {
    
    @IBOutlet weak var ItemCountLbl: UILabel!
    @IBOutlet weak var ItemNameLbl: UILabel!
    
    func configrueCell(viewModel: OrderItemVM) {
        self.ItemCountLbl.text = viewModel.quantity
        self.ItemNameLbl.text = viewModel.name
    }
    
}
