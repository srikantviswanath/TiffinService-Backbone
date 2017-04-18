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

let USER = "user111"

class OrderItemNetworker {
    static var _REF = "OrderItems"
    static var REF_ORDER_ITEMS = FIRDatabase.database().reference().child(_REF)
    static var REF_ORDER_ITEMS_TODAY = REF_ORDER_ITEMS.child(getCurrentDate())
    
    var delegate: NetworkDelegate?
    var viewModelsFetched = [OrderItemVM]()
    
    /**
     Method to write an array of orderItemVM to Firebase. Since this is a candidate for concurrency,
     using transaction block for write of each orderItem
     :initialize: If true, will setup OrderItem node with today's items with count=0
    */
    func writeToDB(viewModels: [OrderItemVM], initialize:Bool = false) {
        if initialize {
            _initOrderItems(viewModels: viewModels)
        } else {
            for viewModel in viewModels {
                let newItemQty = Int(viewModel.quantity)
                //let orderItemRef = OrderNetworker.REF_ORDERS_TODAY
                let orderItemRef = OrderItemNetworker.REF_ORDER_ITEMS_TODAY.child(viewModel.itemID)
                orderItemRef.runTransactionBlock({(currentData: FIRMutableData) -> FIRTransactionResult in
                    if var orderItemVal = currentData.value as? [String: AnyObject] {
                        var users = orderItemVal["Users"] as? [String : Int] ?? [:]
                        var itemCount: Int = orderItemVal["Count"] as? Int ?? 0
                        if let existingUserCount = users[USER] { //TODO: Take care of the case where an order was edited with an item missing
                            itemCount = itemCount - existingUserCount + newItemQty!
                        } else {
                            itemCount += Int(viewModel.quantity)!
                        }
                        users[USER] = newItemQty
                        orderItemVal["Count"] = itemCount as AnyObject?
                        orderItemVal["Users"] = users as AnyObject?
                        currentData.value = orderItemVal
                        return FIRTransactionResult.success(withValue: currentData)
                    }
                    return FIRTransactionResult.success(withValue: currentData)
                }) {(error, commited, snapshot) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

        }
    }
    
    func _initOrderItems(viewModels: [OrderItemVM]) {
        var orderItemsForToday = [String: Any]()
        for vm in viewModels {
            var orderItemJSON = Mapper().toJSON(vm.model)
            orderItemJSON.removeValue(forKey: "Price")
            orderItemJSON.removeValue(forKey: "Instructions")
            orderItemJSON["Users"] = [String: Int]()
            orderItemsForToday[vm.itemID] = orderItemJSON
        }
        OrderItemNetworker.REF_ORDER_ITEMS_TODAY.updateChildValues(orderItemsForToday)
    }
}

class OrderNetworker {
    static var _REF = "Orders"
    static var REF_ORDERS = FIRDatabase.database().reference().child(_REF)
    static var REF_ORDERS_TODAY = REF_ORDERS.child(getCurrentDate())
    
    //TODO: BAD CODE. Refactor/reuse somehow!!
    func getAllByPeople(date: String, completed: @escaping (Order) -> ()) {
        OrderNetworker.REF_ORDERS.child(date).observe(.childAdded, with: {orderSS in
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
    
    func writeToDB(viewModel: OrderVM, completed: @escaping () -> ()) {
        var dataToWrite = [String: Any]()
        var ordersPlaced = [String: Any]()
        for orderItem in viewModel.model.containees {
            let orderItemJSON = Mapper().toJSON(orderItem)
            ordersPlaced[orderItem.itemID] = orderItemJSON
        }
        var orderJSON = Mapper().toJSON(viewModel.model)
        orderJSON["ItemsOrdered"] = ordersPlaced
        dataToWrite[viewModel.model.userId] = orderJSON
        OrderNetworker.REF_ORDERS_TODAY.updateChildValues(dataToWrite) { _, _ in completed()}
    }
    
}
