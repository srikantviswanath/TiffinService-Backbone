//
//  MenuForClientVC.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/27/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//
import UIKit

class MenuForClientVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkDelegate {
    
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var orderTotalLbl: UILabel!
    
    var publishedMenuNetworker = PublishedMenuNetworker()
    var orderItemNetworker = OrderItemNetworker()
    var orderNetworker = OrderNetworker()
    var transactionNetworker = TransactionNetworker()
    var balanceNetworker = BalanceNetworker()
    
    var dataSource = [OrderItemVM]()
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self
        self.orderTotalLbl.text = "$0"
        self.publishedMenuNetworker.delegate = self
        self.publishedMenuNetworker.getMenu()
    }
    
    @IBAction func SubmitOrder(sender: UIButton) {
        let userId = USER
        let orderVM = OrderVM(userId: userId, userName: "PullaRao, M", orderTime: getCurrentTime(), orderDate: getCurrentDate(), orderItemVMs: self.dataSource)
        orderNetworker.writeToDB(viewModel: orderVM) {
            let transactionVM = TransactionVM(amount: self.orderTotalLbl.text!, type: "ORDER", userId: userId)
            self.transactionNetworker.writeToDB(viewModel: transactionVM) {
                BalanceNetworker.getBalancePerUser(userId: userId, userFN: "PullaRao", userLN: "Meka") { balanceVM in
                    balanceVM.updateBalance(newDeltaQty: self.orderTotalLbl.text!)
                    balanceVM.writeToDB()
                }
            }
        }
        orderItemNetworker.writeToDB(viewModels: orderVM.containees)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = menuTable.dequeueReusableCell(withIdentifier: "MenuItemForClient") as? OrderConfirmCell{
            let currentViewModel = self.dataSource[indexPath.row]
            cell.viewModelDelegate = currentViewModel
            cell.viewControllerDelegate = self
            cell.configureCell(orderItemVM: currentViewModel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func didFinishNetworkCall() {
        let menuItemVMs = self.publishedMenuNetworker.viewModelsFetched[0].containees
        for item in menuItemVMs! {
            self.dataSource.append(OrderItemVM(menuItemVM: item, quantity: 0))
        }
        self.menuTable.reloadData()
    }
}
