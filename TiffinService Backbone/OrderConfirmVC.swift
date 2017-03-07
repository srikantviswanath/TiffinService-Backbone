//
//  OrderConfirmVC.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/5/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import UIKit

class OrderConfirmVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var orderConfirmTable: UITableView!
    
    var orderItemsList: [OrderItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderConfirmTable.delegate = self
        orderConfirmTable.dataSource = self
    }
    
    @IBAction func OrderPlacedBtnPressed(sneder: UIButton) {
        let order = Order(userId: "userId102", userName: "PullaRao, J", orderTime: "10:30 AM", orderItems: orderItemsList)
        OrderNetworker.writeToDB(order: order) {
            print("Order Placed")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = orderConfirmTable.dequeueReusableCell(withIdentifier: "OrderConfirmCell") as? OrderConfirmCell{
            cell.configureCell(orderItem: orderItemsList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }

    }
    
    
}
