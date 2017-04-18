//
//  OrdersByItemVC_Vendor.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 4/18/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import UIKit

class OrdersByItemVC_Vendor: UIViewController, NetworkDelegate {
    
    @IBOutlet weak var OrdersByItemTable: UITableView!
    
    var networker = OrderItemNetworker()
    var dataSource = [OrderItemVM]()

    override func viewDidLoad() {
        super.viewDidLoad()
        /*self.OrdersByItemTable.dataSource = self
        self.OrdersByItemTable.delegate = self*/
        self.networker.delegate = self
    }
    
    func didFinishNetworkCall() {
        self.dataSource = self.networker.viewModelsFetched
        self.OrdersByItemTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.OrdersByItemTable.dequeueReusableCell(withIdentifier: "OrdersByItemCell") as?  {
            
        }
    }*/
}
