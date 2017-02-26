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
    
    func configureCell(menuItem: MenuItem){
        self.ItemName.text = menuItem.name
        self.ItemDescription.text = menuItem.description
        self.ItemPrice.text = "$" + "\(menuItem.price!)"
    }
}
