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
    @IBOutlet weak var orderTotalLbl: UILabel!
    
    var orderItemVMsList: [OrderItemVM]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderConfirmTable.delegate = self
        orderConfirmTable.dataSource = self
        self.orderTotalLbl.text = "$0"
    }
    
    @IBAction func OrderPlacedBtnPressed(sneder: UIButton) {
        let userId = "userId104"
        let orderVM = OrderVM(userId: userId, userName: "PullaRao, M", orderTime: getCurrentTime(), orderItemVMs: orderItemVMsList)
        orderVM.writeToDB {
            let transactionVM = TransactionVM(amount: self.orderTotalLbl.text!, type: "ORDER", userId: userId)
            transactionVM.writeToDB()
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
            let viewModel = orderItemVMsList[indexPath.row]
            cell.viewControllerDelegate = self
            cell.viewModelDelegate = viewModel
            cell.configureCell(orderItemVM: viewModel)
            return cell
        } else {
            return UITableViewCell()
        }

    }
    
    
}
