//
//  OrderPlaced.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/26/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderItem: Mappable {

    var inventoryId: String!
    var name: String!
    var price: Int!
    var quantity: Int!
    var instructions: String?
    
    
    required init?(map: Map) {}
    
    init(menuItem: MenuInventoryItem, quantity: Int, instructions:String="") {
        self.inventoryId = menuItem.id
        self.name = menuItem.name
        self.price = menuItem.price
        self.quantity = quantity
        self.instructions = instructions
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
    var orderItems: [OrderItem]!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.userName <- map["UserName"]
        self.orderTime <- map["OrderTime"]
        
    }
    
    init(userId: String, userName: String, orderTime: String, orderItems: [OrderItem]) {
        self.userId = userId
        self.userName = userName
        self.orderTime = orderTime
        self.orderItems = orderItems
    }
}
