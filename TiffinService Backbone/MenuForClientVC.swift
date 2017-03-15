//
//  MenuForClientVC.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/27/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//
import UIKit

class MenuForClient: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTable: UITableView!
    
    var menuList = [MenuInventoryVM]()
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self
        PublishedMenuVM.getMenu() { publishedMenuVM in
            self.menuList = publishedMenuVM.containees
            self.menuTable.reloadData()
        }
        
    }
    
    @IBAction func SubmitOrder(sender: UIButton) {
        performSegue(withIdentifier: "OrderConfirm", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = menuTable.dequeueReusableCell(withIdentifier: "MenuItemForClient") as? MenuItemCell{
            cell.configureCell(menuItemVM: menuList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderConfirm" {
            if let destVC = segue.destination as? OrderConfirmVC {
                var orderItems = [OrderItemVM]()
                for item in menuList {
                    orderItems.append(OrderItemVM(menuItemVM: item, quantity: 0))
                }
                destVC.orderItemVMsList = orderItems
            }
        }
    }
}
