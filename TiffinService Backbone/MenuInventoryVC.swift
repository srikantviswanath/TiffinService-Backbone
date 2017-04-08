//
//  MenuInventoryVC.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/24/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import UIKit

class MenuInventoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkDelegate {
    
    var networker = MenuItemNetworker()

    @IBOutlet weak var inventoryTable: UITableView!
    
    var dataSource = [MenuInventoryVM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inventoryTable.delegate = self
        inventoryTable.dataSource = self
        self.networker.delegate = self
        self.networker.getAll()

    }
    
    func didFinishNetworkCall() {
        self.dataSource = self.networker.viewModelsFetched
        self.inventoryTable.reloadData()
    }
    
    @IBAction func uploadItemBtnClicked(sender: UIButton) {
        performSegue(withIdentifier: "InventoryToUpload", sender: nil)
    }
    
    @IBAction func publishMenuBtnClicked(sender: UIButton) {
        let publishedMenuVM = PublishedMenuVM(pubDate: getCurrentDate(), menuItemVMs: Array(self.dataSource[2...8])) //Replace with vendor selected menu
        publishedMenuVM.writeToDB() {
            print("Items published")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = inventoryTable.dequeueReusableCell(withIdentifier: "MenuItemCell") as? MenuItemCell{
            cell.configureCell(menuItemVM: dataSource[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
