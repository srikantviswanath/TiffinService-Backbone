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


class MenuInventoryItem: Mappable {
    
    static var networkDelegate = MenuItemNetworker.self
    
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
}

class PublishedMenu {
    
    static var networkDelegate = PublishedMenuNetworker.self
    
    var publishDate: String!
    var menuItems: [MenuInventoryItem]!
    
    init(publishDate: String, menuItems: [MenuInventoryItem]) {
        self.publishDate = publishDate
        self.menuItems = menuItems
    }
}
