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


class MenuInventoryItem: MenuItemCore, Mappable {
    
    static var networkDelegate = MenuItemNetworker.self
    
    var description: String!
    
    init(name: String, desc: String, price: Int) {
        self.description = desc
        super.init(name: name, price: price)
    }
    
    required init?(map: Map) {
        super.init(name: "", price: 0)
    }
    
    func mapping(map: Map) {
        self.name <- map["Name"]
        self.description <- map["Description"]
        self.price <- map["Price"]
    }
}

class PublishedMenu {
    
    static var networkDelegate = PublishedMenuNetworker.self
    
    var publishDate: String!
    var containees: [MenuInventoryItem]!
    
    init(publishDate: String, menuItems: [MenuInventoryItem]) {
        self.publishDate = publishDate
        self.containees = menuItems
    }
}
