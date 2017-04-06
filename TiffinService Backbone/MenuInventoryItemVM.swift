//
//  MenuInventoryItemViewModel.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/6/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation

class MenuInventoryVM {
    
    var networker = MenuItemNetworker()
    
    var model: MenuInventoryItem!
    var itemID: String!
    var name: String!
    var price: String!
    var description: String!
    
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
    
    ///CAUTION: Used internally as a placeholder for invoking any instance methods. Be very careful while calling this
    convenience init() {
        self.init(name: "DORMANT", price: 0, description: "")
    }
    
    func getAll(completed: @escaping ([MenuInventoryVM]) -> ()) {
        self.networker.getAll() { menuItemModels in
            var menuItemVMs = [MenuInventoryVM]()
            for menuItem in menuItemModels {
                menuItemVMs.append(MenuInventoryVM(menuInvItem: menuItem))
            }
            completed(menuItemVMs)
        }
    }
    
    func writeToDB(is update:Bool=false, completed: @escaping ()->()) {
        self.networker.writeToDB(model: self.model, is: update, completed: completed)
    }
}

class PublishedMenuVM {
    
    var networker = PublishedMenuNetworker()
    
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
    
    ///CAUTION: Used internally as a placeholder for invoking any instance methods. Be very careful while calling this
    convenience init() {
        self.init(pubDate: "", menuItemVMs: [MenuInventoryVM]())
    }
    
    func getMenu(completed: @escaping (PublishedMenuVM) -> ()) {
        self.networker.getMenu() { publishedMenu in
            let publishedMenuVM = PublishedMenuVM(publishedMenu: publishedMenu)
            completed(publishedMenuVM)
        }
    }
    
    func writeToDB(update: Bool = false, completed: @escaping () -> ()) {
        self.networker.writeToDB(model: self.model, is: update, completed: completed)
    }
}
