//
//  MenuInventoryVC.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/24/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import UIKit

class MenuInventoryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MenuItem.getAll(){ menuItems in
            print(menuItems[0].id)
        }
    }
}
