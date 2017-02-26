//
//  MenuItem.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/22/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper


class MenuItem: Mappable {
    static var REF_INVENTORY = FIRDatabase.database().reference().child("MenuItems")
    var id: String!
    var name: String!
    var description: String!
    var price: Int!
    
   init(name: String, desc: String, price: Int) {

        self.name = name
        self.description = desc
        self.price = price
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["Name"]
        description <- map["Description"]
        price <- map["Price"]
    }
    
    static func getAll(before completion: @escaping ([MenuItem]) -> ()) {
        var menuItemsFetched = [MenuItem]()
        REF_INVENTORY.observeSingleEvent(of: .value, with: { menuItemsSS in
            if let jsonItems = menuItemsSS.children.allObjects as? [FIRDataSnapshot] {
                for jsonItem in jsonItems {
                    let menuItem = Mapper<MenuItem>().map(JSON: jsonItem.value as! [String: Any])!
                    menuItem.id = jsonItem.key
                    menuItemsFetched.append(menuItem)
                }
                completion(menuItemsFetched)
            }
        })
    }
    
    /**
     A generic instance method for writing an instance of MenuItem class to Firebase, by
     converting to JSON.
     :update: if set to true indicates updating a pre-existing node at Firebase
    */
    func writeToDB(is update:Bool=false, completed: @escaping ()->()) {
        let jsonItem = Mapper().toJSON(self)
        if !update {
            let newMenuItemRef = MenuItem.REF_INVENTORY.childByAutoId()
            self.id = newMenuItemRef.key
            newMenuItemRef.updateChildValues(jsonItem) {_,_ in completed()}
        } else {
            MenuItem.REF_INVENTORY.child(self.id).updateChildValues(jsonItem) { _, _ in completed()}
        }
    }
}

class PublishedMenu {
    
    static var REF_PUBLISHED = FIRDatabase.database().reference().child("PublishedMenu")
    static var REF_PUBLISHED_TODAY = PublishedMenu.REF_PUBLISHED.child(getCurrentDate()) //Replace it with current date string
    var publishDate: String!
    var menuItems: [MenuItem]!
    
    init(publishDate: String, menuItems: [MenuItem]) {
        self.publishDate = publishDate
        self.menuItems = menuItems
    }
    
    /**
     Method to write an instance of PublishedMenu to Firebase. It is always writen to today's date child node
    */
    func writeToDB(is update:Bool=false, completed: @escaping ()->()) {
        var dataToWrite = [String: Any]()
        for menuItem in self.menuItems {
            dataToWrite[menuItem.id] = Mapper().toJSON(menuItem)
        }
        PublishedMenu.REF_PUBLISHED_TODAY.updateChildValues(dataToWrite) {_, _ in completed()}
    }
    
    
}
