//
//  MenuItem.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/22/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import Firebase

class MenuItem {
    static var REF = FIRDatabase.database().reference().child("MenuItems")
    private var id: String!
    private var name: String!
    private var description: String!
    private var price: Int!
    
    init(id: String, name: String, desc: String, price: Int) {
        self.id = id
        self.name = name
        self.description = desc
        self.price = price
    }
    
    static func getAll() -> [MenuItem]{
        var menuItemsFetched = [MenuItem]()
        REF.observeSingleEvent(of: .value, with: { menuItemsSS in
            if let menuItems = menuItemsSS.children.allObjects as? [FIRDataSnapshot] {
                for menuItem in menuItems {
                    menuItemsFetched.append(MenuItem(menuItem))
                }
            }
        })
        return menuItemsFetched
    }
}
