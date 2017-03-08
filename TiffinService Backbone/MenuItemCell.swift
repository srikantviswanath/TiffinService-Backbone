//
//  File.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/26/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import UIKit

class MenuItemCell:  UITableViewCell{
    
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemDescription: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    
    func configureCell(menuItemVM: MenuInventoryVM){
        self.ItemName.text = menuItemVM.name
        self.ItemDescription.text = menuItemVM.description
        self.ItemPrice.text = menuItemVM.price
    }
}
