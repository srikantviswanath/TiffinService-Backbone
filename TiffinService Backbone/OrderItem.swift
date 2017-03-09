//
//  OrderPlaced.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/26/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderItem: MenuItemCore, Mappable {

    var quantity: Int!
    var instructions: String?
    
    init(menuItem: MenuInventoryItem, quantity: Int, instructions:String="") {
        super.init(name: menuItem.name, price: menuItem.price)
        self.itemID = menuItem.itemID
        self.quantity = quantity
        self.instructions = instructions
    }
    
    required init?(map: Map) {
        super.init(name: "", price: 0)
    }
    
    func mapping(map: Map) {
        self.name <- map["Name"]
        self.price <- map["Price"]
        self.quantity <- map["Quantity"]
        self.instructions <- map["Instructions"]
    }
}

class Order: Mappable {
    
    static var networkDelegate = OrderNetworker.self
    
    var userId: String!
    var userName: String!
    var orderTime: String!
    var containees: [OrderItem]!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.userName <- map["UserName"]
        self.orderTime <- map["OrderTime"]
        
    }
    
    init(userId: String, userName: String, orderTime: String, orderItems: [OrderItem]) {
        self.userId = userId
        self.userName = userName
        self.orderTime = orderTime
        self.containees = orderItems
    }
}
