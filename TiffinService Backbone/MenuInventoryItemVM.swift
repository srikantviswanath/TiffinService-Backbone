//
//  MenuInventoryItemViewModel.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/6/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation

class MenuInventoryVM {
    
    var itemID: String!
    var name: String!
    var price: String!
    var description: String!
    var model: MenuInventoryItem!
    
    ///For creating instances after fetching underlying model from network
    init(menuInvItem: MenuInventoryItem) {
        self.name = menuInvItem.name
        self.price = "$" + "\(menuInvItem.price!)"
        self.description = menuInvItem.description
        self.model = menuInvItem
        self.itemID = menuInvItem.itemID == nil ? "0": menuInvItem.itemID
        
    }
    
    ///For creating an instance form the UI
    init(name: String, price: Int, description: String) {
        self.name = name
        self.price = "$" + "\(price)"
        self.description = description
        self.model = MenuInventoryItem(name: name, desc: description, price: price)
    }
}

class PublishedMenuVM {
    
    var publishDate: String!
    var model: PublishedMenu!
    var containees: [MenuInventoryVM]!
    
    ///For creating instances after fetching underlying model from network
    init(publishedMenu: PublishedMenu) {
        self.publishDate = publishedMenu.publishDate
        self.containees = publishedMenu.containees.map {MenuInventoryVM(menuInvItem: $0)}
        self.model = publishedMenu
    }
    
    ///For creating an instance form the UI
    init(pubDate: String, menuItemVMs: [MenuInventoryVM]) {
        self.publishDate = pubDate
        self.containees = menuItemVMs
        var menuItems = [MenuInventoryItem]()
        for vm in menuItemVMs {
            menuItems.append(vm.model)
        }
        self.model = PublishedMenu(publishDate: pubDate, menuItems: menuItems)
    }
}
