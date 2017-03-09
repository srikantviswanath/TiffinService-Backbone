//
//  OrderItemVM.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/8/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation

struct OrderItemVM {
    
    var model: OrderItem!
    var itemID: String!
    var name: String!
    var price: String!
    var quantity: String!
    var instructions: String!
    var itemTotal: String {
        return "$" + "\(self.model.price * self.model.quantity)"
    }
    
    ///For creating instances after fetching underlying model from network
    init(orderItem: OrderItem) {
        self.model = orderItem
        self.itemID = orderItem.itemID
        self.name = orderItem.name
        self.price = "$" + "\(orderItem.price)"
        self.quantity = "\(orderItem.quantity)"
        self.instructions = orderItem.instructions
    }
    
    
    init(menuItemVM: MenuInventoryVM, quantity: Int, instructions: String = "") {
        self.itemID = menuItemVM.itemID
        self.name = menuItemVM.name
        self.price = menuItemVM.price
        self.quantity = "\(quantity)"
        self.instructions = instructions
        self.model = OrderItem(menuItem: menuItemVM.model, quantity: quantity)
    }
}

struct OrderVM {
    
    static var networkDelegate = OrderNetworker.self
    
    var userId: String!
    var userName: String!
    var orderTime: String!
    var containees: [OrderItemVM]!
    var model: Order!
    
    ///For creating instance after fetching underlying model form network
    init(order: Order) {
        self.userId = order.userId
        self.userName = order.userName
        self.orderTime = order.orderTime
        self.containees = order.containees.map {OrderItemVM(orderItem: $0)}
        self.model = order
    }
    
    /// For creating instance from UI
    init(userId: String, userName: String, orderTime: String, orderItemVMs: [OrderItemVM]) {
        self.userId = userId
        self.userName = userName
        self.orderTime = orderTime
        var orderItems = [OrderItem]()
        for orderItemVM in orderItemVMs {
            orderItems.append(orderItemVM.model)
        }
        self.model = Order(userId: userId, userName: userName, orderTime: orderTime, orderItems: orderItems)
        
    }
    func writeToDB(update: Bool = false, completed: @escaping () -> ()) {
        type(of: self).networkDelegate.writeToDB(order: self.model, completed: completed)
    }
}

