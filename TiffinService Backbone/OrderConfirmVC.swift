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
    
    var orderItemVMsList: [OrderItemVM]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderConfirmTable.delegate = self
        orderConfirmTable.dataSource = self
    }
    
    @IBAction func OrderPlacedBtnPressed(sneder: UIButton) {
        let orderVM = OrderVM(userId: "userId103", userName: "JaggaRao, M", orderTime: getCurrentTime(), orderItemVMs: orderItemVMsList)
        orderVM.writeToDB {
            print("Order Placed")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItemVMsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = orderConfirmTable.dequeueReusableCell(withIdentifier: "OrderConfirmCell") as? OrderConfirmCell{
            cell.configureCell(orderItemVM: orderItemVMsList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }

    }
    
    
}
