//
//  OrderItemService.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/5/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

struct OrderNetworker {
    
    static var REF_ORDERS = FIRDatabase.database().reference().child("Orders")
    static var REF_ORDERS_TODAY = REF_ORDERS.child(getCurrentDate())
    
    func getAllForDay() {
        
    }
    
    static func writeToDB(order: Order, completed: @escaping () -> ()) {
        var dataToWrite = [String: Any]()
        var ordersPlaced = [String: Any]()
        for orderItem in order.orderItems {
            let orderItemJSON = Mapper().toJSON(orderItem)
            ordersPlaced[orderItem.inventoryId] = orderItemJSON
        }
        var orderJSON = Mapper().toJSON(order)
        orderJSON["ItemsOrdered"] = ordersPlaced
        dataToWrite[order.userId] = orderJSON
        REF_ORDERS_TODAY.updateChildValues(dataToWrite) { _, _ in completed()}
    }
    
}
