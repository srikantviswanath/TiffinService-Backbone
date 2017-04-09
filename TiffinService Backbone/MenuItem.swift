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
    
    var itemID: String!
    var name: String!
    var price: Int!
    var description: String!
    var customOptions: String!
    
    init(name: String, desc: String, price: Int, customOptions: String="") {
        self.name = name
        self.price = price
        self.description = desc
        self.customOptions = customOptions
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.name <- map["Name"]
        self.description <- map["Description"]
        self.price <- map["Price"]
        self.customOptions <- map["CustomOptions"]
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
