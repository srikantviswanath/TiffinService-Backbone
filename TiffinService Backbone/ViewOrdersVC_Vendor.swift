//
//  ViewOrdersVC_Vendor.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/21/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import UIKit

class ViewOrdersVC_Vendor: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ordersByCustomersTable: UITableView!
    
    var ordersByCustomers = [OrderVM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersByCustomersTable.delegate = self
        ordersByCustomersTable.dataSource = self
        OrderVM().getAllByPeople(for: "03-20-2017") { orderVM in
            self.ordersByCustomers.append(orderVM)
            self.ordersByCustomersTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ordersByCustomers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.ordersByCustomersTable.dequeueReusableCell(withIdentifier: "OrdersByCustomers") as? OrderReceivedByPeopleCell {
            cell.configureCell(orderVM: ordersByCustomers[indexPath.row])
            return cell
        } else {
           return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
