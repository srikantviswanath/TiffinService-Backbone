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
    
    //TODO: BAD CODE. Refactor/reuse somehow!!
    static func getAllByPeople(date: String, completed: @escaping (Order) -> ()) {
        REF_ORDERS.child(date).observe(.childAdded, with: {orderSS in
            var orderItemObjs = [OrderItem]()
            if let orderContents = orderSS.children.allObjects as? [FIRDataSnapshot] {
                for child in orderContents {
                    if child.key == "ItemsOrdered" {
                        if let orderItems = child.children.allObjects as? [FIRDataSnapshot] {
                            for item in orderItems {
                                let orderItem = Mapper<OrderItem>().map(JSON: item.value as! [String : Any])!
                                orderItem.itemID = item.key
                                orderItemObjs.append(orderItem)
                            }
                        }
                    }
                }
            }
            let order = Mapper<Order>().map(JSON: orderSS.value as! [String : Any])!
            order.userId = orderSS.key
            order.containees = orderItemObjs
            completed(order)
        })
    }
    
    static func writeToDB(order: Order, completed: @escaping () -> ()) {
        var dataToWrite = [String: Any]()
        var ordersPlaced = [String: Any]()
        for orderItem in order.containees {
            let orderItemJSON = Mapper().toJSON(orderItem)
            ordersPlaced[orderItem.itemID] = orderItemJSON
        }
        var orderJSON = Mapper().toJSON(order)
        orderJSON["ItemsOrdered"] = ordersPlaced
        dataToWrite[order.userId] = orderJSON
        REF_ORDERS_TODAY.updateChildValues(dataToWrite) { _, _ in completed()}
    }
    
}
