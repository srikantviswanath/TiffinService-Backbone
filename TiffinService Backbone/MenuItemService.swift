//
//  MenuItem_Parser.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/27/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

func parseMenuItemsSnapshot(menuItemsSS: FIRDataSnapshot) -> [MenuInventoryItem]{
    var menuItemObjsFetched = [MenuInventoryItem]()
    if let jsonItems = menuItemsSS.children.allObjects as? [FIRDataSnapshot] {
        for jsonItem in jsonItems {
            let menuItem = Mapper<MenuInventoryItem>().map(JSON: jsonItem.value as! [String: Any])!
            menuItem.itemID = jsonItem.key
            menuItemObjsFetched.append(menuItem)
        }
    }
    return menuItemObjsFetched
}

struct MenuItemNetworker {
    
    static var REF_INVENTORY = FIRDatabase.database().reference().child("MenuItems")
    
    static func getAll(completion: @escaping ([MenuInventoryItem]) -> ()) {
        REF_INVENTORY.observeSingleEvent(of: .value, with: { menuItemsSS in
            let menuItemsFetched = parseMenuItemsSnapshot(menuItemsSS: menuItemsSS)
            completion(menuItemsFetched)
        })
    }
    
    /**
     method for writing an instance of MenuItem class to Firebase, by
     converting to JSON.
     :update: if set to true indicates updating a pre-existing node at Firebase
     */
    static func writeToDB(menuItem: MenuInventoryItem, is update:Bool=false, completed: @escaping ()->()) {
        let jsonItem = Mapper().toJSON(menuItem)
        if !update {
            let newMenuItemRef = MenuItemNetworker.REF_INVENTORY.childByAutoId()
            menuItem.itemID = newMenuItemRef.key
            newMenuItemRef.updateChildValues(jsonItem) {_,_ in completed()}
        } else {
            REF_INVENTORY.child(menuItem.itemID).updateChildValues(jsonItem) { _, _ in completed()}
        }
    }

}

struct PublishedMenuNetworker {
    
    static var REF_PUBLISHED = FIRDatabase.database().reference().child("PublishedMenu")
    static var REF_PUBLISHED_TODAY = PublishedMenuNetworker.REF_PUBLISHED.child(getCurrentDate())
    
    static func getMenu(for date:String=getCurrentDate(), completed: @escaping (PublishedMenu) -> ()) {
        REF_PUBLISHED.child(date).observe(.value, with: { publishedMenuSS in
            let menuItems = parseMenuItemsSnapshot(menuItemsSS: publishedMenuSS)
            let publishedMenuObj = PublishedMenu(publishDate: date, menuItems: menuItems)
            completed(publishedMenuObj)
        })
    }
    
    /**
     Method to write an instance of PublishedMenu to Firebase. It is always writen to today's date child node
     */
    static func writeToDB(publishedMenu: PublishedMenu, is update:Bool=false, completed: @escaping ()->()) {
        var dataToWrite = [String: Any]()
        for menuItem in publishedMenu.menuItems {
            dataToWrite[menuItem.itemID] = Mapper().toJSON(menuItem)
        }
        REF_PUBLISHED_TODAY.updateChildValues(dataToWrite) {_, _ in completed()}
    }

    
    
}
